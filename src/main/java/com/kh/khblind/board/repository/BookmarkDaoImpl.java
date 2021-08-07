package com.kh.khblind.board.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.khblind.board.entity.BookmarkDto;
import com.kh.khblind.board.entity.BookmarkVO;

@Repository
public class BookmarkDaoImpl implements BookmarkDao {

	@Autowired
	private SqlSession sqlSession;
	
	
	@Override
	public void BookmarkInsert(BookmarkDto bookmarkDto) {
		sqlSession.insert("bookmark.insert",bookmarkDto);
	}
	@Override
	public void BookmarkDelete(BookmarkDto bookmarkDto) {
		sqlSession.delete("bookmark.delete",bookmarkDto);
	}
	
	@Override
	public boolean bookmarkExist(BookmarkDto bookmarkDto) {
		BookmarkDto bookmarkExistDto  = sqlSession.selectOne("bookmark.search", bookmarkDto);
		if(bookmarkExistDto == null) {
			return true;
		}
		else return false;
		 
	}
	//내가 북마크한 게시글 찾는 메소드
	@Override
	public List<BookmarkVO> MyBookmark(int memberNo) {
		List<BookmarkVO> BookmarkList = sqlSession.selectList("bookmark.mybookmark",memberNo);  
		
		return BookmarkList;
	}
}