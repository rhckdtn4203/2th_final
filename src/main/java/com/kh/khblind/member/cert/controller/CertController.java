package com.kh.khblind.member.cert.controller;

import java.io.IOException;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.khblind.member.cert.entity.CertDto;
import com.kh.khblind.member.cert.service.CertService;
import com.kh.khblind.member.entity.MemberDto;
import com.kh.khblind.member.repository.MemberDao;

@Controller
@RequestMapping("/cert")
public class CertController {

	@Autowired
	private CertService certService;
	
	@Autowired
	private MemberDao memberDao;
	
	// 이메일 입력 페이지
	@GetMapping("/emailInsert")
	public String emailInsert() {
		return "cert/emailInsert";
	}
	
	@PostMapping("/emailInsert")
	public String emailInsert(@RequestParam String email, 
			HttpSession session, 
			RedirectAttributes attr) 
					throws MessagingException, IOException {
		boolean check = certService.checkCompany(email);
		
		if(check) {
			certService.sendCertification(email, session);
			attr.addAttribute("email", email);
			return "redirect:certInsert";
		}
		else {
			return "redirect:emailInsert?error";
		}
	}
	
	// 인증번호 입력 페이지
	@GetMapping("/certInsert")
	public String certInsert() {
		return "cert/certInsert";
	}
	
	@PostMapping("/certInsert")
	public String certInsert(
			@ModelAttribute CertDto certDto, 
			HttpSession session, 
			RedirectAttributes attr) {
		boolean result = certService.checkCertification(certDto);
		if(result) {
			MemberDto dto = (MemberDto) session.getAttribute("dtoss");
			int memberNo = dto.getMemberNo();
			certService.upgrade(memberNo);
			
			// 세션 초기화 및 다시 넣기
			session.removeAttribute("dtoss");
			
			MemberDto memberDto = memberDao.mypage(memberNo);
			session.setAttribute("dtoss", memberDto);
			
			return "redirect:certSuccess";
		}
		else {
			// 이메일 실패 시 오류임을 알려주고 이메일을 다시 전달
			attr.addAttribute("error", "");
			attr.addAttribute("email", certDto.getEmail());
			return "redirect:certInsert";
		}
	}
	
	// 인증 성공 페이지
	@GetMapping("/certSuccess")
	public String certSuccess() {
		return "cert/certSuccess";
	}
}
