package com.kh.khblind.company.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.khblind.company.entity.CompanyRegistDto;
import com.kh.khblind.company.repository.CompanyDao;
import com.kh.khblind.company.vo.CompanyVO;

@Controller
@RequestMapping("/company")
public class CompanyController {
	
	@Autowired
	private CompanyDao companyDao;

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
		
		if(companyVO != null) {
			model.addAttribute("companyVO", companyVO);
			return "/company/companyDetail";
		}
		else {
			// 임시.. 404가 정상 나중에 Filter로 500 떴을 때 error 페이지 보여줌
			return "/company/companyDetail/error";
		}
	}
	
}
