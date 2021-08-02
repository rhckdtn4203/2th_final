package com.kh.khblind.company.service;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;

import com.kh.khblind.company.vo.CompanyVO;

public interface CompanyService {
	void companyRegistration(CompanyVO companyVO) throws IllegalStateException, IOException;
}
