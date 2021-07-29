package com.kh.khblind.company.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class ReviewMemberCategoryVO {
	private int companyReviewNo;
	private int companyNo;
	private int memberNo;
	private String reviewMerit;
	private String reviewDemerit;
	private Date reviewDate;
	private int reviewRate;
	private String reviewTitle;
	private int jobCategoryNo;
	
	private String memberNick;
	
	private String jobCategoryName;
}
