package com.kh.khblind.admin.category.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.khblind.admin.category.entity.CategoryDto;

@Repository
public class CategoryDaoImpl implements CategoryDao{
	@Autowired
	SqlSession sqlSession;
	
	//카테고리 생성
	@Override
	public void insert(CategoryDto categoryDto) {
		sqlSession.insert("category.insert",categoryDto);
	}
	//카테고리 삭제
	@Override
	public boolean delete(int category_no) {

		return sqlSession.delete("category.delete",category_no) > 0;
	}
	//카테고리 수정
	@Override
	public boolean edit(CategoryDto categoryDto) {

		return sqlSession.update("category.edit",categoryDto) >0;
	}
	@Override
	public List<CategoryDto> list() {
		
		return sqlSession.selectList("category.list");
	}
	
}

