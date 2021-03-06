package com.kh.khblind.board.vote.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/board")
public class RealTimeVoteController {
	@GetMapping("realtime-vote-channel/{voteChannelNo}")
	public String channel(@PathVariable Integer voteChannelNo, Model model) {
		
		model.addAttribute("voteChannelNo", voteChannelNo);
				
		return "board/voteTest";//같게 해야해요?
	}
}
