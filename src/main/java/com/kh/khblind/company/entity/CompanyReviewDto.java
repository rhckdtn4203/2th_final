package com.kh.khblind.company.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class CompanyReviewDto {
	private int companyReviewNo;
	private int companyNo;
	private int memberNo;
	private String reviewTitle;
	private String reviewMerit;
	private String reviewDemerit;
	private Date reviewDate;
	private double reviewRate;
}
