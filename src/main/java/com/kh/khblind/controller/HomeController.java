package com.kh.khblind.controller;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.khblind.board.repository.BoardDao;
import com.kh.khblind.member.entity.MemberDto;


@Controller
public class HomeController {
	
	@Autowired
	BoardDao boardDao;
	
	
	@RequestMapping("/")
	public String home(HttpSession session, Model model) {
		
		MemberDto memberDto = (MemberDto)session.getAttribute("dtoss");
		if(memberDto !=null) {
		int companyNo = memberDto.getCompanyNo();
		int jobCategoryNo = memberDto.getJobCategoryNo();
		String companyName = boardDao.getCompanyName(companyNo);
		String jobCategoryName = boardDao.getJobCategoryName(jobCategoryNo);
		model.addAttribute("companyName", companyName);
		model.addAttribute("jobCategoryName", jobCategoryName);
		}
		return "/home";
	}
}
