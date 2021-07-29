package com.kh.khblind.company.vo;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class CompanyVO {
	private String companyName;
	private String companyUrl;
	private String companyDomain;
	private String companyAddr;
	private String companyIndustry;
	private Date companyEstablishment;
	private String companyIntroduce;
	
	private MultipartFile companyProfile;
	
	private String companyProfileUploadName;
	private String companyProfileSaveName;
	private String companyProfileContentType;
	private long companyProfileSize;
	
	private int companyNo;
}
