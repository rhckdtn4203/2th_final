package com.kh.khblind.company.repository;

import java.util.List;

import com.kh.khblind.company.entity.CompanyDto;
import com.kh.khblind.company.entity.CompanyRegistDto;

public interface CompanyDao {
	void insert(CompanyDto companyDto);
	void registCompany(CompanyRegistDto companyRegistDto);
	List<CompanyRegistDto> companyRegistList();
	boolean companyRegistDelete(int companyRegistNo);
}