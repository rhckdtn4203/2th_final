package com.kh.khblind.search.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.khblind.search.entity.SearchDto;
import com.kh.khblind.search.repository.SearchDao;

@RestController
@RequestMapping("/search")
public class SearchController {
	
	@Autowired
	private SearchDao searchDao;
	
	@GetMapping("/keywordList")
	public List<SearchDto> test4(){
		return searchDao.list();
	}
}
