package com.kh.khblind.board.repository;

import java.util.List;

import com.kh.khblind.board.entity.BookmarkDto;
import com.kh.khblind.board.entity.BookmarkVO;

public interface BookmarkDao {
	void BookmarkInsert(BookmarkDto bookmarkDto);
	void BookmarkDelete(BookmarkDto bookmarkDto);
	boolean bookmarkExist(BookmarkDto bookmarkDto);
	List<BookmarkVO> MyBookmark(int memberNo);
}
