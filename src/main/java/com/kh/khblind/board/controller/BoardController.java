package com.kh.khblind.board.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

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
import com.kh.khblind.board.entity.CompanyGroupDto;
import com.kh.khblind.board.entity.HashtagLinkDto;
import com.kh.khblind.board.entity.JobCategoryGroupDto;
import com.kh.khblind.board.repository.BoardDao;
import com.kh.khblind.member.entity.MemberDto;

@Controller
public class BoardController {
	
	@Autowired
	private BoardDao boardDao;
	
	@Autowired
	private CategoryDao categoryDao;
	
	@RequestMapping("/")
	public String home() {
		return "home";
	}
	
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

		model.addAttribute("boardDto", boardDto);
		model.addAttribute("boardMemberVO", boardMemberVO);

		if(boardDto != null) { //Dto가 null이 아니면

			return "/board/boardDetail";
			}
		else {
			return "글없다페이지";
		}
		
		
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
	

}
