package com.kh.khblind.board.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class CompanyBoardDto {
	private int companyNo;
	private String boardTitle;
	private String boardContent;
	private int boardCount;
	private String memberNick;
	private Date boardDate;
}
