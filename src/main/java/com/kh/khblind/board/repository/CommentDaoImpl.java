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
   @Override	
   public int getCommentsSequence() {
      return sqlSession.selectOne("comments.getCommentsSequence");
   }
   @Override
   public boolean edit(CommentsVO commentsVO) {
      int count = sqlSession.update("comments.edit",commentsVO);
      return count>0;
   }
   @Override
   public boolean delete(int commentsNo) {
	   System.out.println(commentsNo+ "댓글 삭제전");
      int count = sqlSession.delete("comments.delete", commentsNo);
      return count>0;
   }
}