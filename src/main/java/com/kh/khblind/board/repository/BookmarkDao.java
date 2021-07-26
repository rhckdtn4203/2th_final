package com.kh.khblind.board.repository;

import com.kh.khblind.board.entity.BookmarkDto;

public interface BookmarkDao {
	void BookmarkInsert(BookmarkDto bookmarkDto);
	void BookmarkDelete(BookmarkDto bookmarkDto);
	boolean bookmarkExist(BookmarkDto bookmarkDto);
}
