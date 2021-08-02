package com.kh.khblind.board.vote.restcontroller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.khblind.board.vote.entity.VoteOptionInfoVo;
import com.kh.khblind.board.vote.entity.VoteResultDto;
import com.kh.khblind.board.vote.entity.VoteViewInfoVo;
import com.kh.khblind.board.vote.repository.VoteDao;
import com.kh.khblind.member.entity.MemberDto;

@RestController
@RequestMapping("/board")
public class VoteDataController {

	@Autowired
	private VoteDao voteDao;
	
	@GetMapping("/voting")
	public List<VoteOptionInfoVo> voting(VoteResultDto voteResultDto, HttpSession session) {
		
		//일단 MemberNo가져오기
		MemberDto memberDto = (MemberDto)session.getAttribute("dtoss");
		int memberNo = memberDto.getMemberNo();
		
		//투표하기 전 체크하기(
		boolean didYouVote = voteDao.didYouVote(voteResultDto);
		System.out.println("투표했나요?" + didYouVote);
		if(!didYouVote) {//투표 결과가 없으면
			//투표하기
			voteResultDto.setMemberNo(memberNo);
			System.out.println("투표합니다 | 데이터 정보  = " + voteResultDto );
			
			voteDao.voting(voteResultDto);
		}
		
		int boardNo= voteDao.getboardNo(voteResultDto.getVoteTopicNo());
		
		//최신값 반환하기(어찌되었건)
		List<VoteOptionInfoVo> voteOptionInfoVoList = voteDao.getVoteOptionInfo(boardNo);
		return voteOptionInfoVoList;
		
	}
	
	@GetMapping("getOthersVotingInfo")
	public VoteOptionInfoVo voteOptionCount (int voteOptionNo) {
		
		int voteOptionCount = voteDao.getSingleVoteOptionCount(voteOptionNo);
		
		VoteOptionInfoVo voteOptionInfoVo = VoteOptionInfoVo.builder()
																.voteOptionNo(voteOptionNo)
																.voteOptionCount(voteOptionCount)
																.build();
		return voteOptionInfoVo;
	}
	
	@GetMapping("/realtimeGetVoteTest")
	public List<VoteOptionInfoVo> realtimeGetVoteTest(VoteResultDto voteResultDto, HttpSession session) {
		
		int boardNo=voteDao.getboardNo(voteResultDto.getVoteTopicNo());
		
		//최신값 반환하기(어찌되었건)
		List<VoteOptionInfoVo> voteOptionInfoVoList = voteDao.getVoteOptionInfo(boardNo);
		return voteOptionInfoVoList;
		
	}
}
