package com.kh.khblind.board.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.khblind.member.entity.MemberDto;

public class PlusMemberInterceptor implements HandlerInterceptor{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		MemberDto memberDto = (MemberDto)request.getSession().getAttribute("dtoss");
	    
		//plus회원인지 판별하는 변수 
		int gradeNo = memberDto.getGradeNo();
		//플러스 회원인경우
		if(gradeNo==2||gradeNo==4)return true;
	
		
		else 
			response.sendRedirect(request.getContextPath()+"/error/PayInfo");
			return false;
	}
}
