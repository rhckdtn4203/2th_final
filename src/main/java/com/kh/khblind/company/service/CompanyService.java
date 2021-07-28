package com.kh.khblind.company.service;

import java.io.IOException;

import com.kh.khblind.company.vo.CompanyVO;

public interface CompanyService {
	void companyRegistration(CompanyVO companyVO) throws IllegalStateException, IOException;
}
