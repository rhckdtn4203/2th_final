package com.kh.khblind.board.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.khblind.board.entity.BoardDto;
import com.kh.khblind.board.entity.BoardEditVO;
import com.kh.khblind.board.entity.BoardMemberVO;
import com.kh.khblind.board.entity.BoardWriteVO;
import com.kh.khblind.board.repository.BoardDao;

@Controller
public class BoardController {
	
	@Autowired
	private BoardDao boardDao;
	
	@RequestMapping("/")
	public String home() {
		return "home";
	}
	
	@GetMapping("/boardWrite")
	public String boardWrite() {
		return "board/boardWrite";
	}
	
	@PostMapping("/boardWrite")
	public String boardWrite(
			//준비 : DB조회 1개(시퀀스번호) + 세션 1개(회원번호) + 파라미터 3개(제목,내용,해시태그)
			
		HttpSession session,	
		@ModelAttribute BoardDto boardDto
//		@ModelAttribute BoardWriteVO boardWriteVO
		) {
		int memberNo = (int)session.getAttribute("memberNo");
		boardDto.setMemberNo(memberNo);
		
		//DB조회 1개(시퀀스번호)
		int boardNo = boardDao.getSequence();
		boardDto.setBoardNo(boardNo);
		
		boardDao.insert(boardDto);
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
			//준비 : 게시글 번호
			) {
		boardDao.delete(boardNo);
		return "redirect:/board/boardList"; //목록으로 리다이렉트
	}
	

}
