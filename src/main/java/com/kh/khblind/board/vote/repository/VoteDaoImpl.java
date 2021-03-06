package com.kh.khblind.board.vote.repository;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.khblind.board.vote.entity.VoteInsertInfoVo;
import com.kh.khblind.board.vote.entity.VoteOptionDto;
import com.kh.khblind.board.vote.entity.VoteOptionInfoVo;
import com.kh.khblind.board.vote.entity.VoteResultDto;
import com.kh.khblind.board.vote.entity.VoteTopicDto;
import com.kh.khblind.board.vote.entity.VoteViewInfoVo;
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
			e.printStackTrace();
			return false;
		}

	}

	@Override
	public boolean insertTopic(VoteTopicDto voteTopicDto) {
		try {
			sqlSession.insert("vote.insertTopic", voteTopicDto);
			
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public boolean insertOption(VoteInsertInfoVo voteInsertInfoVo) {
		
		try {
					
			//옵션 이름들 나열된 List만 가져옵니다. (아래 반복문에서 활용할 예정)
			List<String> optionNameList = voteInsertInfoVo.getVoteTopicOption();
							
			//DB에 넣을 옵션이름들만 따로 뺍니다. - 사실 이 부분은 효율적인지는 모르겠습니다
			List<VoteOptionDto> optionInfoToDB = new ArrayList<>();
							
			for(int i = 0; i<voteInsertInfoVo.getVoteTopicOption().size(); i++) {
						
				VoteOptionDto option = VoteOptionDto.builder()
				.voteTopicNo(voteInsertInfoVo.getVoteTopicNo())//종속된 투표 주제 번호
				.voteOptionName(optionNameList.get(i))//voteInsertInfoVo.getVoteTopicOption().get(i)와 같긴하지만 너무 길어서 위에 변수로 만들었습니다
				.build();
							
			optionInfoToDB.add(option); //하나씩 집어 넣습니다.
			}
		
		
			//옵션 개수에 따라 반복횟수가 달라집니다.
			for(int i =0;  i<optionInfoToDB.size(); i++) {
				sqlSession.insert("vote.insertOption", optionInfoToDB.get(i));
			}
				return true;
			} catch (Exception e) {
				e.printStackTrace();
				return false;
			}
		}

	@Override
	public int getSeqCurrVal() {
		try {
			int seqCurrVal= sqlSession.selectOne("vote.getSeqCurrVal");
			return seqCurrVal;
			
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}

	}

	@Override
	public VoteTopicDto getVoteTopicInfo(int boardNo) {
		
		VoteTopicDto voteTopicDto = new VoteTopicDto();
		try {
			voteTopicDto = sqlSession.selectOne("vote.getTopicInfo", boardNo);
			return voteTopicDto;
			
		} catch (Exception e) {
			e.printStackTrace();
			return voteTopicDto;
		}
		
	}

	@Override
	public List<VoteOptionInfoVo> getVoteOptionInfo(int boardNo) {
		List<VoteOptionInfoVo> voteOptionInfoVoList = new ArrayList<>();
		try {
			//퍼센트를 뺀 나머지
			voteOptionInfoVoList= sqlSession.selectList("vote.getOptionInfo", boardNo);
			
			//퍼센트는 따로 구해야한다.
			
			//일단 지가 지 기능 써서 전체 개수를 불러온다.
			int allCount = getAllCount(boardNo);
			for(int i=0; i<voteOptionInfoVoList.size(); i++) {
				int thisCount = voteOptionInfoVoList.get(i).getVoteOptionCount();
				int thisPercent = (int)((float)thisCount/(float)allCount*100)/1;
				
				voteOptionInfoVoList.get(i).setVoteOptionPercent(thisPercent);
			}
			
			return voteOptionInfoVoList;
			
		} catch (Exception e) {
			e.printStackTrace();
			return voteOptionInfoVoList;
		}

	}

	@Override
	public boolean voting(VoteResultDto voteResultDto) {
		
		try {
			sqlSession.insert("vote.voting", voteResultDto);
			
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		
	}

	@Override
	public int getAllCount(int boardNo) {
		
		try {
			int allCount = sqlSession.selectOne("vote.getAllCount", boardNo);
			return allCount;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public boolean didYouVote(VoteResultDto voteResultDto) {
		try {
			
			int didYouVote = sqlSession.selectOne("vote.didYouVote", voteResultDto);
			
			if(didYouVote!=0) {//투표를했다.
				return true;
			}else {
				return false;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			return true;
		}
	}

	@Override
	public int getSelectedOptionNoThatTopic(VoteResultDto voteResultDto) {
		
		try {
				
			int seletedOptionNo = sqlSession.selectOne("vote.getSelectedOptionNoThatTopic", voteResultDto);
			return seletedOptionNo;
			
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}

	@Override
	public int getSingleVoteOptionCount(int voteOptionNo) {
		try {
			int voteOptionCount = sqlSession.selectOne("vote.getSingleVoteOptionCount", voteOptionNo);
			
			return voteOptionCount;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}	
	}

	@Override
	public int getboardNo(int voteTopicNo) {
		try {
			int boardNo = sqlSession.selectOne("vote.getBoardNo", voteTopicNo);
			return boardNo;
		}
		catch (Exception e){
			e.printStackTrace();
			return 0;
		}
		
	}


}
