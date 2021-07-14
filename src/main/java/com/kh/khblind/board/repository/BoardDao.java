package com.kh.khblind.board.repository;

import com.kh.khblind.board.entity.BoardDto;

public interface BoardDao {
	//시퀀스 번호를 생성하는 기능
	int getSequence();
	//게시글을 등록하는 기능
	void insert(BoardDto boardDto);

}
