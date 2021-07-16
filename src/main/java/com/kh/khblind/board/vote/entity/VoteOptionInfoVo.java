package com.kh.khblind.board.vote.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class VoteOptionInfoVo {
	private int voteOptionNo; // 쓸 데가 있겠지... 있었다...!
	private String voteOptionName; 
	private int voteOptionCount;
	private int voteOptionPercent; 
}