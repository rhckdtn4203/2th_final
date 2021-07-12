package com.kh.khblind.member.cert.repository;

import com.kh.khblind.member.cert.entity.CertDto;

public interface CertDao {
	void insert(CertDto certDto);
	boolean check(CertDto certDto);
	void deleteByEmail(String email);
	void clear();
}