package com.kh.khblind.company.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class CompanyDto {
	private int companyNo;
	private String companyName;
	private String companyUrl;
	private String companyDomain;
	private String companyAddr;
	private String companyIndustry;
	private Date companyEstablishment;
	private String companyIntroduce;
}
