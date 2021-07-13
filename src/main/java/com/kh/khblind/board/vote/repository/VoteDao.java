package com.kh.khblind.board.vote.repository;

import com.kh.khblind.board.vote.entity.VoteOptionDto;
import com.kh.khblind.board.vote.entity.VoteResultDto;
import com.kh.khblind.board.vote.entity.VoteTopicDto;
import com.kh.khblind.board.vote.entity.VoteViewVo;

public interface VoteDao {
		//1. 해당게시글에 투표가 있는지 없는지 보여주기
		boolean isExist(int boardNo); 
		//2. 투표주제입력
		boolean insertTopic(VoteTopicDto voteTopicDto);
		//3. 투표선택지입력
		boolean insertOption(VoteOptionDto voteOptionDto);
		//4. 투표정보불러오기(후덜덜)
		VoteViewVo getVoteFullInfo(int boardNo);
		//5. 투표하기
		boolean voting(VoteResultDto voteResultDto);
		//6. 투표결과만 가져오기(ajax용)
		VoteResultDto getVotePartInfo();
	
}
