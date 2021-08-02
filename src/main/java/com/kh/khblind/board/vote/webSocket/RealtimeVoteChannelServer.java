package com.kh.khblind.board.vote.webSocket;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.web.socket.WebSocketSession;

import com.kh.khblind.board.vote.entity.VoteOptionInfoVo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class RealtimeVoteChannelServer {

	private List<RealtimeVoterVo> waiting = new ArrayList<>();//대기실
	private List<RealtimeVoteChannel> channels = new ArrayList<>();//채널저장소
	
	//채널탐색
	public boolean exist(Integer voteChannelNo) {
		return findChannel(voteChannelNo) != null;
	}
	
	public RealtimeVoteChannel findChannel(Integer voteChannelNo) {
		for(RealtimeVoteChannel realtimeVoteChannel : channels) {
			if(realtimeVoteChannel.getRealtimeVoteChannelNo()==voteChannelNo) {
				return realtimeVoteChannel;
			}
		}
		return null;
	}

	//대기실입장
	public void start(RealtimeVoterVo realtimeVoterVo) {
		waiting.add(realtimeVoterVo);
		log.debug("대기실 입장 - 현재 대기자 {} 명", waiting.size());
	}
	
	//투표채널입장
	public void enter(int memberNo, Integer voteChannelNo) {
		RealtimeVoterVo voter = findWaiting(memberNo);
		System.out.println("세션이나 있냐...? voter = "+ voter);
		waiting.remove(voter);
		
		RealtimeVoteChannel realtimeVoteChannel = findChannel(voteChannelNo);
		System.out.println("realtimeVoteChannel = " + realtimeVoteChannel);
		if(realtimeVoteChannel == null) {//채널이 없는 경우에는 채널을 추가한다
			
			realtimeVoteChannel = new RealtimeVoteChannel(voteChannelNo);

			channels.add(realtimeVoteChannel);
			log.debug("신규 채널 생성 : {}", voteChannelNo);
		}

		realtimeVoteChannel.enter(voter);
	}
	
	//대기실안에서 member 탐색
	public RealtimeVoterVo findWaiting(int memberNo) {
		for(RealtimeVoterVo voters : waiting) {
			if(voters.getMemberNo() == memberNo) {
				return voters;
			}
		}
		return null;
	}
	
	//투표정보 전송
	public void send(int memberNo, int voteChannelNo, int voteOptionNo) throws IOException {
		RealtimeVoteChannel realtimeVoteChannel = findChannel(voteChannelNo);
		if(realtimeVoteChannel != null) {
			realtimeVoteChannel.sendVoteInfo(memberNo, voteOptionNo);
		}
	}
	
	//사용자 퇴장(+ 투표채널 삭제)
	//= 채널 탐색 + 사용자 제거 + (채널 삭제)
//	public void leave(int memberNo, int voteChannelNo, WebSocketSession session) {
	public void leave(int memberNo, int voteChannelNo) {
		RealtimeVoteChannel realtimeVoteChannel = findChannel(voteChannelNo);
	
		
//		realtimeVoteChannel.leave(memberNo, session);
		realtimeVoteChannel.leave(memberNo);		
		
		if(realtimeVoteChannel.getRealtimeVoters().size() ==0) {
			channels.remove(realtimeVoteChannel);
			log.debug("채널 삭제 : {}", realtimeVoteChannel);
		}
	}
//	public void leave(int memberNo) {
//		for(RealtimeVoteChannel realtimeVoteChannel : channels) {
//			leave(memberNo, realtimeVoteChannel.getRealtimeVoteChannelNo(), session);
//		}
//	}
}
