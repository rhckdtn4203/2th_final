package com.kh.khblind.company.repository;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.khblind.company.entity.CompanyReviewDto;
import com.kh.khblind.company.vo.ReviewMemberCategoryVO;

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
	public List<ReviewMemberCategoryVO> companyReviewList(int companyNo) {
		return sqlSession.selectList("companyReview.reviewList", companyNo);
	}

	@Override
	public double companyReviewRate(int companyNo) {
		return sqlSession.selectOne("companyReview.reviewRate", companyNo);
	}

	@Override
	public int companyReviewCount(int companyNo) {
		return sqlSession.selectOne("companyReview.reviewCount", companyNo);
	}

	@Override
	public List<HashMap<String, String>> companyScoreCount(int companyNo) {
		return sqlSession.selectList("companyReview.scoreCount", companyNo);
	}

}
