package com.kh.khblind.company.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.khblind.company.entity.CompanyRegistDto;
import com.kh.khblind.company.entity.CompanyReviewDto;
import com.kh.khblind.company.repository.CompanyDao;
import com.kh.khblind.company.repository.CompanyReviewDao;
import com.kh.khblind.company.vo.CompanyVO;
import com.kh.khblind.member.entity.MemberDto;

@Controller
@RequestMapping("/company")
public class CompanyController {
	
	@Autowired
	private CompanyDao companyDao;
	
	@Autowired
	private CompanyReviewDao companyReviewDao;

	@GetMapping("/registCompany")
	public String registCompany() {
		return "company/registCompany";
	}
	
	@PostMapping("/registCompany")
	public String registCompany(@ModelAttribute CompanyRegistDto companyRegistDto) {
		companyDao.registCompany(companyRegistDto);
		return "company/registCompany";
	}
	
	@GetMapping("/companyDetail")
	public String companyDetail(int companyNo, Model model) {
		CompanyVO companyVO = companyDao.companyFind(companyNo);
		
		if(companyVO != null) {;
			model.addAttribute("companyVO", companyVO);
			return "company/companyDetail";
		}
		else {
			// 임시.. 404가 정상 나중에 Filter로 500 떴을 때 error 페이지 보여줌
			return "company/companyDetail/error";
		}
	}
	
	@GetMapping("/companyReview")
	public String companyReview(int companyNo, Model model) {
		CompanyVO companyVO = companyDao.companyFind(companyNo);
		
		model.addAttribute("list", companyReviewDao.companyReviewList(companyNo));
		
		if(companyVO != null) {;
			model.addAttribute("companyVO", companyVO);
			return "company/companyReview";
		}
		else {
			// 임시.. 404가 정상 나중에 Filter로 500 떴을 때 error 페이지 보여줌
			return "company/companyReview/error";
		}
	}
	
	@GetMapping("/reviewWrite")
	public String reviewWrite(int companyNo, HttpSession session, Model model) {
		MemberDto memberDto = (MemberDto)session.getAttribute("dtoss");
		int memberNo = memberDto.getMemberNo();
		
		System.out.println(memberNo);
		
		Map<String, Object> map = new HashMap<>();
		map.put("memberNo", memberNo);
		map.put("companyNo", companyNo);

		if(memberNo != 0 && companyNo != 0) {
			model.addAttribute("map", map);
		}
		
		return "company/reviewWrite";
		
		// 로그인 상황 아닌 경우 처리 해야 함
	}
	
	@PostMapping("/reviewWrite")
	public String reviewWrite(@ModelAttribute CompanyReviewDto companyReviewDto) {
		companyReviewDao.reviewWrite(companyReviewDto);
		return "redirect:companyReview?companyNo="+companyReviewDto.getCompanyNo();
	}
	
}
