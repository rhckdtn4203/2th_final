package com.kh.khblind.company.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.kh.khblind.company.entity.CompanyDto;
import com.kh.khblind.company.repository.CompanyDao;

@Controller
public class CompanyController {
	
	@Autowired
	private CompanyDao companyDao;

	@GetMapping("/admin/insertCompany")
	public String insertCompany() {
		return "admin/insertCompany";
	}
	
	@PostMapping("/admin/insertCompany")
	public String insertCompany(@ModelAttribute CompanyDto companyDto) {
		companyDao.insert(companyDto);
		return "redirect:insertCompany";
	}
	
}
