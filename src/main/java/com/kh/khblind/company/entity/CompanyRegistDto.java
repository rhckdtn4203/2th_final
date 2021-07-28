package com.kh.khblind.company.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class CompanyRegistDto {
	private int companyRegistNo;
	private String companyRegistName;
	private String companyRegistDomain;
}
