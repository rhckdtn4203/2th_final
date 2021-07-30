package com.kh.khblind.search.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.khblind.board.entity.BoardDto;
import com.kh.khblind.search.entity.SearchDto;

@Repository
public class SearchDaoImpl implements SearchDao {

	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int getSequence() {
		return sqlSession.selectOne("search.sequence");
	}

	@Override
	public void insert(SearchDto searchDto) {
		sqlSession.insert("search.insert",searchDto);
		
	}

	@Override
	public void update(String keyword) {
		sqlSession.insert("search.update",keyword);
		
	}

	@Override
	public SearchDto get(String keyword) {
		return sqlSession.selectOne("search.get",keyword);
	}

	@Override
	public List<SearchDto> list() {
		return sqlSession.selectList("search.keywordList");
	}

	
	
}
