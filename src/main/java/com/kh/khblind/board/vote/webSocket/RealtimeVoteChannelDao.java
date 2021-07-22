package com.kh.khblind.board.vote.webSocket;

import com.kh.khblind.board.vote.entity.VoteResultDto;

public interface RealtimeVoteChannelDao {
	//1.실시간투표채널 입장
		public void enter(RealtimeVoterVo voteRealtimeVoterVo);
	//2.실시간투표채널 퇴장(memberNo로만 해야할 필요가 있을까?)
		public void leave(RealtimeVoterVo voteRealtimeVoterVo);
	//3.투표정보전송
		public void sendVoteInfo (int memberNo, VoteResultDto voteResultDto);
}
