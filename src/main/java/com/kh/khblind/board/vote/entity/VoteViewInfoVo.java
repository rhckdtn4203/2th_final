package com.kh.khblind.board.vote.entity;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class VoteViewInfoVo {
	private int voteTopicNo;
	private String voteTopicTitle;
	private Date voteTopicExpire;
	private List<VoteOptionInfoVo> voteOptionInfoVoList;
}
