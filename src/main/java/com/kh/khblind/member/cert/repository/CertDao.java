package com.kh.khblind.member.cert.repository;

import com.kh.khblind.member.cert.entity.CertDto;

public interface CertDao {
	void insert(CertDto certDto);
	boolean check(CertDto certDto);
	void deleteByEmail(String email);
	void clear();
	void upgrade(int memberNo);
	boolean checkCompany(String companyDomain);
	
	//아래는 석현
	String checkImageCertProgress (int memberNo);
	void approveImageCert(int memberNo);
	void rejectImageCert(int memberNo, String imageCertMessage);
	String getImageCertMessage(int memberNo);
}