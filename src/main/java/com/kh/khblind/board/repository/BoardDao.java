package com.kh.khblind.board.repository;

import java.util.List;

import com.kh.khblind.board.entity.BoardDto;
import com.kh.khblind.board.entity.BoardMemberVO;
import com.kh.khblind.board.entity.BoardSearchListVO;
import com.kh.khblind.board.entity.BoardWriteVO;
import com.kh.khblind.board.entity.HashtagLinkDto;

public interface BoardDao {
	//시퀀스 번호를 생성하는 기능
	int getSequence();
	//게시글을 등록하는 기능
	void insert(BoardDto boardDto);
	//게시글 상세보기 기능
	BoardDto getBoardDetail(int boardNo);
	//회원 닉네임 가져오는 기능
	BoardMemberVO find(int memberNo);
	//게시글 수정 기능
	boolean edit(BoardDto boardDto);
	//게시글 삭제 기능
	boolean delete(int boardNo);
	
	//해시태그 기능
	List<String> getHash(BoardWriteVO boardWriteVO);
	int insertHash(String hashtagName);
	List<Integer> getHashNum(List<String> hashtag);
	int searchHashNum(String hashTag);
	void insertHashlink(List<HashtagLinkDto> hashtagLinklist);
	String searchHash(String searchWord);
	List<BoardSearchListVO> hashTagSearch(String searchWord);
	int getHashSequence();

}
