package com.kh.khblind.board.repository;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.khblind.board.entity.BoardCategoryAllCountDto;
import com.kh.khblind.board.entity.BoardCategoryBoardDto;
import com.kh.khblind.board.entity.BoardCategoryGroupDto;
import com.kh.khblind.board.entity.BoardCategoryListByLikeCountVO;
import com.kh.khblind.board.entity.BoardCategoryVO;
import com.kh.khblind.board.entity.BoardCountDto;
import com.kh.khblind.board.entity.BoardDto;
import com.kh.khblind.board.entity.BoardMemberVO;
import com.kh.khblind.board.entity.BoardSearchListVO;
import com.kh.khblind.board.entity.BoardWriteVO;
import com.kh.khblind.board.entity.CheckBoardTypeDto;
import com.kh.khblind.board.entity.CommentsVO;
import com.kh.khblind.board.entity.CompanyBoardDto;
import com.kh.khblind.board.entity.CompanyGroupDto;
import com.kh.khblind.board.entity.HashtagDto;
import com.kh.khblind.board.entity.HashtagLinkDto;
import com.kh.khblind.board.entity.JobCategoryBoardDto;
import com.kh.khblind.board.entity.JobCategoryGroupDto;
import com.kh.khblind.board.entity.JobCategoryInfoDto;
import com.kh.khblind.board.entity.MainCategoryDataVO;
import com.kh.khblind.board.entity.MetamonBoardListVO;
import com.kh.khblind.board.entity.StartEndVoForAjax;

import com.kh.khblind.company.entity.JobCategoryDto;
import com.kh.khblind.member.entity.MemberDto;

@Repository
public class BoardDaoImpl implements BoardDao {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public int getSequence() {
		
		return sqlSession.selectOne("board.getSequence");
	}

	@Override
	public void insert(BoardDto boardDto) {
		sqlSession.insert("board.insert", boardDto);
		
	}
	
	@Override
	public void boardCategoryInsert(BoardCategoryGroupDto baordCategoryGroupDto) {
		sqlSession.insert("board.boardCategoryInsert", baordCategoryGroupDto);
		
	}
	
	@Override
	public void jobCategoryInsert(JobCategoryGroupDto jobCategoryGroupDto) {
		sqlSession.insert("board.jobCategoryInsert", jobCategoryGroupDto);
		
	}
	
	@Override
	public void companyInsert(CompanyGroupDto companyGroupDto) {
		sqlSession.insert("board.companyInsert", companyGroupDto);
		
	}

	@Override
	public BoardDto getBoardDetail(int boardNo) {
		
		BoardDto boardDto = sqlSession.selectOne("board.getBoardDetail", boardNo);
		
		return boardDto;
		
		
	}

	@Override
	public BoardMemberVO find(int boardNo) {
		
		BoardMemberVO boardMemberVO = sqlSession.selectOne("board.find", boardNo);
	
		return boardMemberVO;
	}

	@Override
	public boolean edit(BoardDto boardDto) {
		int count = sqlSession.update("board.edit", boardDto); 
		return count > 0;
	}

	@Override
	public boolean delete(int boardNo) {
		int count = sqlSession.delete("board.delete", boardNo);
		return count > 0;
	}
//1
	@Override
	public int getHashSequence() {
		
		return sqlSession.selectOne("hashtag.get");}
	
	@Override
	   public List<String> getHash(BoardWriteVO boardWriteVO){
	      
	      String boardContent = boardWriteVO.getBoardContent();      
	         String HashRegex = "([#][a-zA-Z???-???0-9]{1,})"; //???????????????
	         
	         List<String> HashtagInBoardContentList = new ArrayList<>();
	         
	         Pattern p = Pattern.compile(HashRegex);
	         Matcher m = p.matcher(boardContent);
	         
	         while (m.find()) {
	           String hashtag = m.group(1);
	           HashtagInBoardContentList.add(hashtag);
	         }

	         return HashtagInBoardContentList;
	   }

		@Override
		public List<String> getHash(String boardContent) {
			
			String HashRegex = "([#][a-zA-Z???-???0-9]{1,})"; //???????????????
	         
	         List<String> HashtagInBoardContentList = new ArrayList<>();
	         
	         Pattern p = Pattern.compile(HashRegex);
	         Matcher m = p.matcher(boardContent);
	         
	         while (m.find()) {
	           String hashtag = m.group(1);
	           HashtagInBoardContentList.add(hashtag);
	         }

	         return HashtagInBoardContentList;

		}


	   //???????????? ???????????? ????????????????????? ?????????????????? ?????????
	   @Override
	   public String searchHash(String searchWord){
	      
	         String HashRegex = "([#][a-zA-Z???-???0-9]{1,})"; //???????????????
	         
	         Pattern p = Pattern.compile(HashRegex);
	         Matcher m = p.matcher(searchWord);
	         String hashtag = null;
	         if(m.find()) {
	           hashtag = m.group(1);
	          
	         }
	         return hashtag;
	   }
	//???????????? ??????????????? ????????? ??????????????? ???????????? ???????????????
	   public List<BoardSearchListVO> hashTagSearch(String searchWord) {
	    List<BoardSearchListVO> boardSearchList =sqlSession.selectList("hashtag.hashTagSearch",searchWord);
	   return boardSearchList;
	      
	   }
	   
	   
	   
	   
	   
	   @Override
	   public int searchHashNum(String hashTag){      
	      HashtagDto hashtagDto =sqlSession.selectOne("hashtag.searchHash",hashTag);
	            
	      if(hashtagDto == null) {
	         return insertHash(hashTag);
	      }         
	      else {
	         return hashtagDto.getHashtagNo();
	      }
	                
	   }
	   
	   @Override
	   public int insertHash(String hashtagName){      
	      sqlSession.insert("hashtag.insertHash",hashtagName);
	      int seq = sqlSession.selectOne("hashtag.getSequence");
	      
	      return seq;
	   }
	   
	   @Override
	   public List<Integer> getHashNum(List<String> hashtagList) {
	      List<Integer> hashNumList = new ArrayList<Integer>();
	      
	      for(String hashtagName : hashtagList) {
	         hashNumList.add(searchHashNum(hashtagName));
	      }
	      
	      return hashNumList;
	   }
	   @Override
	   public void insertHashlink(List<HashtagLinkDto> hashtagLinklist) {
	      for(int i=0; i<hashtagLinklist.size(); i++) {
	         sqlSession.insert("hashtag.hashtaglinkinsert",hashtagLinklist.get(i));
	      }
	      
	      
	   }

		@Override
		public List<CompanyBoardDto> getCompanyBoardList(int companyNo) {
			List<CompanyBoardDto> companyBoardList = sqlSession.selectList("board.getCompanyBoardList", companyNo);
			return companyBoardList;
		}

		@Override
		public List<JobCategoryBoardDto> getJobCategoryBoardList(int jobCategoryNo) {
			List<JobCategoryBoardDto> jobCategoryBoardList = sqlSession.selectList("board.getJobCategoryBoardList", jobCategoryNo);
			return jobCategoryBoardList;
		}
		
		@Override
		public List<BoardCategoryBoardDto> getBoardCategoryBoardList(Integer boardCategoryNo) {
			List<BoardCategoryBoardDto> boardCategoryBoardList = sqlSession.selectList("board.getBoardCategoryBoardList", boardCategoryNo);
			return boardCategoryBoardList;
		}
		
		@Override
		public List<BoardCategoryBoardDto> BoardCategorySearch(String keyword) {
			List<BoardCategoryBoardDto> boardCategoryboardList = sqlSession.selectList("board.SearchBoardCategoryBoardList", keyword);
			return boardCategoryboardList;
		}
		
		@Override
		public List<CompanyBoardDto> SearchCompanyBoardList(String keyword) {
			List<CompanyBoardDto> companyBoardList = sqlSession.selectList("board.SearchCompanyBoardList", keyword);
			
			return companyBoardList;
		}
		
		@Override
		public List<JobCategoryBoardDto> SearchJobCategoryBoardList(String keyword) {
			List<JobCategoryBoardDto> jobCategoryboardList = sqlSession.selectList("board.SearchJobCategoryBoardList", keyword);
			return jobCategoryboardList;
		}

		
		@Override
		public String getCompanyName(int companyNo) {
			 
			String companyName = sqlSession.selectOne("board.getCompanyName", companyNo);
			return companyName;
		}

		@Override
		public String getJobCategoryName(int jobCategoryNo) {
			
			String jobCategoryName = sqlSession.selectOne("board.getJobCategoryName", jobCategoryNo);
			return jobCategoryName;
		}

		@Override
		public String getBoardCategoryName(int boardCategoryNo) {
			String boardCategoryName = sqlSession.selectOne("getBoardCategoryName", boardCategoryNo);
			return boardCategoryName;
		}
		
		@Override
		public CheckBoardTypeDto getBoardType(int boardNo) {
			
			CheckBoardTypeDto boardTypeDto = sqlSession.selectOne("board.getBoardType", boardNo);
			return boardTypeDto;
		}

		@Override
		public BoardCountDto getBoardCountInfo(int boardNo) {
			BoardCountDto boardCountDto = sqlSession.selectOne("board.getCountInfo", boardNo);
			return boardCountDto;
		}

		@Override
		public List<CommentsVO> getCommentsList(int boardNo) {
			List<CommentsVO> commentsList = sqlSession.selectList("comments.list", boardNo);
			return commentsList;
		}

		@Override
		public void addViewCount(int boardNo) {
			sqlSession.update("board.addCount",boardNo);
		}

		@Override
		public void deleteHash(int boardNo) {
			sqlSession.delete("hashtag.deleteHash", boardNo);			
		}
		

		@Override
	      public List<BoardCategoryVO> myWrite(int memberNo) {
	         List<BoardCategoryVO> boardList = sqlSession.selectList("board.myWrite",memberNo);
	         return boardList;
	      }


		@Override
		public List<MetamonBoardListVO> ajaxCompanyBoardList(StartEndVoForAjax startEndVoForAjax) {
			List<MetamonBoardListVO> companyBoardList = sqlSession.selectList("board.getCompanyBoardList", startEndVoForAjax);
			return companyBoardList;
		}


		@Override
		public List<MetamonBoardListVO> ajaxJobCategoryBoardList(StartEndVoForAjax startEndVoForAjax) {
			List<MetamonBoardListVO> jobCategoryBoardList = sqlSession.selectList("board.getJobCategoryBoardList", startEndVoForAjax);
			
			return jobCategoryBoardList;
		}

		@Override
		public List<MetamonBoardListVO> ajaxBoardCategoryBoardList(StartEndVoForAjax startEndVoForAjax) {
			List<MetamonBoardListVO> boardCategoryBoardList = sqlSession.selectList("board.getBoardCategoryBoardList", startEndVoForAjax);
			
			return boardCategoryBoardList;
		}

		@Override
		public List<MetamonBoardListVO> ajaxSearchCompanyBoardList(String keyword) {
			List<MetamonBoardListVO> companyBoardList = sqlSession.selectList("board.SearchCompanyBoardList", keyword);
			return companyBoardList;
		}

		@Override
		public List<MetamonBoardListVO> ajaxSearchJobCategoryBoardList(String keyword) {
			List<MetamonBoardListVO> jobCategoryboardList = sqlSession.selectList("board.SearchJobCategoryBoardList", keyword);
			return jobCategoryboardList;
		}

		@Override
		public List<MetamonBoardListVO> ajaxSearchBoardCategoryBoardList(String keyword) {
			List<MetamonBoardListVO> boardCategoryboardList = sqlSession.selectList("board.SearchBoardCategoryBoardList", keyword);
			return boardCategoryboardList;
		}

		@Override
		public BoardCategoryAllCountDto getBoardCategoryByAllCount(int rn) {
			BoardCategoryAllCountDto boardCategoryAllCountDto = sqlSession.selectOne("board.boardCategoryAllCount", rn);
			return boardCategoryAllCountDto;
		}

		@Override
		public List<MainCategoryDataVO> mainBoardCegoryList(int boardCategoryNo) {
			List<MainCategoryDataVO> mainBoardCategoryList = sqlSession.selectList("board.mainCategoryData", boardCategoryNo);
			return mainBoardCategoryList;
		}

		@Override
		public List<BoardCategoryListByLikeCountVO> getBoardCategoryListByLikeCount() {
			List<BoardCategoryListByLikeCountVO> boardCategoryListByLikeCount = sqlSession.selectList("board.BoardCategoryListByLikeCount");
			return boardCategoryListByLikeCount;
		}

		@Override
		public List<BoardCategoryBoardDto> getCompanyKeywordList(String keyword) {
			List<BoardCategoryBoardDto> getCompanyKeywordList = sqlSession.selectList("board.getCompanyKeywordList", keyword);
			return getCompanyKeywordList;
		}

		@Override
		public List<BoardCategoryAllCountDto> boardCategoryAllCountSize() {
			List<BoardCategoryAllCountDto> boardCategoryAllCountSizeList = sqlSession.selectList("board.boardCategoryAllCountSize");
			return boardCategoryAllCountSizeList;
		}

		@Override
		public List<JobCategoryDto> getPlusJobCategoryInfo() {
			List<JobCategoryDto> getPlusJobCategoryInfoList = sqlSession.selectList("board.getPlusJobCategoryInfo");
			return getPlusJobCategoryInfoList;
		}


	}
