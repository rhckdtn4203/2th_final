package com.kh.khblind.board.vote.test;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.khblind.board.vote.entity.VoteResultDto;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })
@WebAppConfiguration
public class Test04_voting {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Test
	public void test01() {
		int memberNoV= 8;
		int voteTopicNoV=8;
		int voteOptionNoV=13;
		
		VoteResultDto voteResultDto =  VoteResultDto.builder()
													.memberNo(memberNoV)
													.voteTopicNo(voteTopicNoV)
													.voteOptionNo(voteOptionNoV)
													.build();
		
		
		int count = sqlSession.insert("vote.voting", voteResultDto);
		
		
	}
}
