package com.kh.khblind.admin.category.repository;



import java.util.List;

import com.kh.khblind.admin.category.entity.CategoryDto;

public interface CategoryDao {
	void insert(CategoryDto categoryDto);
	boolean delete(int category_no);
	boolean edit(CategoryDto categoryDto);
	List<CategoryDto> list();
}
