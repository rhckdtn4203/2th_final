package com.kh.khblind.board.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.khblind.board.entity.BoardDto;
import com.kh.khblind.member.entity.MemberDto;

public class BoardNotLoginInterceptor implements HandlerInterceptor{
@Override
public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
		throws Exception {
	
	MemberDto memberDto = (MemberDto)request.getSession().getAttribute("dtoss");
//      Integer memberNo = memberDto.getMemberNo();
      
      
      if(memberDto==null){
    	  response.sendRedirect(request.getContextPath()+"/member/login");//로그인 안했을경우 로그인페이지로 리다이렉트
    	  return false;
    	  }
      //로그인 안했을경우 로그인 페이지로 이동
		
      else {
    	  return true;
      }
}




}
	
    	
	
	
	
	
	
	

