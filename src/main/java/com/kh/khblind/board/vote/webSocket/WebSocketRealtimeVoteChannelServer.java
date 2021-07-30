package com.kh.khblind.board.vote.webSocket;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.khblind.board.vote.entity.VoteOptionInfoVo;
import com.kh.khblind.board.vote.entity.VoteViewInfoVo;
import com.kh.khblind.board.vote.repository.VoteDao;
import com.kh.khblind.member.entity.MemberDto;

public class WebSocketRealtimeVoteChannelServer extends TextWebSocketHandler{

	private RealtimeVoteChannelServer server = new RealtimeVoteChannelServer();
	
	@Autowired
	private VoteDao voteDao;
	
	//상수?
	public static final int JOIN = 1;
	public static final int SENDINFO = 2;
	public static final int LEAVE = 3;
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		//접속 시에 채널을 알 수 있는 방법이 없으므로 우선 대기실로 입장시킨다.
		// = 사용자가 접속 후에 본인이 몇 채널인지 서버로 메세지를 전송해야 한다.
		// = 채널은 사용자가 메세지를 접속하자마자 첫 메세지를 전송하는 순간 알 수 있다.
		MemberDto memberDto = (MemberDto) session.getAttributes().get("dtoss");
		Integer memberNo = memberDto.getMemberNo();
		
		Integer voteChannelNo = (Integer) session.getAttributes().get("voteChannelNo");
		
		if(memberNo == null) {
			return;} //비회원 고려하지 않음, 근데 이미 jsp상에서 안뜨게 했지만 또 막자.
		RealtimeVoterVo realtimeVoterVo = RealtimeVoterVo.builder()
																	.memberNo(memberNo)
																	.voteChannelNo(voteChannelNo)
																	.session(session)
																	.build();
		server.start(realtimeVoterVo);
		
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		//메세지의 payload를 가져온다(JSON String)
		String payload = message.getPayload();
		
		//payload를 ReceiveVO 객체로 변환한다(Jackson , ObjectMapper)
		ObjectMapper mapper = new ObjectMapper();
		RealtimeVoteSingleInfoVo realtimeVoteSingleInfoVo = mapper.readValue(payload, RealtimeVoteSingleInfoVo.class);
		
		
		
		MemberDto memberDto = (MemberDto) session.getAttributes().get("dtoss");
		Integer memberNo = -1;
		if(memberDto != null) {
			memberNo = memberDto.getMemberNo();
		}
		
		//JOIN(1) 이면 대기실에 있는 사용자를 채널로 이동
		//MESSAGE(2) 이면 해당 채널에 메세지를 전송
		if(realtimeVoteSingleInfoVo.getReceivePayloadType() == JOIN) {
			server.enter(memberNo, realtimeVoteSingleInfoVo.getVoteTopicNo());
		}
		if(realtimeVoteSingleInfoVo.getReceivePayloadType() == SENDINFO) {
			server.send(memberNo, realtimeVoteSingleInfoVo.getVoteTopicNo(), realtimeVoteSingleInfoVo.getVoteOptionNo());
		}
		else if(realtimeVoteSingleInfoVo.getReceivePayloadType() == LEAVE) {
//			server.leave(memberNo, realtimeVoteSingleInfoVo.getVoteTopicNo(), session);
			System.out.println(realtimeVoteSingleInfoVo + "나가는중");
			server.leave(memberNo, realtimeVoteSingleInfoVo.getVoteTopicNo());
		}
	}
	
	
}
