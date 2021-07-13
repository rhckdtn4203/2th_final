package com.kh.khblind.company.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.khblind.company.entity.CompanyDto;

@Repository
public class CompanyDaoImpl implements CompanyDao {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insert(CompanyDto companyDto) {
		sqlSession.insert("company.insert", companyDto);
	}

}
