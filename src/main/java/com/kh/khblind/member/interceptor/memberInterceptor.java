package com.kh.khblind.member.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.kh.khblind.member.entity.MemberDto;

public class memberInterceptor implements HandlerInterceptor{
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// 목표 : 비회원의 접근 차단
		// 참조 : 세션의 memberNo (없을 수 있으므로 Integer로 처리)
		
		MemberDto dto = (MemberDto) request.getSession().getAttribute("dtoss");
		Integer memberNo = dto.getMemberNo();
	
		if(memberNo == null) {
			// response.sendError(401); -- 미인증 처리 (403은 로그인 후 접근 권한 없음)
			response.sendRedirect(request.getContextPath() + "/member/login");
			return false;
		} 
		
		return true;
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
	
		HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
	}
	
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		
		HandlerInterceptor.super.afterCompletion(request, response, handler, ex);
	}
}
