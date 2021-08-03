package com.kh.khblind.error.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("error")
@Controller
public class errorController {

	//관리자가 아닌 회원이 관리자 권한을 이용하려고 할때
	@GetMapping("/errorpage")
	public String errorpage() {
		return "error/errorpage";
	}

	//결제안한 회원이 모든 업종을 보려할때
	@GetMapping("/PayInfo")
	public String PayInfo() {
		return "error/PayInfo";
	}

}

