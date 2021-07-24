package com.kh.khblind.board.repository;

import com.kh.khblind.board.entity.BoardLikeDto;

public interface BoardLikeDao {
	boolean boardLikeExist(BoardLikeDto boardLikeDto);
	void boardLike(BoardLikeDto boardLikeDto);
	void boardUnlike(BoardLikeDto boardLikeDto);
}
