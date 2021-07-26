package com.kh.khblind.board.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.khblind.board.entity.BoardLikeDto;

@Repository
public class BoardLikeDaoImpl implements BoardLikeDao {

	@Autowired
	private SqlSession sqlSession;
	@Override
	public boolean boardLikeExist(BoardLikeDto boardLikeDto) {
		BoardLikeDto boardLikeExistDto  = sqlSession.selectOne("boardLike.search", boardLikeDto);
		System.out.println("boardLikeExistDto = " + boardLikeExistDto);
		if(boardLikeExistDto == null) {
			return true;
		}
		else return false;
		 
	}
	@Override
	public void boardLike(BoardLikeDto boardLikeDto) {
				sqlSession.insert("boardLike.insert",boardLikeDto);
	}
	@Override
	public void boardUnlike(BoardLikeDto boardLikeDto) {
		sqlSession.delete("boardLike.delete",boardLikeDto);
	}
}
