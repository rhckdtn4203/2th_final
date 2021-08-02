package com.kh.khblind.admin.category.controller;

import java.util.List;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.khblind.admin.category.entity.CategoryDto;
import com.kh.khblind.admin.category.repository.CategoryDao;

@RequestMapping("/admin")
@Controller
public class CategoryController {
	@Autowired
	private CategoryDao categoryDao;
	@Autowired
	private SqlSession sqlSession;
	
	
//	@RequestMapping("/category")
//	public String home(Model model) {
//		List<CategoryDto>categoryList = sqlSession.selectList("category.list");
//		model.addAttribute("categoryList", categoryList);
//		return "admin/category";
//	}
	
	@GetMapping("/categoryInsert")
	public String insert() {
		return "admin/categoryList";
	}
	
	@PostMapping("/categoryInsert")
	public String insert(Model model
			,@ModelAttribute CategoryDto categoryDto) {
		categoryDao.insert(categoryDto);
		
		
		return "redirect:categoryList";
	}
	
	@GetMapping("/categoryDelete")
	public String delete(int boardCategoryNo) {
		categoryDao.delete(boardCategoryNo);
		return "redirect:categoryList";
		
	}
	@GetMapping("/categoryList")
	public String list(Model model,CategoryDto categoryDto){
		
		List<CategoryDto> categoryList = sqlSession.selectList("category.list");
		int categoryCount = categoryList.size();
		
		model.addAttribute("icon", categoryList.get(categoryList.size()-1).getBoardCategoryIcon());
		System.out.println(categoryList.get(categoryList.size()-1).getBoardCategoryIcon() + "@@@@@");
		
		for(int i=0; i<categoryList.size(); i++) {
		String categoryIcon=categoryList.get(i).getBoardCategoryIcon().replaceAll("\"", "&quot");	
		categoryList.get(i).setBoardCategoryIcon(categoryIcon);
		}
		if(categoryCount>10) {
			categoryCount=10;
		}
		model.addAttribute("categoryCount", categoryCount+1);
		model.addAttribute("categoryList", categoryList);
		return "admin/category";
	}
	@GetMapping("/categoryEdit")
	public String edit(@ModelAttribute CategoryDto categoryDto) {
		System.out.println(categoryDto);
//		for(int i=0; i<categoryList.size(); i++) {
//			categoryIcon=categoryList.get(i).getBoardCategoryIcon().replaceAll("&quot", "\"");	
//			categoryList.get(i).setBoardCategoryIcon(categoryIcon);
//			}
		
		categoryDao.edit(categoryDto);
		return "redirect:categoryList";
	}
	
}
