package com.kh.khblind.board.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.khblind.board.entity.BoardDto;
import com.kh.khblind.board.entity.BoardMemberVO;

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

	@Override
	public BoardDto getBoardDetail(int boardNo) {
		
		BoardDto boardDto = sqlSession.selectOne("board.getBoardDetail", boardNo);
		System.out.println(boardDto);
		
		return boardDto;
		
		
	}

	@Override
	public BoardMemberVO find(int boardNo) {
		
		BoardMemberVO boardMemberVO = sqlSession.selectOne("board.find", boardNo);
	
		return boardMemberVO;
	}

	@Override
	public boolean edit(BoardDto boardDto) {
		int count = sqlSession.update("board.edit", boardDto); 
		return count > 0;
	}

	@Override
	public boolean delete(int boardNo) {
		int count = sqlSession.delete("board.delete", boardNo);
		return count > 0;
	}
	

}
