package com.kh.khblind.search.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class SearchDto {
	private int searchNo;
	private String keyword;
	private int searchCount;
}
