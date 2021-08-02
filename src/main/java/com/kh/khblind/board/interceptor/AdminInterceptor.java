package com.kh.khblind.board.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.khblind.member.entity.MemberDto;

public class AdminInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		MemberDto memberDto = (MemberDto)request.getSession().getAttribute("dtoss");
	      boolean isAdmin = memberDto.getGradeNo()==5;
	      
	      if(isAdmin) {
	    	  return true;
	      }
	      
	      else
	    	  response.sendRedirect(request.getContextPath()+"/error/errorpage");
	    	  return false;
	}
}
