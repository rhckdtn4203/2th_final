package com.kh.khblind.company.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.khblind.company.entity.CompanyProfileDto;

@Repository
public class CompanyProfileDaoImpl implements CompanyProfileDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(CompanyProfileDto profileDto) {
		sqlSession.insert("companyProfile.insert", profileDto);
	}

	@Override
	public CompanyProfileDto getCompanyNo(int companyNo) {
		return sqlSession.selectOne("companyProfile.getCompanyNo", companyNo);
	}
}
