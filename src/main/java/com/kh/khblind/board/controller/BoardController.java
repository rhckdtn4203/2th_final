package com.kh.khblind.board.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ResponseEntity;
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
import com.kh.khblind.board.entity.BoardCategoryVO;
import com.kh.khblind.board.entity.BoardCountDto;
import com.kh.khblind.board.entity.BoardDto;
import com.kh.khblind.board.entity.BoardEditGetInfoVO;
import com.kh.khblind.board.entity.BoardLikeDto;
import com.kh.khblind.board.entity.BoardMemberVO;
import com.kh.khblind.board.entity.BoardWriteFullVO;
import com.kh.khblind.board.entity.BoardWriteVO;
import com.kh.khblind.board.entity.BookmarkDto;
import com.kh.khblind.board.entity.BookmarkVO;
import com.kh.khblind.board.entity.CheckBoardTypeDto;
import com.kh.khblind.board.entity.CommentsVO;
import com.kh.khblind.board.entity.CompanyBoardDto;
import com.kh.khblind.board.entity.CompanyGroupDto;
import com.kh.khblind.board.entity.HashtagLinkDto;
import com.kh.khblind.board.entity.JobCategoryBoardDto;
import com.kh.khblind.board.entity.JobCategoryGroupDto;
import com.kh.khblind.board.repository.BoardDao;
import com.kh.khblind.board.repository.BoardLikeDao;
import com.kh.khblind.board.repository.BookmarkDao;
import com.kh.khblind.board.repository.CommentDao;
import com.kh.khblind.board.uploadImage.repository.UploadImageDao;
import com.kh.khblind.board.uploadImage.vo.ConvertImageVo;
import com.kh.khblind.board.vote.entity.VoteInsertInfoVo;
import com.kh.khblind.board.vote.entity.VoteOptionInfoVo;
import com.kh.khblind.board.vote.entity.VoteResultDto;
import com.kh.khblind.board.vote.entity.VoteTopicDto;
import com.kh.khblind.board.vote.repository.VoteDao;
import com.kh.khblind.member.entity.MemberDto;
import com.kh.khblind.search.entity.SearchDto;
import com.kh.khblind.search.repository.SearchDao;
import com.kh.khblind.member.repository.MemberDao;

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
	private MemberDao memberDao;
	
	@Autowired
	private BoardLikeDao boardLikeDao;
	
	@Autowired
	private BookmarkDao bookmarkDao;
	
	@Autowired
	private SearchDao searchDao;
	
	@GetMapping("/boardWrite")
	public String boardWrite(Model model, HttpSession session) {
		
		MemberDto memberDto = (MemberDto)session.getAttribute("dtoss");
		if(memberDto !=null) {
		List<CategoryDto> categoryDtoList = categoryDao.list();
		model.addAttribute("categoryList", categoryDtoList);
		
		return "board/boardWrite";
		}
		
		else {
		return "redirect:pleaseLogin";
		}
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
	public String boardDetail(int boardNo, Model model, HttpSession session) throws IOException {
		System.out.println("시작");
		//0. 세션에 있는 dto를 일단 가져온다.
		MemberDto memberDto =(MemberDto)session.getAttribute("dtoss");
		int memberNo;
		System.out.println("[딭] memberDto" + memberDto);
		
		
		if(memberDto !=null){
			memberNo = memberDto.getMemberNo();
			model.addAttribute("isLogin", "true");
		}
		
		else { //memberDto ==null
			memberDto = new MemberDto();
			memberNo = -1;
			model.addAttribute("isLogin", "false");
		}

		//1. 글정보를 가져와서 변환한 후 model에 싣는다.
		//1-1. 일단 기본 반찬을 가져온다.
		BoardDto boardDto;
		if(boardDao.getBoardDetail(boardNo)!=null) {
		boardDto = boardDao.getBoardDetail(boardNo);
		}
		else {
			return "글없다 페이지";
		}
	
		
		
		//1-2. 기본적으로 필요한 것을 가져온다.
		BoardMemberVO boardMemberVO = new BoardMemberVO();
		
		if(boardDao.find(boardNo)!=null) {
			boardMemberVO = boardDao.find(boardNo);
			System.out.println("[딭] boardMemberVO = "  + boardMemberVO);
		}
		else {
			boardMemberVO.setMemberNick("탈퇴한 회원");
		}
		
		//1-3-1. 내 글이 아니면 *****처리를 해준다. 
		int writerMemberNo = boardDto.getMemberNo();
		
//		if(memberNo != writerMemberNo && boardDao.find(boardNo)!=null) {
//			String memberNick = boardMemberVO.getMemberNick();
//			char firstChar = memberNick.charAt(0);
//			int nickLength = memberNick.length();
//			
//			StringBuilder stringBuilderForBlindedNick = new StringBuilder();
//			stringBuilderForBlindedNick.append(firstChar);
//			for(int i = 0; i <nickLength-1; i++) {
//				stringBuilderForBlindedNick.append("*");
//				}
//			String blindedNick = stringBuilderForBlindedNick.toString();
//			boardMemberVO.setMemberNick(blindedNick);
//		}
		
		model.addAttribute("boardMemberVO", boardMemberVO);
		//2. 분류이름을 가져오는 과정
		//2-1. 글의 분류 정보 가져온다.
		CheckBoardTypeDto checkBoardTypeDto;
		
		if(boardDao.getBoardType(boardNo)!=null) {
		checkBoardTypeDto = boardDao.getBoardType(boardNo);
		}
		else {
			checkBoardTypeDto = new CheckBoardTypeDto();
		}
		System.out.println("[딭] checkBoardTypeDto" + checkBoardTypeDto);
		
		//2-2. 껍데기를 만든다.
		String boardType = "";
		int typeNo = 0;
		String typeName = "";
		
		//2-3. 글의 분류 정보에서 null이 아닌 걸에서 타입번호를 가져오고 그걸로 문자열을 가져온다(석현에게 문의하세요)
		if(checkBoardTypeDto.getBoardCategoryNo() !=null) {
			boardType = "토픽";
			typeNo = checkBoardTypeDto.getBoardCategoryNo();
			typeName = boardDao.getBoardCategoryName(typeNo);
			
			
			//특별하게 토픽인 경우 세부 분류 이름도 보내야한다.
			String boardCaregoryName = boardDao.getBoardCategoryName(checkBoardTypeDto.getBoardCategoryNo());
			System.out.println("[딭] boardCaregoryName = " + boardCaregoryName);
			model.addAttribute("boardCaregoryName", boardCaregoryName);
		}
		else if(checkBoardTypeDto.getJobCategoryNo() !=null) {
			boardType = "내 업종";
			typeNo = checkBoardTypeDto.getJobCategoryNo();
			typeName = boardDao.getJobCategoryName(typeNo);
		}
		else if(checkBoardTypeDto.getCompanyNo() !=null) {
			boardType = "내 회사";
			typeNo = checkBoardTypeDto.getCompanyNo();
			typeName = boardDao.getCompanyName(typeNo);
		}
		else {//이유는 모르겠지만 어디에도 등록되어 있지 않은 페이지
			return "글 분류 에러 페이지!";
		}
		
//		if(boardType.equals("") || typeNo==0 || typeName.equals("")) { //변화가 없다면
//			return "글 분류 에러 페이지!";
//		}
		System.out.println("[딭] boardType = " + boardType);
		System.out.println("[딭] typeName = " + typeName);
		model.addAttribute("boardType", boardType);
		model.addAttribute("typeName", typeName);
		
		//3. 글쓴이의 회사이름과 업종이름을 가져오고 model에 담는다.
		MemberDto writerInfoDto;
		
		String companyName;
		String jobCategoryName;
		
		if(memberDao.mypage(writerMemberNo)!=null){
			writerInfoDto = memberDao.mypage(writerMemberNo);
					
			companyName = boardDao.getCompanyName(writerInfoDto.getCompanyNo());
			jobCategoryName = boardDao.getJobCategoryName(writerInfoDto.getJobCategoryNo());
			
			if(memberDto.getGradeNo() ==2 || memberDto.getGradeNo() ==4 || memberDto.getGradeNo() ==5) {//준회원+ 정회원+ 관리자
				//통과
			}
			else{
				if(checkBoardTypeDto.getJobCategoryNo() !=null) {//업종 한정
					if(memberDto.getJobCategoryNo() != writerInfoDto.getJobCategoryNo()) {
						return "결제페이짘ㅋ";
					}
				}
			}
		}

		else {
			companyName = "-";
			jobCategoryName = "-";
		}
		
		System.out.println("[딭] companyName = " + companyName);
		model.addAttribute("companyName", companyName);
		
		System.out.println("[딭] jobCategoryName = " + jobCategoryName);
		model.addAttribute("jobCategoryName", jobCategoryName);
		
		
		
		//4. count정보를 가져와서 model에 담는다.
		BoardCountDto boardCountDto = boardDao.getBoardCountInfo(boardNo);
		
		System.out.println("[딭] boardCountDto = " + boardCountDto);
		model.addAttribute("boardCountDto", boardCountDto);

		//5. 몇몇 문자를 바꾼다.
		//5-1. 꺽쇠 처리하기 lt gt
		String boardContent = boardDto.getBoardContent();
		
		boardContent= boardContent.replaceAll("<", "&lt");
		boardContent= boardContent.replaceAll(">", "&gt");
		boardContent= boardContent.replaceAll("\"", "\\u0022");
		boardContent= boardContent.replaceAll("\'", "\\u0022");
		
		//5-2. 해시태그에 앵커태그 붙이기
		System.out.println("수슬대에 오른 " + boardContent);
		
		List<String> hashTag  = boardDao.getHash(boardDto.getBoardContent());
		System.out.println("검색된 해시태그" + hashTag);
		
		for(int i = 0; i<hashTag.size(); i++) {
			
			String before = hashTag.get(i);
//			System.out.println("이거를 찾아서할거다" + hashTag.get(i));
			String after = "<a href="+"검색매핑주소/"+hashTag.get(i)+">"+hashTag.get(i)+"</a>";
			
//			System.out.println("만들어진건 =" + after);
			boardContent = boardContent.replaceFirst(before, after);
			
//			System.out.println("해시태그 변환중" + boardContent);
		}
		boardDto.setBoardContent(boardContent);
		
	
		//6. 좋아요, 북마크 정보를 가져온다.
	      if(memberDto != null) {
	        
	        BoardLikeDto boardLikeDto = BoardLikeDto.builder()
	         .boardNo(boardNo)
	         .memberNo(memberNo)
	      .build();
	        
	        BookmarkDto bookmarkDto = BookmarkDto.builder()
	   	         .boardNo(boardNo)
		         .memberNo(memberNo)
		    .build();
      
	        
	      	boolean isLiked=boardLikeDao.boardLikeExist(boardLikeDto);
	      	if(isLiked) {
	          	model.addAttribute("isLiked", 1);
	      	}
	      	else {
	         	model.addAttribute("isLiked", 2);
	      	}	

	      	boolean isMarked=bookmarkDao.bookmarkExist(bookmarkDto);
	      	if(isMarked) {
	          	model.addAttribute("isMarked", 1);
	      	}
	      	else {
	         	model.addAttribute("isMarked", 2);
	      	}  	
	      }  
		
		//7.이미지
//		List<ResponseEntity<ByteArrayResource>> imageFileList = uploadImageDao.getImageToJsp(boardNo);
//		model.addAttribute("imageFileList", imageFileList);
		
		//8. 투표1
		//토픽 정보를 가져온다
		VoteTopicDto voteTopicDto = new VoteTopicDto(); 
		if(voteDao.getVoteTopicInfo(boardNo) != null) {
			voteTopicDto = voteDao.getVoteTopicInfo(boardNo);
		}
				
		
		//8-1. 이미 투표한건지 알아본다..
		if(voteDao.getVoteTopicInfo(boardNo) != null) {
			int voteTopicNo = voteTopicDto.getVoteTopicNo();

			try {
							
				VoteResultDto voteResultDto =  VoteResultDto.builder()
						.voteTopicNo(voteTopicNo)
						.memberNo(memberNo)
						.build();
				boolean didYouVote = voteDao.didYouVote(voteResultDto);
				
				System.out.println("투표 여부" + didYouVote);
				
				if(didYouVote) {
					
					int selectedVoteOptionNo = voteDao.getSelectedOptionNoThatTopic(voteResultDto);
					System.out.println("[딭] selectedVoteOptionNo = " +selectedVoteOptionNo);
					model.addAttribute("selectedVoteOptionNo", selectedVoteOptionNo);
					System.out.println("[딭] didYouVote = " +didYouVote);
					model.addAttribute("didYouVote", "voted");

				}else {
					System.out.println("[딭] didYouVote = " +didYouVote);
					model.addAttribute("didYouVote", "didntVote");

				}			
				
			} catch (NullPointerException nullPointerException) {//memberDto가 비어있을 때 - 로그인 안 하고 들어올때 
				
					model.addAttribute("didYouVote", "notLogin"); //이름... ㅠㅠㅠ
			}
			
			model.addAttribute("VoteTopicInfo", voteTopicDto);
			System.out.println("[딭] voteTopicDto = " + voteTopicDto);

			//8-2선택지 정보를 가져온다
			
			List<VoteOptionInfoVo> voteOptionInfoVoList = voteDao.getVoteOptionInfo(boardNo);
			
			System.out.println("[딭] voteOptionInfoVoList = " + voteOptionInfoVoList);		
			model.addAttribute("VoteOptionInfo", voteOptionInfoVoList);
			
		}
		
		
		
		//9. 댓글
		List<CommentsVO> commentsList = boardDao.getCommentsList(boardNo);
	    
		for(int i = 0; i<commentsList.size(); i++) {
				
			if(commentsList.get(i).getMemberNo() != memberDto.getMemberNo() || memberNo==-1) {
				String memberNick = commentsList.get(i).getMemberNick();
				char firstChar = memberNick.charAt(0);
				int nickLength = memberNick.length();
				
				StringBuilder stringBuilderForBlindedNick = new StringBuilder();
				stringBuilderForBlindedNick.append(firstChar);
				for(int j =0; j<nickLength-1; j++) {
					stringBuilderForBlindedNick.append("*");
				}
				String blindedNick = stringBuilderForBlindedNick.toString();
				commentsList.get(i).setMemberNick(blindedNick);
				
				commentsList.get(i).setOwnComments(0);
			}
			else {
				commentsList.get(i).setOwnComments(1);
			}
			System.out.println("이번 댓글 " + commentsList.get(i));
	    }
		
		System.out.println("[딭]boardDto" + boardDto);
		model.addAttribute("boardDto", boardDto);
		System.out.println("[딭]boardMemberVO" + boardMemberVO);
		model.addAttribute("boardMemberVO", boardMemberVO);
		
		System.out.println("[딭]commentsList" + commentsList);
		model.addAttribute("commentsList", commentsList);
		
		
		//마무리 - 모든 것이 완료되면 forward하기전에 조회를 1 올려준다.
		boardDao.addViewCount(boardNo);
		System.out.println("끝");
		return "/board/boardDetail";
	}
		@PostMapping("commentInsert")
		   public String commentInsert(
		         HttpSession session,
		         @RequestParam int boardNo, String commentsContent) {
		       //세션 1개(회원번호)
		         MemberDto memberDto = (MemberDto)session.getAttribute("dtoss");
		         int memberNo = memberDto.getMemberNo();
		         int nextSeqNo = commentDao.getCommentsSequence();
		         CommentsVO commentsVO = CommentsVO.builder()
		        		 						.commentsNo(nextSeqNo)
		        		                         .commentsContent(commentsContent)
		        		                         .commentsGroupNo(nextSeqNo)
		        		                         .boardNo(boardNo)
		        		                         .memberNo(memberNo)
		         .build();
		         commentDao.commentInsert(commentsVO);
		      return "redirect:boardDetail?boardNo="+boardNo;
		   }
		   @PostMapping("nestedCommentInsert")
		   public String nestedCommentInsert(
		         HttpSession session,
		         @RequestParam String commentsContent, int boardNo,int superNo, int commentsGroupNo
		         ) {
		       //세션 1개(회원번호)
		         MemberDto memberDto = (MemberDto)session.getAttribute("dtoss");
		         int memberNo = memberDto.getMemberNo();
		         CommentsVO commentsVO = CommentsVO.builder()
		                  .boardNo(boardNo)
		                  .commentsGroupNo(commentsGroupNo)
		                  .commentsSuperNo(superNo)
		                  .memberNo(memberNo)
		                  .commentsContent(commentsContent)
		         .build();
		         commentDao.nestedCommentInsert(commentsVO);
		      return "redirect:boardDetail?boardNo="+boardNo;	
	}
	
			@GetMapping("/boardEdit")
			public String boardEdit(int boardNo, Model model, HttpSession session) {
				//세션으로 본인의 memberNo로만 수정할 수 있게 처리해야함 (나중에)
				
				BoardDto boardDto = boardDao.getBoardDetail(boardNo);
				int writerMemberNo = boardDto.getMemberNo();
				
				MemberDto memberDto = (MemberDto)session.getAttribute("dtoss");
				int memberNo;
				if(memberDto!=null) {
					memberNo=memberDto.getMemberNo();
				}else {
					return "로그인페이지";
				}
				if(writerMemberNo!=memberNo) {
					return "비정상접근";
				}
				
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
			@ModelAttribute BoardWriteFullVO boardWriteFullVO
			) {
		int boardNo = boardWriteFullVO.getBoardNo();
		
		//1. 고친다.
		BoardDto boardDto = BoardDto.builder()
									.boardNo(boardWriteFullVO.getBoardNo())
									.boardTitle(boardWriteFullVO.getBoardTitle())
									.boardContent(boardWriteFullVO.getBoardContent())
									.build();
		boardDao.edit(boardDto);
		
		//2. 해시태그
		//2-1. 기존 해시태그 삭제
		boardDao.deleteHash(boardWriteFullVO.getBoardNo());
		//2-2. 해시태그 등록
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
			
		return "redirect:boardDetail?boardNo=" + boardNo; //수정이 완료되면 번호가 첨부된채로 상세보기로 이동
	}
	
	@GetMapping("/boardDelete")
	public String boardDelete(@RequestParam int boardNo
			//준비 : 게시글 번호.
			) {
		uploadImageDao.deleteImageChainToBoard(boardNo);
		boardDao.delete(boardNo);
		return "redirect:/board/boardList"; //목록으로 리다이렉트
	}
	
	@GetMapping("/boardList")
	public String boardList(
			HttpSession session,  Model model, 
			@RequestParam String type, 
			@RequestParam(required = false) Integer boardCategoryNo,
			@RequestParam(required = false) Integer otherJobCategoryNo,
			@RequestParam(required = false) String keyword
			) {
		MemberDto memberDto = (MemberDto)session.getAttribute("dtoss");
		

		if(keyword !=null) {
			// 키워드 카운트 
			if(searchDao.get(keyword)!=null) {
				searchDao.update(keyword);
			}
			else {
				// 시퀀스번호
				int searchNo = searchDao.getSequence();
				
				SearchDto searchDto = SearchDto.builder()
						.searchNo(searchNo)					
						.keyword(keyword)
				.build();
				
				searchDao.insert(searchDto);	
			}
		}
		
		//기업별 게시판 목록
		if(type.equals("companyBoard")){
			List<CompanyBoardDto> companyBoardList = new ArrayList<>();
			int companyNo = memberDto.getCompanyNo();
			
			if(keyword == null) {
				companyBoardList = boardDao.getCompanyBoardList(companyNo);
			}
			else {// if(keyword != null)
				companyBoardList = boardDao.SearchCompanyBoardList(keyword);
			}
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
			List<JobCategoryBoardDto> jobCategoryBoardList = new ArrayList<>();
		
			//+회원인경우
			if(memberDto.getGradeNo() ==2 || memberDto.getGradeNo() ==4) {
				System.out.println(otherJobCategoryNo);
				
				jobCategoryBoardList = boardDao.getJobCategoryBoardList(otherJobCategoryNo);
				
				model.addAttribute("jobCategoryBoardList", jobCategoryBoardList);
			}
			
			
//			else if(회원등급이 2,4가 아닌경우)
			int jobCategoryNo = memberDto.getJobCategoryNo();
			
			if(keyword == null) {
				jobCategoryBoardList = boardDao.getJobCategoryBoardList(jobCategoryNo);
			}
			else {// if(keyword != null)
				jobCategoryBoardList	= boardDao.SearchJobCategoryBoardList(keyword);
			}
			model.addAttribute("jobCategoryBoardList", jobCategoryBoardList);
			
				if(jobCategoryBoardList != null) {
					return "/board/boardList";
				}
				else {
					return "글없다페이지";
				}
		}
		
		else if(type.equals("boardCategoryBoard")) {
			
			//일단 저장소를 만든다.(자바가 멍청한건지 if문안에 변수가 있으면 모름)
			List<BoardCategoryBoardDto> boardCategoryBoardList = new ArrayList<>();
				
			//keyword가 없으면 일반 목록을 조회하고 
			if(keyword == null) {
				System.out.println("키워드가 없어!");
				boardCategoryBoardList =  boardDao.getBoardCategoryBoardList(boardCategoryNo);
				System.out.println("일반이네요 " +boardCategoryBoardList);
			}				
			//keyword가 있으면 검색을 하고 
			else{// if(keyword != null) 
	
				System.out.println("키워드가 있네요~");
				boardCategoryBoardList = boardDao.BoardCategorySearch(keyword);
				System.out.println("검색이네여~ " + boardCategoryBoardList);
			}
		
			//두 방법 중 나온 "boardCategoryboardList"를 model에 넣는다.
			System.out.println("모델입니당~" + boardCategoryBoardList);
			model.addAttribute("boardCategoryBoardList", boardCategoryBoardList);
				
				//
				if (boardCategoryBoardList != null) {
					return "/board/boardList";
				} 
				else {
					return "글없다페이지";//그 게시판에 글이 없다.
				}
		}
		
		//type = 이도저도 아닌거 들어올때의 경우의 수
		else {
			return "에러페이지 404";
		}
			
	}
	
	@GetMapping("boardLikeInsert")
	   public String boardLike(HttpSession session,Integer boardNo) {
		
		
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
	   @GetMapping("bookmarkInsert")
       public String bookmarkInsert(int boardNo,HttpSession session) {
       MemberDto memberDto = (MemberDto)session.getAttribute("dtoss");
          
          int memberNo = memberDto.getMemberNo();
          if(memberDto !=null) {
          
             BookmarkDto bookmarkDto=BookmarkDto.builder()
             .boardNo(boardNo)
             .memberNo(memberNo)
          .build();
          bookmarkDao.BookmarkInsert(bookmarkDto);}
          
          return "redirect:boardDetail?boardNo="+boardNo;
       }

	   
	      @GetMapping("bookmarkDelete")
	         public String bookmarkDelete(int boardNo,HttpSession session) {
	         MemberDto memberDto = (MemberDto)session.getAttribute("dtoss");
	            int memberNo = memberDto.getMemberNo(); 
	            if(memberDto !=null) {
	            
	               BookmarkDto bookmarkDto=BookmarkDto.builder()
	               .boardNo(boardNo)
	               .memberNo(memberNo)
	            .build();
	            bookmarkDao.BookmarkDelete(bookmarkDto);}
	            
	            return "redirect:boardDetail?boardNo="+boardNo;
	         }
	   
	   @GetMapping("imageDownloadTest")
	   public String imageDownloadTest() {
		   return "board/imageDownloadTest";
	   }
	   
      @GetMapping("commentsDelete")
      public String commentsDelete(int commentsNo, int boardNo) {
    	  System.out.println(commentsNo + "들어옴" + boardNo);
         commentDao.delete(commentsNo);
         System.out.println("댓글삭제");
         return "redirect:boardDetail?boardNo="+boardNo;
      }
      
      @GetMapping("mywrite")
      public String mywrite(HttpSession session,Model model) {
         MemberDto memberDto = (MemberDto)session.getAttribute("dtoss");
            int memberNo = memberDto.getMemberNo();
            List<BoardCategoryVO> mywriteList = new ArrayList<>();

            mywriteList = boardDao.myWrite(memberNo);
            model.addAttribute("mywriteList",mywriteList);
         return "mypage/mywrite";
            
      }

 @GetMapping("mybookmark")
      public String mybookmark(HttpSession session,Model model) {
         MemberDto memberDto = (MemberDto)session.getAttribute("dtoss");
            int memberNo = memberDto.getMemberNo();
            List<BookmarkVO> bookmarkList = new ArrayList<>();

            bookmarkList = bookmarkDao.MyBookmark(memberNo);
            model.addAttribute("bookmarkList",bookmarkList);
         return "mypage/mybookmark";
            
      }
 
}
