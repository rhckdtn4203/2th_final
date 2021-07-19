package com.kh.khblind.board.vote.entity;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class VoteInsertInfoVo {
	private int boardNo;
	private int voteTopicNo;
	private String voteTopicTitle;
	private List<String> voteTopicOption;
}
