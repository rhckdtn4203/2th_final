package com.kh.khblind.board.vote.webSocket;

import org.springframework.web.socket.WebSocketSession;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;
import lombok.Data;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class RealtimeVoterVo {
	private Integer memberNo;
	private Integer voteChannelNo;
//	private Integer voteOptionNo;	
	private WebSocketSession session;
}
