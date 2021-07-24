package com.kh.khblind.board.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class BoardEditGetInfoVO {
	private int boardNo;
	private int memberNo;
	private String boardTitle;
	private String boardContent;
	private String boardCount;
	private Date boardDate;
	
	private String boardTypeName;
	private String typeName;
}
