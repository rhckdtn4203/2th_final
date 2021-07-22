package com.kh.khblind.company.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.khblind.company.entity.CompanyDto;
import com.kh.khblind.company.entity.CompanyRegistDto;

@Repository
public class CompanyDaoImpl implements CompanyDao {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insert(CompanyDto companyDto) {
		sqlSession.insert("company.insert", companyDto);
	}

	@Override
	public void registCompany(CompanyRegistDto companyRegistDto) {
		sqlSession.insert("company.regist", companyRegistDto);
	}

	@Override
	public List<CompanyRegistDto> companyRegistList() {
		return sqlSession.selectList("company.registList");
	}

}
