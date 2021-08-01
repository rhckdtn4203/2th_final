package com.kh.khblind.board.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class MainCategoryDataVO {
	
	private int boardCategoryNo;
	private String boardCategoryName;
	private String boardCategoryIcon;
	private int boardNo;
	private String boardTitle;
	private int boardCount;
	

}
