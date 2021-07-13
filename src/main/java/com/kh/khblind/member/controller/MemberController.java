package com.kh.khblind.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.khblind.member.entity.MemberDto;
import com.kh.khblind.member.repository.MemberDao;
import com.kh.khblind.member.repository.MemberDaoImpl;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberDao dao;
	
	
	@GetMapping("/signup")
	public String signup() {
		return "member/signup";
	}
	
	@PostMapping("/signup")
	public String signup(@ModelAttribute MemberDto dto) {
		dao.insert(dto);
		return "redirect:successjoin";
	}
	
	@GetMapping("/successjoin")
	public String successjoin() {
		return "member/successjoin";
	}
	
	
	
	// 로그인 요청 처리
		@GetMapping("/login")
		public String login() {
			return "member/login";
		}

		@PostMapping("/login")
		public String login(@ModelAttribute MemberDto dto, HttpSession session) {
			MemberDto isLogin = dao.login(dto);
			if (isLogin != null) {
				session.setAttribute("memberNo", isLogin.getMemberNo());
				return "redirect:/";
			} else {
				return "redirect:login?error";
			}
		}

	// 로그아웃 
		@GetMapping("/logout")
		public String logout(HttpSession session) {
			session.removeAttribute("memberNo");
			return "redirect:/";
		}
		

	
		
		
}
