package com.kh.khblind.pay.controller;

import java.net.URISyntaxException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.khblind.member.entity.MemberDto;
import com.kh.khblind.member.repository.MemberDao;
import com.kh.khblind.pay.entity.PayDto;
import com.kh.khblind.pay.repository.PayDao;
import com.kh.khblind.pay.service.PayService;
import com.kh.khblind.pay.vo.PayApprovePrepareVO;
import com.kh.khblind.pay.vo.PayApproveVO;
import com.kh.khblind.pay.vo.PayReadyPrepareVO;
import com.kh.khblind.pay.vo.PayReadyVO;
import com.kh.khblind.pay.vo.PaySearchVO;

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
			@ModelAttribute PayReadyPrepareVO prepareVO) throws URISyntaxException {
		
		// 결제 준비 요청 보내기 
		MemberDto dto = (MemberDto) session.getAttribute("dtoss");
		int memberNo = dto.getMemberNo();
		
		prepareVO.setPartner_user_id(String.valueOf(memberNo));
		
		
		// payService.ready는 카카오페이에 준비요청을 발송하는 기능
		PayReadyVO readyVO = payService.ready(prepareVO);
		
		session.setAttribute("partner_order_id",readyVO.getPartner_order_id());
		session.setAttribute("partner_user_id",readyVO.getPartner_user_id());
		session.setAttribute("tid",readyVO.getTid());
		
		// 사용자에게 결제 페이지 주소로 재접속 지시를 내린다(리다이렉트)
		return "redirect:"+readyVO.getNext_redirect_pc_url();
	}
	
	
	@GetMapping("/success")
	public String success(
			HttpSession session,
			@ModelAttribute PayApprovePrepareVO prepareVO) throws URISyntaxException {
		
		// 세션에서 데이터 추출 후 삭제 
		prepareVO.setPartner_order_id(String.valueOf(session.getAttribute("partner_order_id")));
		prepareVO.setPartner_user_id(String.valueOf(session.getAttribute("partner_user_id")));
		prepareVO.setTid(String.valueOf(session.getAttribute("tid")));
		
		session.removeAttribute("partner_order_id");
		session.removeAttribute("partner_user_id");
		session.removeAttribute("tid");
		
		PayApproveVO approveVO = payService.approve(prepareVO);
			
		// 결제 성공 알림 페이지 
		return "redirect:result_success?tid="+approveVO.getTid();
	}
	
	// 결제 성공 알림 페이지 
	@GetMapping("/result_success")
	public String resultSuccess(
			@RequestParam String tid,
			Model model) throws URISyntaxException {
		PaySearchVO searchVO = payService.search(tid);
		model.addAttribute("searchVO",searchVO);
		
		
		
		return "pay/resultSuccess";
	}
	
	@Autowired
	private PayDao payDao;
	
	// 결제 내역 보기 페이지
	@GetMapping("/history")
	public String history(
			HttpSession session,
			Model model) {
		
		MemberDto dto = (MemberDto) session.getAttribute("dtoss");
		int memberNo = dto.getMemberNo();
		
		model.addAttribute("list",payDao.list(memberNo));
		
		return "pay/history";
	}
	
	@GetMapping("/historyDetail")
	public String historyDetail(@RequestParam int payNo, Model model) throws URISyntaxException {
		// 결제 정보 조회
		PayDto payDto = payDao.get(payNo);
		model.addAttribute("payDto", payDto);
		
		PaySearchVO searchVO = payService.search(payDto.getPayTid());
		model.addAttribute("searchVO", searchVO);
		
		return "pay/historyDetail";
	}
}
