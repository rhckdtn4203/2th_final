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
	
	
	@RequestMapping("/category")
	public String home(Model model) {
		List<CategoryDto>categoryList = sqlSession.selectList("category.list");
		System.out.println("@@@@@@@@@@" +categoryList);
		model.addAttribute("categoryList", categoryList);
		return "admin/category";
	}
	
	@GetMapping("/categoryInsert")
	public String insert() {
		return "admin/category";
	}
	
	@PostMapping("/categoryInsert")
	public String insert(@ModelAttribute CategoryDto categoryDto) {
		categoryDao.insert(categoryDto);
		
		return "redirect:category";
	}
	
	@GetMapping("/categoryDelete")
	public String delete(int boardCategoryNo) {
		categoryDao.delete(boardCategoryNo);
		return "redirect:category";
		
	}
	@GetMapping("/categoryList")
	public List<CategoryDto> list(Model model){
		List<CategoryDto>categoryList = sqlSession.selectList("category.list");
		model.addAttribute("categoryList", categoryList);
		return categoryDao.list();
	}
	@GetMapping("/categoryEdit")
	public String edit(@ModelAttribute CategoryDto categoryDto) {
		categoryDao.edit(categoryDto);
		return "redirect:category";
	}
	
}
