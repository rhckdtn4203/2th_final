package com.kh.khblind.company.repository;

import com.kh.khblind.company.entity.CompanyProfileDto;

public interface CompanyProfileDao {
	void insert(CompanyProfileDto profileDto);
	CompanyProfileDto getCompanyNo(int companyNo);
}
