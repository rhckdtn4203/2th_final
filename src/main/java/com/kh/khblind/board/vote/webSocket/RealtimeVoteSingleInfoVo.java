package com.kh.khblind.board.vote.webSocket;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class RealtimeVoteSingleInfoVo {
	private Integer voteTopicNo;
	private int boardNo;
	private int voteOptionNo;
	boolean didYouVote;
	private int receivePayloadType;
}
