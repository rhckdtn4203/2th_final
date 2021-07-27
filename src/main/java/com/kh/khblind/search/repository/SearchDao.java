package com.kh.khblind.search.repository;

import java.util.List;

import com.kh.khblind.board.entity.BoardDto;
import com.kh.khblind.pay.entity.PayDto;
import com.kh.khblind.search.entity.SearchDto;

public interface SearchDao {
	
	int getSequence();
	void insert(SearchDto searchDto);
	void update(String keyword);
	List<SearchDto> list();
	SearchDto get(String keyword);
}
