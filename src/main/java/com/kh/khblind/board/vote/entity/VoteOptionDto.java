package com.kh.khblind.board.vote.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;
import lombok.Data;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class VoteOptionDto {
	private int voteOptionNo;
	private int voteTopicNo;
	private String voteOptionName;
}
