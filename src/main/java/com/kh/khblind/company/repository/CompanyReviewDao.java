package com.kh.khblind.company.repository;

import java.util.List;

import com.kh.khblind.company.entity.CompanyReviewDto;

public interface CompanyReviewDao {
	void reviewWrite(CompanyReviewDto companyReviewDto);
	CompanyReviewDto companyFind(int companyNo);
	List<CompanyReviewDto> companyReviewList(int companyNo);
}
