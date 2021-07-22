package com.kh.khblind.board.vote.webSocket;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.khblind.board.vote.entity.VoteResultDto;

@Repository
public class RealtimeVoteChannelDaoImpl implements RealtimeVoteChannelDao{
	
	
	@Override
	public void enter(RealtimeVoterVo voteRealtimeVoterVo) {
//		users.add(visitorVO);
//		log.debug("{} 채널 사용자 입장 : 이용자 {}명", name, users.size());
	}

	@Override
	public void leave(RealtimeVoterVo voteRealtimeVoterVo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void sendVoteInfo(int memberNo, VoteResultDto voteResultDto) {
		// TODO Auto-generated method stub
		
	}

}
