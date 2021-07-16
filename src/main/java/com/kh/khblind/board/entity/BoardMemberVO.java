package com.kh.khblind.board.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class BoardMemberVO {
	//BoardDetail.jsp에서 회원번호 대신 회원닉네임을 찍어주기 위한 임시 VO
	private int boardNo;
	private String memberNick;
	private String boardTitle;
	private String boardContent;
	private Date boardDate;

}
