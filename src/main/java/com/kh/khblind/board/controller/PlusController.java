package com.kh.khblind.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.khblind.board.entity.JobCategoryInfoDto;
import com.kh.khblind.board.repository.BoardDao;
import com.kh.khblind.company.entity.JobCategoryDto;

@RequestMapping("/plus")
@Controller
public class PlusController {
	
	@Autowired
	private BoardDao boardDao;
	
	@GetMapping("/plusPage")
	public String plusPage(
			Model model
			) {
		//jobCategoryNo 다 가져와서 스위치로 뿌려주기
		List<JobCategoryDto> getPlusJobCategoryInfoList = boardDao.getPlusJobCategoryInfo();
		

		model.addAttribute("getPlusJobCategoryInfoList", getPlusJobCategoryInfoList);
	return	"/board/plusPage";	
	}

}
