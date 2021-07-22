package com.kh.khblind.board.entity;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class BoardWriteVO {
	
	private List<Integer> hashtagNo;
	private List<String> hashtagName;

	String boardTitle, boardContent;
	int boardNo, boardCount, memberNo;
	Date boardDate;

}
