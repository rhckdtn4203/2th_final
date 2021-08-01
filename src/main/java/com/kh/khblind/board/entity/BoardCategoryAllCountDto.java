package com.kh.khblind.board.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class BoardCategoryAllCountDto {
	
	private int rn;
	private int boardCategoryNo;
	private String boardCategoryName;
	private int allCount;
	

}
