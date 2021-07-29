package com.kh.khblind.board.repository;

import java.util.List;

import com.kh.khblind.board.entity.BoardCategoryBoardDto;
import com.kh.khblind.board.entity.BoardCategoryGroupDto;
import com.kh.khblind.board.entity.BoardCountDto;
import com.kh.khblind.board.entity.BoardDto;
import com.kh.khblind.board.entity.BoardMemberVO;
import com.kh.khblind.board.entity.BoardSearchListVO;
import com.kh.khblind.board.entity.BoardWriteVO;
import com.kh.khblind.board.entity.CheckBoardTypeDto;
import com.kh.khblind.board.entity.CommentsVO;
import com.kh.khblind.board.entity.CompanyBoardDto;
import com.kh.khblind.board.entity.CompanyGroupDto;
import com.kh.khblind.board.entity.HashtagLinkDto;
import com.kh.khblind.board.entity.JobCategoryBoardDto;
import com.kh.khblind.board.entity.JobCategoryGroupDto;

public interface BoardDao {
	//시퀀스 번호를 생성하는 기능
	int getSequence();
	//게시글을 등록하는 기능
	void insert(BoardDto boardDto);
	void boardCategoryInsert(BoardCategoryGroupDto baordCategoryGroupDto);
	void jobCategoryInsert(JobCategoryGroupDto jobCategoryGroupDto);
	void companyInsert(CompanyGroupDto companyGroupDto);
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
	List<String> getHash(String boardContent);//오버로딩 
	int insertHash(String hashtagName);
	List<Integer> getHashNum(List<String> hashtag);
	int searchHashNum(String hashTag);
	void insertHashlink(List<HashtagLinkDto> hashtagLinklist);
	String searchHash(String searchWord);
	List<BoardSearchListVO> hashTagSearch(String searchWord);
	int getHashSequence();
	
	//기업별 목록조회 기능
	List<CompanyBoardDto> getCompanyBoardList(int companyNo);
	//업종별 목록조회 기능
	List<JobCategoryBoardDto> getJobCategoryBoardList(int jobCategoryNo);
	//토픽별 목록조회 기능
	List<BoardCategoryBoardDto> getBoardCategoryBoardList(Integer boardCategoryNo);
	
	//기업 이름 조회 기능
	String getCompanyName(int companyNo);
	//업종 이름 조회 기능
	String getJobCategoryName(int jobCategoryNo);
	//토픽 이름 조회 기능
	String getBoardCategoryName(int boardCategoryNo);
	
	//주제 종료 조회 기능1
	CheckBoardTypeDto getBoardType(int boardNo);
	
	//메인 검색 기능(토픽 검색 기능)
	List<BoardCategoryBoardDto> BoardCategorySearch(String keyword);
	//기업목록 검색기능
	List<CompanyBoardDto> SearchCompanyBoardList(String keyword);
	//업종목록 검색기능
	List<JobCategoryBoardDto> SearchJobCategoryBoardList(String keyword);
	
	//게시판 집계함수만 가져오는 기능
	BoardCountDto getBoardCountInfo(int boardNo);
	
	//특정 게시판에 달린 댓글 들을 불러오는 기능
	List<CommentsVO> getCommentsList(int boardNo);
	
	//조회수 증가 기능
	void addViewCount(int boardNo);
	
	//
}
