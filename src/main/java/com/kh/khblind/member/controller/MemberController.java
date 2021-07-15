package com.kh.khblind.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cglib.transform.impl.AddDelegateTransformer;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
		MemberDto dtoPack = dao.login(dto);
		if (dtoPack != null) {
			session.setAttribute("dtoss", dtoPack);
			return "redirect:/";
		} else {
			return "redirect:login?error";
		}
	}

	// 로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("dtoss");
		return "redirect:/";
	}

	// 마이페이지
	@GetMapping("/mypage")
	public String mypage(HttpSession session, Model model) {

		MemberDto dto = (MemberDto) session.getAttribute("dtoss");
		int memberNo = dto.getMemberNo();
		MemberDto dtoPack = dao.mypage(memberNo);
		model.addAttribute("dtoPack", dtoPack);

		return "member/mypage";
	}

	// 마이페이지 수정
	@GetMapping("/changeinfo")
	public String changeinfo(HttpSession session, Model model) {
		MemberDto dto = (MemberDto) session.getAttribute("dtoss");
		model.addAttribute("dtoPack", dao.mypage(dto.getMemberNo()));

		return "member/changeinfo";
	}

	@PostMapping("/changeinfo")
	public String changeinfo(@ModelAttribute MemberDto dto) {
		boolean result = dao.changeinfo(dto);

		if (result) {
			return "redirect:changeinfo";

		} else {
			return "redirect:changeinfo?error";
		}

	}

	// 회원 탈퇴
	@RequestMapping("/exit")
	public String exit(HttpSession session) {
		
		MemberDto dto = (MemberDto) session.getAttribute("dtoss");
		int memberNo = dto.getMemberNo();
		dao.exit(memberNo);
		session.removeAttribute("dtoss");
		
		
		return "redirect:deletecount";
	}


	@GetMapping("/deletecount")
	public String deletecount() {
		return "member/goodbye";
		
	}
}