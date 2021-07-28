package com.kh.khblind.company.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.khblind.company.entity.CompanyReviewDto;

@Repository
public class CompanyReviewDaoImpl implements CompanyReviewDao {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void reviewWrite(CompanyReviewDto companyReviewDto) {
		sqlSession.insert("companyReview.write", companyReviewDto);
	}

	@Override
	public CompanyReviewDto companyFind(int companyNo) {
		CompanyReviewDto companyReviewDto = sqlSession.selectOne("companyReview.companyFind", companyNo);
		return companyReviewDto;
	}

	@Override
	public List<CompanyReviewDto> companyReviewList(int companyNo) {
		return sqlSession.selectList("companyReview.reviewList", companyNo);
	}

}
