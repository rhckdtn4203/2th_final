package com.kh.khblind.board.vote.webSocket;

import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

import org.springframework.web.socket.TextMessage;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import lombok.extern.slf4j.Slf4j;

/* 
 * 		개별 실시간투표채널
 * 		필드 : 실시간투표채널이름, 저장소
 * 		메소드 : 채널입장, 채널퇴장, 투표정보 전송
 */

@Slf4j
public class RealtimeVoteChannel {
	
	//요소2개 
	//실시간투표채널이름 
	@Setter @Getter
	private Integer realtimeVoteChannelNo;
	
	//실시간투표권자정보
	@Getter
	private Set<RealtimeVoterVo> realtimeVoters;
	
	//생성자
	@Builder
	public RealtimeVoteChannel(Integer voteTopicNo) {
//		this.realtimeVoteChannelNo = 175;
		this.realtimeVoteChannelNo = voteTopicNo;
		this.realtimeVoters = new HashSet<>();
	}
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/*
	 *  기능들
	 */
	
	//1.실시간투표채널 입장
	public void enter(RealtimeVoterVo voteRealtimeVoterVo) {
		realtimeVoters.add(voteRealtimeVoterVo);
		log.debug("채널{} 사용자 입장 : 이용자 {}명", realtimeVoters, realtimeVoters.size());
	};
	
	
	
	
	//2.실시간투표채널 퇴장(memberNo로만 해야할 필요가 있을까?)

	public void leave(int memberNo) {

		for(RealtimeVoterVo realtimeVoter : realtimeVoters) {
			if(realtimeVoter.getMemberNo() == memberNo) {
				leave(realtimeVoter);
				break;
			}
		}
	}
	
	public void leave (RealtimeVoterVo realtimeVoter) {
		realtimeVoters.remove(realtimeVoter);
	}

	
	
	//3.투표정보전송
	public void sendVoteInfo (int memberNo, int voteOptionNo) throws IOException { //사실 누가 투표했는지는 전송 안 해도 됨

		//메세지 생성
		RealtimeVoteSingleInfoVo realtimeVoteSingleInfoVo = 
				RealtimeVoteSingleInfoVo.builder()
						.voteOptionNo(voteOptionNo)
						.build();

		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(realtimeVoteSingleInfoVo);
				
		TextMessage tm = new TextMessage(json);
		
		for(RealtimeVoterVo realtimeVoterVo : realtimeVoters) {
			realtimeVoterVo.getSession().sendMessage(tm);
		}
	}
	
	//투표권자 탐색
	public RealtimeVoterVo find(int memberNo) {
		for(RealtimeVoterVo realtimeVoter : realtimeVoters) {
			if(realtimeVoter.getMemberNo() == memberNo) {
				return realtimeVoter;
			}
		}
		return null;
	}
	
	//채널 빈거 확인
	public boolean isEmpty() {
		return realtimeVoters.size() == 0;
	}
	
	
}
