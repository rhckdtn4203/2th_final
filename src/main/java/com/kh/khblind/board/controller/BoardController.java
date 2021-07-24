package com.kh.khblind.board.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.khblind.admin.category.entity.CategoryDto;
import com.kh.khblind.admin.category.repository.CategoryDao;
import com.kh.khblind.board.entity.BoardCategoryBoardDto;
import com.kh.khblind.board.entity.BoardCategoryGroupDto;
import com.kh.khblind.board.entity.BoardDto;
import com.kh.khblind.board.entity.BoardEditGetInfoVO;
import com.kh.khblind.board.entity.BoardLikeDto;
import com.kh.khblind.board.entity.BoardMemberVO;
import com.kh.khblind.board.entity.BoardWriteFullVO;
import com.kh.khblind.board.entity.BoardWriteVO;
import com.kh.khblind.board.entity.CheckBoardTypeDto;
import com.kh.khblind.board.entity.CommentsVO;
import com.kh.khblind.board.entity.CompanyBoardDto;
import com.kh.khblind.board.entity.CompanyGroupDto;
import com.kh.khblind.board.entity.HashtagLinkDto;
import com.kh.khblind.board.entity.JobCategoryBoardDto;
import com.kh.khblind.board.entity.JobCategoryGroupDto;
import com.kh.khblind.board.repository.BoardDao;
import com.kh.khblind.board.repository.BoardLikeDao;
import com.kh.khblind.board.repository.CommentDao;
import com.kh.khblind.board.uploadImage.repository.UploadImageDao;
import com.kh.khblind.board.uploadImage.vo.ConvertImageVo;
import com.kh.khblind.board.vote.entity.VoteInsertInfoVo;
import com.kh.khblind.board.vote.entity.VoteTopicDto;
import com.kh.khblind.board.vote.repository.VoteDao;
import com.kh.khblind.member.entity.MemberDto;
@RequestMapping("/board")
@Controller
public class BoardController {
	
	@Autowired
	private BoardDao boardDao;
	
	@Autowired
	private UploadImageDao  uploadImageDao;
	
	@Autowired
	private VoteDao voteDao;
	
	@Autowired
	private CategoryDao categoryDao;
	
	@Autowired
	private CommentDao commentDao;
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private BoardLikeDao boardLikeDao;
	
	@GetMapping("/boardWrite")
	public String boardWrite(Model model) {
		
		List<CategoryDto> categoryDtoList = categoryDao.list();
		model.addAttribute("categoryList", categoryDtoList);
		
		return "board/boardWrite";
	}
	
	@PostMapping("/boardWrite")
	public String boardWrite(
			//준비 : DB조회 1개(시퀀스번호) + 세션 1개(회원번호) + 파라미터 3개(제목,내용,해시태그)
			
		HttpSession session,	
		@ModelAttribute BoardWriteFullVO boardWriteFullVO
		) throws IOException {
		/*
		 * 아래와 같은 순서로 진행된다.
		 * 1.재료모으기
		 * 2.등록
		 * 3.그룹등록 
		 */
		
		System.out.println(boardWriteFullVO);
		
		//재료 모으기1-1. 회원번호
		MemberDto memberDto = (MemberDto)session.getAttribute("dtoss");
		int memberNo = memberDto.getMemberNo();		
		//재료 모으기1-2. 글번호
		int boardNo = boardDao.getSequence();
		
		//등록2-1-1. 게시글 등록
		BoardDto boardDto = BoardDto.builder()
									.boardNo(boardNo)
									.memberNo(memberNo)
									.boardTitle(boardWriteFullVO.getBoardTitle())
									.boardContent(boardWriteFullVO.getBoardContent())
									.build();
		boardDao.insert(boardDto);
		
		//등록2-1-2.해시태그 등록
		//해시태그 insert
		List<String> hashtagList = new ArrayList<>();
		BoardWriteVO boardWriteVO =  BoardWriteVO.builder()
													.hashtagNo(boardWriteFullVO.getHashtagNo())
													.hashtagName(boardWriteFullVO.getHashtagName())
													.boardContent(boardWriteFullVO.getBoardContent())
													.boardNo(boardNo)
													.build();
		hashtagList = boardDao.getHash(boardWriteVO);

		List<Integer> hashtagNumList = boardDao.getHashNum(hashtagList);
		List<HashtagLinkDto> hashtagLinklist = new ArrayList<HashtagLinkDto>();
		for (int hashtagNo : hashtagNumList) {
			HashtagLinkDto hashtagLinkDto = HashtagLinkDto.builder().boardNo(boardNo).hashtagNo(hashtagNo).build();

			hashtagLinklist.add(hashtagLinkDto);
		}
		boardDao.insertHashlink(hashtagLinklist);
		
		//등록2-2. 이미지 등록(이미지가 있으면)
		if(boardWriteFullVO.getImages().get(0).getOriginalFilename() !="") {
			//2-2-1. 단순 업로드를 하면서 파일이름 리스트를 내뱉는다.
			List<MultipartFile> images = boardWriteFullVO.getImages();
			
			List<String> fileNameList = uploadImageDao.uploadOriginalFile(images, memberNo);
			if(fileNameList==null) {return "/board/파일업로드실패/이유는-서버에업로드가되지않음";}	
			
			//2-2-2. 1에서 받은 리스트를 활용하여 각 이미지의 로테이션 번호로 회전해야할 각도 리스트를 가져온다.
			List<Integer> rotationValueList = uploadImageDao.getRotationValue(fileNameList);
			
			//2-2-3. 폴더 이름을 미리 정한다.
			String superFolderName = uploadImageDao.getImageFolderName(boardNo);
			
			//2-2-4. 1과 2를 활용하여 파일 변환을 거친다
			ConvertImageVo convertImageVo =ConvertImageVo.builder()
															.boardNo(boardNo)
															.fileNameList(fileNameList)
															.rotationValueList(rotationValueList)
															.superFolderName(superFolderName)
															.folderName(Integer.toString(boardNo))
															.build();
			System.out.println("convertImageVo" + convertImageVo);
			
			List<String> readyFileNameList = uploadImageDao.convertImage(convertImageVo);
			
			//2-2-5. 삭제하기
			boolean deleteSuccess = uploadImageDao.deleteOrigin(convertImageVo, readyFileNameList);
			System.out.println("삭제?" + deleteSuccess);
			
			//2-2-6. 썸네일 만들기
			String firstFileFullName = readyFileNameList.get(0);
			String firstFileFinalName = firstFileFullName.replace("-ready", "");
			boolean makeThumbSuccess = uploadImageDao.makeThumb(convertImageVo, firstFileFinalName);
			System.out.println("썸네일 생성?" + makeThumbSuccess);
			
			//2-2-7. DB에 등록
		}else {System.out.println("이미지 없음");}

		
		
		//2-3.투표 등록(투표가 있다면)
		if(boardWriteFullVO.getVoteTopicOption().size()!=0 || boardWriteFullVO.getVoteTopicTitle()!=null) {
			//파라미터값들로 받은 데이터가 담긴 "voteInsertInfoVo"를 쪼갭니다.(1.투표 주제 추가에 필요한 Dto / 2.투표 선택지(들) 추가에 필요한 VO)

			//2-3-1. 투표 주제 추가
			VoteTopicDto voteTopicDto = VoteTopicDto.builder()
												.boardNo(boardNo)
												.voteTopicTitle(boardWriteFullVO.getVoteTopicTitle())
												//.voteTopicExpire(voteTopicExpire)
												.build();
												
			//투표 주제를 추가하는 기능에 활용
			voteDao.insertTopic(voteTopicDto);
			
		
			//투표 선택지(들) 추가에 필요한 VO 생성 (반복 추가) 
			int seqCurrVal = voteDao.getSeqCurrVal(); //이건 제가 필요해서 넣은 것 아마 해시태그에서는 현재 board_seq_currVal이 아닐까 싶어요

			VoteInsertInfoVo voteInsertOptionInfo = VoteInsertInfoVo.builder()
															.boardNo(boardNo)//종속된 board_no(게시글 번호)
															.voteTopicNo(seqCurrVal)//종속된 vote_topic_no
															.voteTopicOption(boardWriteFullVO.getVoteTopicOption()) //List<String> 형태
															.build();
		
			//투표 선택지(들)를 추가하는 기능에 활용
			voteDao.insertOption(voteInsertOptionInfo);
		}

		
		//3. 상황에 따라 그룹에 등록한다.

		//상황3-a. 토픽 게시글 등록(boardCategory)
		if(boardWriteFullVO.getBoardCategoryNo() != 0) {
			BoardCategoryGroupDto boardCategoryGroupDto = BoardCategoryGroupDto.builder()
																					.boardCategoryNo(boardWriteFullVO.getBoardCategoryNo())
																					.boardNo(boardNo)
																					.build();
			boardDao.boardCategoryInsert(boardCategoryGroupDto);
		}

		//상황3-b. 업종 게시글 등록(getJobCategory)
		else if(boardWriteFullVO.getJobCategoryNo() != 0) {	
			JobCategoryGroupDto jobCategoryGroupDto = JobCategoryGroupDto.builder()
																					.jobCategoryNo(boardWriteFullVO.getBoardCategoryNo())
																					.boardNo(boardNo)
																					.build();
			boardDao.jobCategoryInsert(jobCategoryGroupDto);
		}
		else{//(나머지는 기업 등록메소드가 실행되게)
		CompanyGroupDto companyGroupDto = CompanyGroupDto.builder()
																	.companyNo(boardWriteFullVO.getCompanyNo())
																	.boardNo(boardNo)
																	.build();
		boardDao.companyInsert(companyGroupDto);
		}
		return "redirect:boardDetail?boardNo="+boardNo;//상세페이지로 가면서 번호주기
		
	}
	
	//데이터가 있으면 boardDto를 반납하고, 데이터가 없으면 null을 반납
	@GetMapping("/boardDetail")
	public String boardDetail(int boardNo, Model model,HttpSession session) {
		BoardDto boardDto = boardDao.getBoardDetail(boardNo);
		BoardMemberVO boardMemberVO = boardDao.find(boardNo);
		MemberDto memberDto = (MemberDto)session.getAttribute("dtoss");
        int memberNo = memberDto.getMemberNo();
	      if(memberDto != null) {
	        
	        BoardLikeDto boardLikeDto = BoardLikeDto.builder()
	         .boardNo(boardNo)
	         .memberNo(memberNo)
	      .build();
      
      
	      	boolean isLiked=boardLikeDao.boardLikeExist(boardLikeDto);
	      	if(isLiked) {
	      		System.out.println("킹");
	          	model.addAttribute("isLiked", 1);
	      	}
	      	else {
	      		System.out.println("퀸");
	         	model.addAttribute("isLiked", 2);
	      	}

      
		List<CommentsVO> commentsList = sqlSession.selectList("comments.list",boardNo);
	      
	      model.addAttribute("commentsList", commentsList);
		model.addAttribute("boardDto", boardDto);
		model.addAttribute("boardMemberVO", boardMemberVO);

		if(boardDto != null) { //Dto가 null이 아니면

			return "/board/boardDetail";
		}
		else {
			return "글없다페이지";
		}
		
	}
		return "????";
	}

		@PostMapping("commentInsert")
		   public String commentInsert(
		         HttpSession session,
		         @RequestParam String commentContent, int boardNo) {
		       //세션 1개(회원번호)
		         MemberDto memberDto = (MemberDto)session.getAttribute("dtoss");
		         int memberNo = memberDto.getMemberNo();
		         CommentsVO commentsVO = new CommentsVO();
		         commentsVO.builder()
		                  .boardNo(boardNo)
		                  .memberNo(memberNo)
		                  .commentsContent(commentContent)
		         .build();
		         commentDao.commentInsert(commentsVO);
		      return "redirect:board/boardDetail?boardNo="+boardNo;
		   }
		   @PostMapping("nestedCommentInsert")
		   public String nestedCommentInsert(
		         HttpSession session,
		         @RequestParam String commentContent, int boardNo,int superNo
		         ) {
		       //세션 1개(회원번호)
		         MemberDto memberDto = (MemberDto)session.getAttribute("dtoss");
		         int memberNo = memberDto.getMemberNo();
		         CommentsVO commentsVO = new CommentsVO();
		         commentsVO.builder()
		                  .boardNo(boardNo)
		                  .commentsSuperNo(superNo)
		                  .memberNo(memberNo)
		                  .commentsContent(commentContent)
		         .build();
		         commentDao.nestedCommentInsert(commentsVO);
		      return "redirect:board/boardDetail?boardNo="+boardNo;	
	}
	
			@GetMapping("/boardEdit")
			public String boardEdit(int boardNo, Model model, HttpSession session) {
				//세션으로 본인의 memberNo로만 수정할 수 있게 처리해야함 (나중에)
				BoardDto boardDto = boardDao.getBoardDetail(boardNo);
				
				CheckBoardTypeDto checkBoardTypeDto = boardDao.getBoardType(boardNo);

				String boardType = ""; 
				int typeNo=0;
				String typeName ="";
				
				if(checkBoardTypeDto.getBoardCategoryNo() !=null) {
					boardType = "boardCategory";
					typeNo = checkBoardTypeDto.getBoardCategoryNo();
					typeName = boardDao.getBoardCategoryName(typeNo);
				}
				else if(checkBoardTypeDto.getJobCategoryNo() !=null) {
					boardType = "jobCategory";
					typeNo = checkBoardTypeDto.getJobCategoryNo();
					typeName = boardDao.getJobCategoryName(typeNo);
				}
				else{//(checkBoardTypeDto.getCompanyNo() !-null)
					boardType = "company";
					typeNo = checkBoardTypeDto.getCompanyNo();
					typeName = boardDao.getCompanyName(typeNo);
				}
				

		        
				BoardEditGetInfoVO boardEditGetInfoVO = BoardEditGetInfoVO.builder()
															.boardNo(boardDto.getBoardNo())
															.memberNo(boardDto.getMemberNo())
															.boardTitle(boardDto.getBoardTitle())
															.boardContent(boardDto.getBoardContent())
															.boardTypeName(boardType)
															.typeName(typeName)
															.build();
				model.addAttribute("boardEditGetInfoVO", boardEditGetInfoVO);
				return "/board/boardEdit";
			}
	
	@PostMapping("/boardEdit")
	public String boardEdit(
			//준비 : 파라미터3개(번호, 제목, 내용) + 회원번호1개(세션 = 내 글만 고칠수 있게) -> boardEditVO
			@ModelAttribute BoardDto boardDto
			) {
		int boardNo = boardDto.getBoardNo();
		boardDao.edit(boardDto);
		return "redirect:boardDetail?boardNo=" + boardNo; //수정이 완료되면 번호가 첨부된채로 상세보기로 이동
	}
	
	@GetMapping("/boardDelete")
	public String boardDelete(@RequestParam int boardNo
			//준비 : 게시글 번호.
			) {
		boardDao.delete(boardNo);
		return "redirect:/board/boardList"; //목록으로 리다이렉트
	}
	
	@GetMapping("/boardList")
	public String boardList(HttpSession session,  Model model, @RequestParam String type, @RequestParam(required = false) int boardCategoryNo) {
		MemberDto memberDto = (MemberDto)session.getAttribute("dtoss");
		//기업별 게시판 목록
		if(type.equals("companyBoard")){
			int companyNo = memberDto.getCompanyNo();	
			List<CompanyBoardDto> companyBoardList = boardDao.getCompanyBoardList(companyNo);
			model.addAttribute("companyBoardList", companyBoardList);
			
				if(companyBoardList != null) {
					return "/board/boardList";
				}
				else {
					return "글없다페이지";
				}
		}
		
		//업종별 게시판 목록
		else if(type.equals("jobCategoryBoard")) {
			int jobCategoryNo = memberDto.getJobCategoryNo();
			List<JobCategoryBoardDto> jobCategoryBoardList = boardDao.getJobCategoryBoardList(jobCategoryNo);
			model.addAttribute("jobCategoryBoardList", jobCategoryBoardList);
			
				if(jobCategoryBoardList != null) {
					return "/board/boardList";
				}
				else {
					return "글없다페이지";
				}
		}
		
		else if(type.equals("boardCategoryBoard")) {
			List<BoardCategoryBoardDto> boardCategoryBoardList =  boardDao.getBoardCategoryBoardList(boardCategoryNo);
			System.out.println("[콘] boardCategoryBoardList = " + boardCategoryBoardList);

			model.addAttribute("boardCategoryBoardList", boardCategoryBoardList);
			
				if(boardCategoryBoardList != null) {
					return "/board/boardList";
				}
				else {
					return "글없다페이지";
				}
		}
		
		//type = 이도저도 아닌거 들어올때의 경우의 수
		else {
			return "에러페이지 404";
		}
			
	}
	
	@GetMapping("boardLikeInsert")
	   public String boardLike(HttpSession session,int boardNo) {
		
		
		MemberDto memberDto = (MemberDto)session.getAttribute("dtoss");
	         int memberNo = memberDto.getMemberNo(); 
	         if(memberDto !=null) {
	         
	         BoardLikeDto boardLikeDto =BoardLikeDto.builder()
	            .boardNo(boardNo)
	            .memberNo(memberNo)
	         .build();
	         boardLikeDao.boardLike(boardLikeDto);}
	         
	         return "redirect:boardDetail?boardNo="+boardNo;
	         
	   }
	   @GetMapping("boardUnLikeInsert")
	   public String boardUnLike(int boardNo,HttpSession session) {
//		   int boardNo=boardDao.getSequence();
		   MemberDto memberDto = (MemberDto)session.getAttribute("dtoss");
	         int memberNo = memberDto.getMemberNo(); 
	         if(memberDto !=null) {
	         
	         BoardLikeDto boardLikeDto =  BoardLikeDto.builder()
	            .boardNo(boardNo)
	            .memberNo(memberNo)
	         .build();
	         boardLikeDao.boardUnlike(boardLikeDto);}
	         
	         return "redirect:boardDetail?boardNo="+boardNo;
	         
	   }
	

}
