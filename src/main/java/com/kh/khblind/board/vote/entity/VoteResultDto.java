package com.kh.khblind.board.vote.entity;

import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class VoteResultDto {
	private int voteResultNo;
	private int memberNo;
	private int voteTopicNo;
	private int voteOptionNo;
}
