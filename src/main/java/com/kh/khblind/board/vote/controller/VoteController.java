package com.kh.khblind.board.vote.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.khblind.board.vote.entity.VoteResultDto;
import com.kh.khblind.board.vote.entity.VoteTopicDto;
import com.kh.khblind.board.vote.entity.VoteViewInfoVo;
import com.kh.khblind.board.vote.entity.VoteInsertInfoVo;
import com.kh.khblind.board.vote.entity.VoteOptionDto;
import com.kh.khblind.board.vote.entity.VoteOptionInfoVo;
import com.kh.khblind.board.vote.repository.VoteDao;
import com.kh.khblind.member.entity.MemberDto;

//나중에 BoardController와 병합예정

@Controller
@RequestMapping("/board")
public class VoteController {

	@Autowired
	private VoteDao voteDao;
	
	@GetMapping("/getVoteTest")
	public String voteTest1(Model model, HttpSession session) {
		int boardNo = 2; //BoardController와 병합시 사라짐

		//토픽 정보를 가져온다
		VoteTopicDto voteTopicDto = voteDao.getVoteTopicInfo(boardNo);
		
		//1. 이미 투표한건지 알아본다.
		int voteTopicNo = voteTopicDto.getVoteTopicNo();

		try {
			
			MemberDto memberDto = (MemberDto) session.getAttribute("dtoss");
			int memberNo = memberDto.getMemberNo();
			
			VoteResultDto voteResultDto =  VoteResultDto.builder()
					.voteTopicNo(voteTopicNo)
					.memberNo(memberNo)
					.build();
			boolean didYouVote = voteDao.didYouVote(voteResultDto);
				
			if(didYouVote) {
				
				int selectedVoteOptionNo = voteDao.getSelectedOptionNoThatTopic(voteResultDto);
				model.addAttribute("selectedVoteOptionNo", selectedVoteOptionNo);
				model.addAttribute("didYouVote", "voted");
				
			}else {
				model.addAttribute("didYouVote", "didntVote");

			}			
			
		} catch (NullPointerException nullPointerException) {//memberDto가 비어있을 때 - 로그인 안 하고 들어올때 
				model.addAttribute("didYouVote", "notLogin"); //이름... ㅠㅠㅠ
		}
		

		
		
		
		
		model.addAttribute("VoteTopicInfo", voteTopicDto);

		//선택지 정보를 가져온다
		
		List<VoteOptionInfoVo> voteOptionInfoVoList = voteDao.getVoteOptionInfo(boardNo);
		
		model.addAttribute("VoteOptionInfo", voteOptionInfoVoList);
		
		
		return "board/voteTest";
	}
	
	@GetMapping("/inputVoteTest")
	public String VoteInput() {
		
		return "board/voteTestInput";
	}
	
	
	@PostMapping("/inputVoteTest")
	public String voteTestInput(VoteInsertInfoVo voteInsertInfoVo) {//VO안의 변수명 = 파라미터명이라면 알아서 VO에 데이터를 넣어줍니다.
		int boardNo = 2; //-임시 데이터 BoardController와 병합시 사라짐
		
		try {
		//파라미터값들로 받은 데이터가 담긴 "voteInsertInfoVo"를 쪼갭니다.
		//1.투표 주제 추가에 필요한 Dto
		//2.투표 선택지(들) 추가에 필요한 VO
			
			
			//1. 투표 주제 추가에 필요한 Dto
			VoteTopicDto voteTopicDto = VoteTopicDto.builder()
												.boardNo(boardNo)
												.voteTopicTitle(voteInsertInfoVo.getVoteTopicTitle())
												//.voteTopicExpire(voteTopicExpire)
												.build();
												
			//투표 주제를 추가하는 기능에 활용
			voteDao.insertTopic(voteTopicDto);
			
		
			//투표 선택지(들) 추가에 필요한 VO 생성 (반복 추가) 
			int seqCurrVal = voteDao.getSeqCurrVal(); //이건 제가 필요해서 넣은 것 아마 해시태그에서는 현재 board_seq_currVal이 아닐까 싶어요
	
			VoteInsertInfoVo voteInsertOptionInfo = VoteInsertInfoVo.builder()
															.boardNo(boardNo)//종속된 board_no(게시글 번호)
															.voteTopicNo(seqCurrVal)//종속된 vote_topic_no
															.voteTopicOption(voteInsertInfoVo.getVoteTopicOption()) //List<String> 형태
															.build();
		
			//투표 선택지(들)를 추가하는 기능에 활용
			voteDao.insertOption(voteInsertOptionInfo);
				
			
			return "board/NICE"; //성공페이지 만들지 않음
			
		} catch (Exception e) {
			return "board/voteERORRvoteERORRvoteERORRvoteERORRvoteERORRvoteERORR"; //어찌되었던 실패라는 것이 눈에 확보이게 임의 설정한 페이지
		}
		

	}

}
