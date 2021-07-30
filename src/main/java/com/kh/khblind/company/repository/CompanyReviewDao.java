package com.kh.khblind.company.repository;

import java.util.HashMap;
import java.util.List;

import com.kh.khblind.company.entity.CompanyReviewDto;
import com.kh.khblind.company.vo.ReviewMemberCategoryVO;

public interface CompanyReviewDao {
	void reviewWrite(CompanyReviewDto companyReviewDto);
	CompanyReviewDto companyFind(int companyNo);
	List<ReviewMemberCategoryVO> companyReviewList(int companyNo);
	double companyReviewRate(int companyNo);
	int companyReviewCount(int companyNo);
	List<HashMap<String, Integer>> companyScoreCount(int companyNo);
}
