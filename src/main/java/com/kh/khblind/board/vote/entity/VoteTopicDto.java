package com.kh.khblind.board.vote.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class VoteTopicDto {
	private Integer voteTopicNo;
	private int boardNo;
	private String voteTopicTitle;
	private Date voteTopicExpire;
}
