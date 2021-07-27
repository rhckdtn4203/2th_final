package com.kh.khblind.admin.company.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.khblind.company.repository.CompanyDao;
import com.kh.khblind.company.service.CompanyService;
import com.kh.khblind.company.vo.CompanyVO;

@Controller
@RequestMapping("/admin")
public class AdminCompanyController {
	
	@Autowired
	private CompanyDao companyDao;
	
	@Autowired
	private CompanyService companyService;
	
	@GetMapping("/insertCompany")
	public String insertCompany() {
		return "admin/insertCompany";
	}
	
	@PostMapping("/insertCompany")
	public String insertCompany(
			@ModelAttribute CompanyVO companyVO, 
			@RequestParam("companyRegistNo") int companyRegistNo) throws IllegalStateException, IOException {
		companyService.companyRegistration(companyVO);
		companyDao.companyRegistDelete(companyRegistNo);
		return "redirect:insertCompany";
	}
	
	@GetMapping("/companyRegistList")
	public String companyRegistList(Model model) {
		model.addAttribute("list", companyDao.companyRegistList());
		return "admin/companyRegistList";
	}
	
	@PostMapping("/companyRegistList")
	@ResponseBody
	public String companyRegistList(@RequestParam String companyRegistName) {
		if(companyDao.companyExist(companyRegistName)) {
			return "N";
		}
		else {
			return "Y";
		}
	}
	
	@GetMapping("/companyRegistList/delete")
	public String companyRegistListDelete(
			@RequestParam("companyRegistNo") int companyRegistNo) {
		companyDao.companyRegistDelete(companyRegistNo);
		return "redirect:/admin/companyRegistList";
	}
	
}
