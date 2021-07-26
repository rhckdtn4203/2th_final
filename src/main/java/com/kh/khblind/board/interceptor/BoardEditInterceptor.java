package com.kh.khblind.board.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.khblind.board.entity.BoardDto;
import com.kh.khblind.board.repository.BoardDao;
import com.kh.khblind.member.entity.MemberDto;

public class BoardEditInterceptor implements HandlerInterceptor{

	@Autowired
	BoardDao boardDao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		//목표 : 내 게시글만 수정/삭제 하도록 하기 위한 인터셉터이다!
		//참조 : 세션의 memberNo / 파라미터의 작성자 번호(boardNo를 꺼내서 세션의 회원번호와 작성자 번호가 같은지 검사
		//회원번호가 없을 수도 있으므로 Integer로 처리
		MemberDto memberDto = (MemberDto)request.getSession().getAttribute("dtoss");
	      int memberNo = memberDto.getMemberNo();


		System.out.println("인터셉터 작동");
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
		BoardDto boardDto = boardDao.getBoardDetail(boardNo);
		int writeNo = boardDto.getMemberNo();
		if(memberNo == writeNo) { //본인이라면
			return true;
		}
		response.sendError(403); //권한 부족
		return false;
	}

}
