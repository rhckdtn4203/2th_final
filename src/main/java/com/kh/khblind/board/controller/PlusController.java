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
		
//		for(int i = 0 ; i < getPlusJobCategoryInfoList.size(); i++) {
//		int jobCategoryNo = getPlusJobCategoryInfoList.get(i).getJobCategoryNo();
//		
//		switch(jobCategoryNo) {
//			case 1:
//				break;
//			case 2:
//				break;
//			case 3:
//				break;
//			case 4:
//				break;
//			case 5:
//				break;
//			case 6:
//				break;
//			case 7:
//				break;
//			case 8:
//				break;
//			case 9:
//				break;
//			case 10:
//				break;
//			case 11:
//				break;
//			case 12:
//				break;
//			case 13:
//				break;
//			case 14:
//				break;
//			case 15:
//				break;
//			case 16:
//				break;
//			case 17:
//				break;
//			}
//		model.addAttribute("jobCategoryNo", jobCategoryNo);
//		}
		model.addAttribute("getPlusJobCategoryInfoList", getPlusJobCategoryInfoList);
	return	"/board/plusPage";	
	}

}
