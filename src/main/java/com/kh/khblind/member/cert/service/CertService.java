package com.kh.khblind.member.cert.service;

import java.io.IOException;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import com.kh.khblind.member.cert.entity.CertDto;

public interface CertService {
	// DB에 회사가 존재하는지 확인
	boolean checkCompany(String email);
	// 인증 번호 발송 기능
	void sendCertification(String email, HttpSession session) throws MessagingException, IOException;
	// 인증 번호 검사 기능
	boolean checkCertification(CertDto certDto);
	// 인증 시간이 지난 인증 데이터 삭제 기능(스케줄러)
	void clearCertification();
	// 등급 업그레이드
	void upgrade(int memberNo);
}
