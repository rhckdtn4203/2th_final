package com.kh.khblind.board.vote.repository;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.ModelAttribute;

import com.kh.khblind.board.vote.entity.VoteInsertInfoVo;
import com.kh.khblind.board.vote.entity.VoteOptionDto;
import com.kh.khblind.board.vote.entity.VoteOptionInfoVo;
import com.kh.khblind.board.vote.entity.VoteResultDto;
import com.kh.khblind.board.vote.entity.VoteTopicDto;
import com.kh.khblind.board.vote.entity.VoteViewInfoVo;


public interface VoteDao {
		//1. 해당게시글에 투표가 있는지 없는지 보여주기
		boolean isExist(int boardNo); 
		//2. 투표주제입력
		boolean insertTopic(VoteTopicDto voteTopicDto);
		//3. 
		int getSeqCurrVal();
		//4. 투표선택지입력
		boolean insertOption(VoteInsertInfoVo voteInsertOptionInfo);
		//5. 투표 토픽 정보불러오기
		VoteTopicDto getVoteTopicInfo(int boardNo);
		//6. 투표 선택지 정보불러오기		
		List<VoteOptionInfoVo> getVoteOptionInfo(int boardNo);
		//7. 투표하기(ajax이므로 다시 투표정보를 불러와야한다.)
		boolean voting(VoteResultDto voteResultDto);
		//8. 총투표개수 가져오기
		int getAllCount(int boardNo);
		//9.투표했는지 확인하기
		boolean didYouVote(VoteResultDto voteResultDto);
		//10. 회원번호와 투표주제번호로 투표선택지 번호 가져오기
		int getSelectedOptionNoThatTopic (VoteResultDto voteResultDto);
		
		
		//11. 실시간 투표 때 쓸 카운트만 구하는 거
		int getSingleVoteOptionCount(int voteOptionNo);
		
		//12. 투표주제번호로 게시판번호 가져오기
		int getboardNo(int voteTopicNo);
	
}
