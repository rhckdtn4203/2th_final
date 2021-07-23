package com.kh.khblind.board.controller;

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

import com.kh.khblind.admin.category.entity.CategoryDto;
import com.kh.khblind.admin.category.repository.CategoryDao;
import com.kh.khblind.board.entity.BoardCategoryGroupDto;
import com.kh.khblind.board.entity.BoardDto;
import com.kh.khblind.board.entity.BoardMemberVO;
import com.kh.khblind.board.entity.BoardWriteVO;
import com.kh.khblind.board.entity.CommentsVO;
import com.kh.khblind.board.entity.CompanyBoardDto;
import com.kh.khblind.board.entity.CompanyGroupDto;
import com.kh.khblind.board.entity.HashtagLinkDto;
import com.kh.khblind.board.entity.JobCategoryBoardDto;
import com.kh.khblind.board.entity.JobCategoryGroupDto;
import com.kh.khblind.board.repository.BoardDao;
import com.kh.khblind.board.repository.CommentDao;
import com.kh.khblind.member.entity.MemberDto;
@RequestMapping("/board")
@Controller
public class BoardController {
	
	@Autowired
	private BoardDao boardDao;
	
	@Autowired
	private CategoryDao categoryDao;
	
	@Autowired
	private CommentDao commentDao;
	
	@Autowired
	private SqlSession sqlSession;
	
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
		@ModelAttribute BoardDto boardDto,
		@ModelAttribute BoardWriteVO boardWriteVO,
		@ModelAttribute BoardCategoryGroupDto boardCategoryGroupDto,
		@ModelAttribute JobCategoryGroupDto jobCategoryGroupDto,
		@ModelAttribute CompanyGroupDto companyGroupDto

		) {
		//세션 1개(회원번호)
		MemberDto memberDto = (MemberDto)session.getAttribute("dtoss");
		int memberNo = memberDto.getMemberNo();		
//		int memberNo = 2; //임시데이터
		boardDto.setMemberNo(memberNo);
		
		//DB조회 1개(시퀀스번호)
		int boardNo = boardDao.getSequence();
		boardDto.setBoardNo(boardNo);
		
		System.out.println("[여기는 컨트롤러]boardDto = " + boardDto);
		
		boardDao.insert(boardDto);
		
//		if(that의 name에 속성값이 boardCategoryNo면 밑에 등록메소드가 실행되게 )	
		if(boardCategoryGroupDto.getBoardCategoryNo() != 0) {
		//게시판 카테고리 insert
		//boardCategoryNo는 사용자가 select한 값이 바로 name으로 넘어가 categoryNo에 들어가므로 여기서 안가져와도 된다.
		boardCategoryGroupDto.setBoardNo(boardNo);
		boardDao.boardCategoryInsert(boardCategoryGroupDto);
		}
		
//		else if(that의 name에 속성값에 jobCategoryNo면 밑에 등록메소드가 실행되게)
		else if(jobCategoryGroupDto.getJobCategoryNo() != 0) {		
//		int jobCategoryNo = memberDto.getJobCategoryNo();
		jobCategoryGroupDto.setBoardNo(boardNo);
		boardDao.jobCategoryInsert(jobCategoryGroupDto);
		}
		//기업 insert
		else{//(나머지는 이 밑에 등록메소드가 실행되게)
		
//		int companyNo = memberDto.getCompanyNo();
		companyGroupDto.setBoardNo(boardNo);
		boardDao.companyInsert(companyGroupDto);
		}
		
		//해시태그 insert
		List<String> hashtagList = new ArrayList<>(); 
	      hashtagList = boardDao.getHash(boardWriteVO); 
	      
	      List<Integer> hashtagNumList = boardDao.getHashNum(hashtagList);
	      List<HashtagLinkDto> hashtagLinklist = new ArrayList<HashtagLinkDto>();
	      for(int hashtagNo : hashtagNumList){
	         HashtagLinkDto hashtagLinkDto = HashtagLinkDto.builder() 
	         .boardNo(boardNo)
	          .hashtagNo(hashtagNo)
	          .build();
	        
	         hashtagLinklist.add(hashtagLinkDto);
	         }
	      boardDao.insertHashlink(hashtagLinklist);
	  

		
		
		return "redirect:boardDetail?boardNo="+boardNo;//상세페이지로 가면서 번호주기
		
		
	}
	//데이터가 있으면 boardDto를 반납하고, 데이터가 없으면 null을 반납
	@GetMapping("/boardDetail")
	public String boardDetail(int boardNo, Model model) {
		
		BoardDto boardDto = boardDao.getBoardDetail(boardNo);
		BoardMemberVO boardMemberVO = boardDao.find(boardNo);
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
	public String boardEdit(int boardNo, Model model) {
		//세션으로 본인의 memberNo로만 수정할 수 있게 처리해야함 (나중에)
		BoardDto boardDto = boardDao.getBoardDetail(boardNo);
		model.addAttribute("boardDto", boardDto);
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
	public String boardList(HttpSession session,  Model model, @RequestParam String type) {
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
		//type = 이도저도 아닌거 들어올때의 경우의 수
		else {
			return "에러페이지 404";
		}
			
	}
	

}
