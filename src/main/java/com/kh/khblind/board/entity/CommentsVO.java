package com.kh.khblind.board.entity;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor @AllArgsConstructor @Data @Builder
public class CommentsVO {
	private String commentsContent,commentsMemberName, companyName, memberNick;
	private int commentsNo,commentsSuperNo, memberNo, boardNo, commentsGroupNo;
	private Date commentsDate;
	
	private int ownComments; //내 댓글인이 확인하는 임시 데이터
	private int isLiked; //내 댓글인이 확인하는 임시 데이터
}
