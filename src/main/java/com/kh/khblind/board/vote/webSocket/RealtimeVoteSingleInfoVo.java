package com.kh.khblind.board.vote.webSocket;

import java.sql.Date;
import java.util.List;

import com.kh.khblind.board.vote.entity.VoteOptionInfoVo;
import com.kh.khblind.board.vote.entity.VoteViewInfoVo;

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
