package com.kh.khblind.board.vote.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.khblind.board.vote.entity.VoteOptionDto;
import com.kh.khblind.board.vote.entity.VoteResultDto;
import com.kh.khblind.board.vote.entity.VoteTopicDto;
import com.kh.khblind.board.vote.entity.VoteViewVo;

@Repository
public class VoteDaoImpl implements VoteDao {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public boolean isExist(int boardNo) { //나중에 Dto반환케 하여 한번에 할 수도 있음
		VoteTopicDto isExistInDB = new VoteTopicDto();
		
		try {
			isExistInDB = sqlSession.selectOne("vote.isExistInDB", boardNo);
			
			if(isExistInDB != null) {
				return true;
			}
			else {
				return false;
			}
		} catch (NullPointerException e) {
			return false;
		}

	}

	@Override
	public boolean insertTopic(VoteTopicDto voteTopicDto) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean insertOption(VoteOptionDto voteOptionDto) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public VoteViewVo getVoteFullInfo(int boardNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean voting(VoteResultDto voteResultDto) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public VoteResultDto getVotePartInfo() {
		// TODO Auto-generated method stub
		return null;
	}
	
}
