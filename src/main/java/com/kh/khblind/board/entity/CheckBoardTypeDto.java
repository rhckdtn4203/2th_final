package com.kh.khblind.board.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;
import lombok.Data;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class CheckBoardTypeDto {
	private int boardNo;
	private Integer boardCategoryNo;
	private Integer jobCategoryNo;
	private Integer companyNo;
}