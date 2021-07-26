package com.kh.khblind.company.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.khblind.company.entity.CompanyRegistDto;
import com.kh.khblind.company.repository.CompanyDao;
import com.kh.khblind.company.service.CompanyService;
import com.kh.khblind.company.vo.CompanyVO;

@Controller
@RequestMapping("/company")
public class CompanyController {
	
	@Autowired
	private CompanyDao companyDao;
	
	@Autowired
	private CompanyService companyService;

	@GetMapping("/registCompany")
	public String registCompany() {
		return "company/registCompany";
	}
	
	@PostMapping("/registCompany")
	public String registCompany(@ModelAttribute CompanyRegistDto companyRegistDto) {
		companyDao.registCompany(companyRegistDto);
		return "company/registCompany";
	}
	
//	@GetMapping("/companyDetail")
//	public ResponseEntity<ByteArrayResource> companyDetail(@PathVariable int companyNo) {
//		return "company/companyDetail";
//	}
//	
//	@PostMapping("/companyDetail")
//	public String companyDetail() {
//		return "company/companyDetail"; // ??
//	}
	
}
