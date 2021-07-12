package com.kh.khblind.member.cert.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class CertDto {
	private String email;
	private String emailCertNo;
	private Date emailCertTime;
}