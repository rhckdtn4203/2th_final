package com.kh.khblind.board.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class BoardWriteVO {
	//준비 : DB조회 1개(시퀀스번호) + 세션 1개(회원번호) + 파라미터 3개(제목,내용,해시태그)

	private String boardTitle;
	private String boardContent;
	private String boardHashtag;

}
