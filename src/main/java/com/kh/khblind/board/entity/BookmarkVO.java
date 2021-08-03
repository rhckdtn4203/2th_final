package com.kh.khblind.board.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor @AllArgsConstructor @Data @Builder
public class BookmarkVO {
	private int boardNo,memberNo;
	private String boardTitle,boardContent,boardCategoryName,boardCategoryIcon;
	private Date boardDate;
}
