package com.kh.khblind.board.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.khblind.board.entity.BoardLikeDto;
import com.kh.khblind.board.entity.BookmarkDto;

@Repository
public class BookmarkDaoImpl implements BookmarkDao {

	@Autowired
	private SqlSession sqlSession;
	
	public void BookmarkInsert(BookmarkDto bookmarkDto) {
		sqlSession.insert("bookmark.insert",bookmarkDto);
	}
	public void BookmarkDelete(BookmarkDto bookmarkDto) {
		sqlSession.delete("bookmark.delete",bookmarkDto);
	}
//	public boolean bookmarkExist(BookmarkDto bookmarkDto) {
//		return sqlSession.selectOne("bookmark.search",bookmarkDto);
//	}
	public boolean bookmarkExist(BookmarkDto bookmarkDto) {
		BookmarkDto bookmarkExistDto  = sqlSession.selectOne("bookmark.search", bookmarkDto);
		if(bookmarkExistDto == null) {
			return true;
		}
		else return false;
		 
	}
}

