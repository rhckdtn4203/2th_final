package com.kh.khblind.board.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class BoardEditVO {
	//준비 : 파라미터3개(번호, 제목, 내용) + 회원번호1개(세션 = 내 글만 고칠수 있게) -> boardEditVO
	
	private int boardNo;
	private String boardTitle;
	private String boardContent;
	private int memberNo;

}
