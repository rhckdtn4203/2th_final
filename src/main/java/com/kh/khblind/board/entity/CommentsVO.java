package com.kh.khblind.board.entity;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor @AllArgsConstructor @Data @Builder
public class CommentsVO {
	private String commentsContent,commentsMemberName;
	private int commentsNo,commentsSuperNo,memberNo,boardNo;
	private Date commentsDate;
}
