package com.kh.khblind.search.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.khblind.search.entity.SearchDto;
import com.kh.khblind.search.repository.SearchDao;

@Controller
@RequestMapping("/search")
public class SearchController {
	
	@Autowired
	private SearchDao searchDao;
	
	@PostMapping("/insert")
	public String insert(
			@ModelAttribute SearchDto searchDto) {
		
		String searchKeyword = searchDto.getSearchKeyword();
		
		if(searchDao.get(searchKeyword)!=null) {
			searchDao.update(searchKeyword);
		}
		else {
			// 시퀀스번호
			int searchNo = searchDao.getSequence();
			searchDto.setSearchNo(searchNo);
			searchDto.setSearchKeyword(searchKeyword);
			
			searchDao.insert(searchDto);
		}
		return "redirect:search_result?searchKeyword="+searchKeyword;
	}
	

	
	// 검색 결과 페이지
	@GetMapping("/search_result")
	public String history(
				HttpSession session,
				Model model,
				@RequestParam String searchKeyword
				) {
		
		model.addAttribute("list",searchDao.list(searchKeyword));
		
			
			return "search/result";
		}

}
