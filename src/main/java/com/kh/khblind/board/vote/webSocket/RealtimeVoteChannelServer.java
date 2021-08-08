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
	private List<RealtimeVoteChannel> realtimeVoteChannels = new ArrayList<>();//채널저장소
	
	//채널탐색
	public boolean exist(Integer voteChannelNo) {
		return find(voteChannelNo) != null;
	}
	
	public RealtimeVoteChannel find(Integer voteChannelNo) {
		for(int i = 0; i<realtimeVoteChannels.size(); i++) {
			if(realtimeVoteChannels.get(i).getRealtimeVoteChannelNo().equals(voteChannelNo)) {
				return realtimeVoteChannels.get(i);
			}
		}
		return null;
	}

	//대기실입장
	public void start(RealtimeVoterVo realtimeVoterVo) {
		waiting.add(realtimeVoterVo);
		log.debug("대기실 입장 - 현재 대기자 {} 명", waiting.size());
	}
	
	//투표권자가 투표채널입장
	public void enter(int memberNo, Integer voteChannelNo) {
//		voteChannelNo = 175;
		RealtimeVoterVo voter = findWaiting(memberNo);
		log.debug("{}번 회원 입장", voter);
		waiting.remove(voter);
		
		RealtimeVoteChannel realtimeVoteChannel = find(voteChannelNo);
		if(realtimeVoteChannel == null) {//채널이 없는 경우에는 채널을 추가한당...
			realtimeVoteChannel = new RealtimeVoteChannel(voteChannelNo);
			realtimeVoteChannels.add(realtimeVoteChannel);
			log.debug("신규 채널 생성 : {}", voteChannelNo);
			for(int i = 0; i< realtimeVoteChannels.size(); i++) {
				log.debug("채녈 {}",realtimeVoteChannels.get(i).getRealtimeVoteChannelNo());
			}

		}

		realtimeVoteChannel.enter(voter);
	}
	
	//투표권자 퇴장
	public void leave(int memberNo, int voteChannelNo) {
		RealtimeVoteChannel realtimeVoteChannel = find(voteChannelNo);
		realtimeVoteChannel.leave(memberNo);
		
		if(realtimeVoteChannel.isEmpty()) {
			realtimeVoteChannels.remove(realtimeVoteChannel);
			log.debug("채널 삭제 = ", realtimeVoteChannel); 
		}
	}
	
	public void leave(int memberNo) {
		for(RealtimeVoteChannel realtimeVoteChannel : realtimeVoteChannels) {
			leave(memberNo, realtimeVoteChannel.getRealtimeVoteChannelNo());
		}
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
		RealtimeVoteChannel realtimeVoteChannel = find(voteChannelNo);
//		realtimeVoteChannel.setRealtimeVoteChannelNo(175);
		if(realtimeVoteChannel != null) {
			realtimeVoteChannel.sendVoteInfo(memberNo, voteOptionNo);
		}
	}

}
