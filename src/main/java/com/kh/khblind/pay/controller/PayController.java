package com.kh.khblind.pay.controller;

import java.net.URISyntaxException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.khblind.pay.service.PayService;
import com.kh.khblind.pay.vo.PayApprovePrepareVO;
import com.kh.khblind.pay.vo.PayApproveVO;
import com.kh.khblind.pay.vo.PayReadyPrepareVO;
import com.kh.khblind.pay.vo.PayReadyVO;

@Controller
@RequestMapping("/pay")
public class PayController {
	
	@Autowired
	private PayService payService;
	
	@GetMapping("/upgrade")
	public String upgrade() {
		return "/pay/upgrade";
	}
	
	@PostMapping("/upgrade")
	public String upgrade(
			HttpSession session,
			@ModelAttribute PayReadyPrepareVO PrepareVO) throws URISyntaxException {
		
		// 결제 준비 요청 보내기 
		PayReadyVO readyVO = payService.ready(PrepareVO);
		
		// 승인 요청을 위해 정보를 DB/세션 등에 저장해야 함
		// = partner_order_id, partner_user_id,tid
		session.setAttribute("partner_order_id",PrepareVO.getPartner_order_id());
		session.setAttribute("partner_user_id",PrepareVO.getPartner_user_id());
		session.setAttribute("tid",readyVO.getTid());
		
		// 사용자에게 결제 페이지 주소로 재접속 지시를 내린다(리다이렉트)
		return "redirect:"+readyVO.getNext_redirect_pc_url();
	}
	
	
	@GetMapping("/success")
	public String success(
			HttpSession session,
			@ModelAttribute PayApprovePrepareVO prepareVO) throws URISyntaxException {
		
		// 세션에서 데이터 추출
		prepareVO.setPartner_order_id((String)session.getAttribute("partner_order_id"));
		prepareVO.setPartner_user_id((String)session.getAttribute("partner_user_id"));
		prepareVO.setTid((String)session.getAttribute("tid"));
		
		session.removeAttribute("partner_order_id");
		session.removeAttribute("partner_user_id");
		session.removeAttribute("tid");
		
		PayApproveVO approveVO = payService.approve(prepareVO);
		
		// 승인 정보를 DB에 저장(PayApproveVO)하는 작업 수행
		
		// 결제 성공 알림 페이지 
		return "redirect:result_success";
	}
	
	// 결제 성공 알림 페이지 
	@GetMapping("/result_success")
	public String resultSuccess() {
		return "pay/resultSuccess";
	}
	
	
	
	
	
	
	
	
}
