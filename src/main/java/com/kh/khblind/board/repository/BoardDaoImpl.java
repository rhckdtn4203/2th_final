package com.kh.khblind.board.repository;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.khblind.board.entity.BoardDto;
import com.kh.khblind.board.entity.BoardMemberVO;
import com.kh.khblind.board.entity.BoardSearchListVO;
import com.kh.khblind.board.entity.BoardWriteVO;
import com.kh.khblind.board.entity.HashtagDto;
import com.kh.khblind.board.entity.HashtagLinkDto;

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
	public BoardDto getBoardDetail(int boardNo) {
		
		BoardDto boardDto = sqlSession.selectOne("board.getBoardDetail", boardNo);
		System.out.println(boardDto);
		
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

	@Override
	public int getHashSequence() {
		
		return sqlSession.selectOne("hashtag.get");}
	@Override
	   public List<String> getHash(BoardWriteVO boardWriteVO){
	      
	      String boardContent = boardWriteVO.getBoardContent();      
	         String HashRegex = "([#][a-zA-Z가-힣0-9]{1,})"; //정규표현식
	         
	         List<String> HashtagInBoardContentList = new ArrayList<>();
	         
	         Pattern p = Pattern.compile(HashRegex);
	         Matcher m = p.matcher(boardContent);
	         
	         while (m.find()) {
	           String hashtag = m.group(1);
	           HashtagInBoardContentList.add(hashtag);
	         }

	         return HashtagInBoardContentList;
	   }

	   //해시태그 검색인지 일반검색인지를 구분하기위한 메소드
	   @Override
	   public String searchHash(String searchWord){
	      
	         String HashRegex = "([#][a-zA-Z가-힣0-9]{1,})"; //정규표현식
	         
//	         List<String> HashtagInBoardContentList = new ArrayList<>();
	         Pattern p = Pattern.compile(HashRegex);
	         Matcher m = p.matcher(searchWord);
	         String hashtag = null;
	         if(m.find()) {
	           hashtag = m.group(1);
	           System.out.println("59 hashtag = " + hashtag);
	          
	         }
	         System.out.println("62 hashtag = " + hashtag);
	         return hashtag;
	   }
	//검색어에 해시태그가 있다면 해시태그로 검색하는 검색메소드
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
	   
	}
