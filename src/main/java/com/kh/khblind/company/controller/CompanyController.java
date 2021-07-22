package com.kh.khblind.company.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.kh.khblind.company.entity.CompanyDto;
import com.kh.khblind.company.entity.CompanyRegistDto;
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
	
	@GetMapping("/company/registCompany")
	public String registCompany() {
		return "company/registCompany";
	}
	
	@PostMapping("/company/registCompany")
	public String registCompany(@ModelAttribute CompanyRegistDto companyRegistDto) {
		companyDao.registCompany(companyRegistDto);
		return "company/registCompany"; // 수정해야함..
	}
	
	@GetMapping("/admin/companyRegistList")
	public String companyRegistList(Model model) {
		model.addAttribute("list", companyDao.companyRegistList());
		return "admin/companyRegistList";
	}
	
}
