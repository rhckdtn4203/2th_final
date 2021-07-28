package com.kh.khblind.company.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class CompanyProfileDto {
	private int companyNo;
	private String companyProfileUploadName;
	private String companyProfileSaveName;
	private String companyProfileContentType;
	private long companyProfileSize;
}
