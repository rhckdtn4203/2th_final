package com.kh.khblind.company.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class JobCategoryDto {
	private int jobCategoryNo;
	private String jobCategoryName;
}
