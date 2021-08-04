package com.kh.khblind.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.khblind.board.repository.BoardDao;
import com.kh.khblind.member.entity.MemberDto;
import com.kh.khblind.member.repository.MemberDao;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberDao dao;
	@Autowired
	private BoardDao boardDao;

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
		
		
	     if(dto !=null) {
	         int companyNo = dto.getCompanyNo();
	         int jobCategoryNo = dto.getJobCategoryNo();
	         String companyName = boardDao.getCompanyName(companyNo);
	         String jobCategoryName = boardDao.getJobCategoryName(jobCategoryNo);
	         model.addAttribute("companyName", companyName);
	         model.addAttribute("jobCategoryName", jobCategoryName);
	      }   

		return "member/mypage";
	}

	// 마이페이지 수정

//	@GetMapping("/changeinfo")
//	public String changeinfo(HttpSession session, Model model) {
//		MemberDto dto = (MemberDto) session.getAttribute("dtoss");
//		model.addAttribute("dtoPack", dao.mypage(dto.getMemberNo()));
//
//		return "member/changeinfo";
//	}
//
//	@PostMapping("/changeinfo")
//	public String changeinfo(@ModelAttribute MemberDto dto) {
//		boolean result = dao.changeinfo(dto);
//
//		if (result) {
//			return "redirect:changeinfo";
//
//		} else {
//			return "redirect:changeinfo?error";
//		}
//
//	}
//
//	@GetMapping("/changeinfo_success")
//	public String changeinfo() {
//
//		return "member/changeinfo_success";
//	}

	@GetMapping("/changeinfo")
	public String changeinfo1() {
		
		return "member/changeinfo";
	}

	@PostMapping("/changeinfo")
	public String changeinfo(HttpSession session, @RequestParam String memberNick, @RequestParam String memberPhone) {
		MemberDto dto = (MemberDto) session.getAttribute("dtoss");
		boolean result = dao.changeinfo(dto.getMemberNick(), dto.getMemberNo(), dto.getMemberPhone());
		if (result) {
			return "redirect:changeinfo_success";
		} else {
			return "redirect:changeinfo?error";
		}
	}

	@GetMapping("/changeinfo_success")
	public String changeinfo() {

		return "member/changeinfo_success";
	}
	
	// 아이디찾기

	@GetMapping("/find_id")
	public String find_id() {

		return "member/find_id";
	}

	@PostMapping("/find_id")
	public String find_id(@RequestParam String memberName, @RequestParam String memberPhone, Model model) {
		String result = dao.find_id(memberName, memberPhone);
		model.addAttribute("idresult", result);
		if (result!="") {
			return "member/show_id";
		} else {
			return "redirect:show_id?error";
		}
	}

	// 비밀번호 변경

	@GetMapping("/change_pw")
	public String change_pw() {
		
		return "member/change_pw";
	}

	@PostMapping("/change_pw")
	public String changePw(HttpSession session, @RequestParam String newPw, @RequestParam String curPw) {
		MemberDto dto = (MemberDto) session.getAttribute("dtoss");
		boolean result = dao.change_pw(newPw, dto.getMemberNo(), curPw);
		if (result) {
			return "redirect:change_pw_success";
		} else {
			return "redirect:change_pw?error";
		}
	}

	@GetMapping("/change_pw_success")
	public String changePw() {

		return "member/change_pw_success";
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
		return "member/deletecount";

	}

}