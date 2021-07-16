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

@Controller
@RequestMapping("/cert")
public class CertController {

	@Autowired
	private CertService certService;
	
	// 테스트) 이메일 입력 페이지
	@GetMapping("/emailInsert")
	public String emailInsert() {
		return "cert/emailInsert";
	}
	
	@PostMapping("/emailInsert")
	public String emailInsert(@RequestParam String email, RedirectAttributes attr) throws MessagingException, IOException {
		certService.sendCertification(email);
		attr.addAttribute("email", email);
		return "redirect:certInsert";
	}
	
	// 테스트) 인증번호 입력 페이지
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
			int memberNo = (int)session.getAttribute("memberNo");
			certService.upgrade(memberNo);
			return "redirect:certSuccess";
		}
		else {
			// 이메일 실패 시 오류임을 알려주고 이메일을 다시 전달
			attr.addAttribute("error", "");
			attr.addAttribute("email", certDto.getEmail());
			return "redirect:certInsert";
		}
	}
	
	// 테스트) 인증 성공 페이지
	@GetMapping("/certSuccess")
	public String certSuccess() {
		return "cert/certSuccess";
	}
}
