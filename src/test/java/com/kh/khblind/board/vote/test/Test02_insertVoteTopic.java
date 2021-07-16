package com.kh.khblind.board.vote.test;

import java.text.SimpleDateFormat;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.khblind.board.vote.entity.VoteTopicDto;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })
@WebAppConfiguration
public class Test02_insertVoteTopic {

	@Autowired
	private SqlSession sqlSession;
	
	@Test
	public void test1() {
			
		
		VoteTopicDto voteTopicDto = VoteTopicDto.builder()
													.boardNo(2)
													.voteTopicTitle("좋아하는 색깔은?")
													.build();
		
//		System.out.println("@@@@@@@@@@@@"+voteTopicDto);
		
		sqlSession.insert("vote.insertTopic", voteTopicDto);
		
	}
	
}
