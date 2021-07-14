package com.kh.khblind.board.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.khblind.board.entity.BoardDto;

@Repository
public class BoardDaoImpl implements BoardDao {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public int getSequence() {
		
		return sqlSession.selectOne("board.getSequence");
	}

	@Override
	public void insert(BoardDto boardDto) {
		sqlSession.insert("board.insert", boardDto);
		
	}

}
