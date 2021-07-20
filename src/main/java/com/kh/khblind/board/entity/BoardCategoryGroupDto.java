package com.kh.khblind.board.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class BoardCategoryGroupDto {
	private int boardCategoryNo;
	private int boardNo;

}
