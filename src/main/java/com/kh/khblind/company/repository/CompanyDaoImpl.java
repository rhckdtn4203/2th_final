package com.kh.khblind.company.repository;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.khblind.company.entity.CompanyDto;
import com.kh.khblind.company.entity.CompanyRegistDto;
import com.kh.khblind.company.entity.JobCategoryDto;
import com.kh.khblind.company.vo.CompanyVO;

@Repository
public class CompanyDaoImpl implements CompanyDao {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public int sequence() {
		return sqlSession.selectOne("company.sequence");
	}
	
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

	@Override
	public boolean companyRegistDelete(int companyRegistNo) {
		int count = sqlSession.delete("company.companyRegistDelete", companyRegistNo);
		return count > 0;
	}

	@Override
	public boolean companyExist(String companyName) {
		return sqlSession.selectOne("company.exist", companyName) != null;
	}

	@Override
	public CompanyVO companyFind(int companyNo) {
		CompanyVO companyVO = sqlSession.selectOne("company.find", companyNo);
		return companyVO;
	}

	@Override
	public List<JobCategoryDto> categories() {
		return sqlSession.selectList("company.categories");
	}

	@Override
	public List<HashMap<String, Integer>> searchKeyword(String keyword) {
		return sqlSession.selectList("company.searchKeyword", keyword);
	}

	@Override
	public List<HashMap<String, Integer>> rateTopSix() {
		return sqlSession.selectList("company.rateTopSix");
	}

}
