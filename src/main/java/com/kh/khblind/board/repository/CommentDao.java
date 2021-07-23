package com.kh.khblind.board.repository;

import com.kh.khblind.board.entity.CommentsVO;

public interface CommentDao {
	void commentInsert(CommentsVO commentsVO);
	void nestedCommentInsert(CommentsVO commentsVO);
}
