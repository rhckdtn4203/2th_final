package com.kh.khblind.board.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.khblind.board.entity.CommentsVO;

@Repository
public class CommentDaoImpl implements CommentDao {
	
	@Autowired
	private SqlSession sqlSession; 
	@Override
	public void commentInsert(CommentsVO commentsVO) {
		sqlSession.insert("comments.insert",commentsVO);
	}
	@Override
	public void nestedCommentInsert(CommentsVO commentsVO) {
		sqlSession.insert("comments.nestedinsert",commentsVO);
		
	}

}
