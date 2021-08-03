package com.kh.khblind.board.repository;

import java.util.List;

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
import com.kh.khblind.board.entity.HashtagLinkDto;
import com.kh.khblind.board.entity.JobCategoryBoardDto;
import com.kh.khblind.board.entity.JobCategoryGroupDto;
import com.kh.khblind.board.entity.JobCategoryInfoDto;
import com.kh.khblind.board.entity.MainCategoryDataVO;
import com.kh.khblind.board.entity.MetamonBoardListVO;
import com.kh.khblind.board.entity.StartEndVoForAjax;
import com.kh.khblind.company.entity.JobCategoryDto;

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
	void deleteHash(int boardNo);
	
	//ajax 목록 기능
	List<MetamonBoardListVO> ajaxCompanyBoardList(StartEndVoForAjax startEndVoForAjax);
	
	List<MetamonBoardListVO> ajaxJobCategoryBoardList(StartEndVoForAjax startEndVoForAjax);
	
	List<MetamonBoardListVO> ajaxBoardCategoryBoardList(StartEndVoForAjax startEndVoForAjax);
	
	//ajax 검색 기능
	List<MetamonBoardListVO> ajaxSearchCompanyBoardList(String keyword);
	
	List<MetamonBoardListVO> ajaxSearchJobCategoryBoardList(String keyword);
	
	List<MetamonBoardListVO> ajaxSearchBoardCategoryBoardList(String keyword);
	
	//조회수 많은 토픽 DTO 가져오기 기능
	BoardCategoryAllCountDto getBoardCategoryByAllCount(int rn);
	//조회수 많은 토픽 갯수 가져오기 기능
	List<BoardCategoryAllCountDto> boardCategoryAllCountSize();
	//토픽 조회수 베스트 6개 목록 기능
	List<MainCategoryDataVO> mainBoardCegoryList(int boardCategoryNo);
	
	//토픽 좋아요 순 베스트 목록 기능
	List<BoardCategoryListByLikeCountVO> getBoardCategoryListByLikeCount();
	
	//기업리뷰페이지 기업키워드 목록기능
	List<BoardCategoryBoardDto> getCompanyKeywordList(String keyword);
	List<BoardCategoryVO> myWrite(int memberNo);
	
	//플러스 회원 전용 업종번호들 가져오기 기능
	List<JobCategoryDto> getPlusJobCategoryInfo(); 
	
}
