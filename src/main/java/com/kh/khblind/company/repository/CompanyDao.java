package com.kh.khblind.company.repository;

import java.util.HashMap;
import java.util.List;

import com.kh.khblind.company.entity.CompanyDto;
import com.kh.khblind.company.entity.CompanyRegistDto;
import com.kh.khblind.company.entity.JobCategoryDto;
import com.kh.khblind.company.vo.CompanyVO;

public interface CompanyDao {
	int sequence();
	void insert(CompanyDto companyDto);
	void registCompany(CompanyRegistDto companyRegistDto);
	List<CompanyRegistDto> companyRegistList();
	boolean companyRegistDelete(int companyRegistNo);
	boolean companyExist(String companyName);
	CompanyVO companyFind(int companyNo);
	List<JobCategoryDto> categories();
	List<HashMap<String, Integer>> searchKeyword(String keyword);
	List<HashMap<String, Integer>> rateTopSix();
}