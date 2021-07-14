package com.kh.khblind.board.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.khblind.board.entity.BoardDto;
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
		@ModelAttribute BoardDto boardDto,
		@ModelAttribute BoardWriteVO boardWriteVO
		) {
		int memberNo = (int)session.getAttribute("memberNo");
		boardDto.setMemberNo(memberNo);
		
		//DB조회 1개(시퀀스번호)
		int boardNo = boardDao.getSequence();
		boardDto.setBoardNo(boardNo);
		
		boardDao.insert(boardDto);
		return "redirect:boardDetail?boarNo="+boardNo;//상세페이지로 가면서 번호주기
	}

}
