package com.kh.khblind.board.vote.test;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.khblind.board.vote.entity.VoteOptionDto;
import com.kh.khblind.board.vote.entity.VoteTopicDto;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })
@WebAppConfiguration
public class Test03_insertVoteOption {

	@Autowired
	private SqlSession sqlSession;
	
	@Test
	public void test1() {
		int topicNo = 8; 
		
		List<VoteOptionDto> optionList = new ArrayList<>();
		
		VoteOptionDto optionA = VoteOptionDto.builder()
									.voteTopicNo(topicNo)
									.voteOptionName("빨강")
									.build();
		
		VoteOptionDto optionB = VoteOptionDto.builder()
									.voteTopicNo(topicNo)
									.voteOptionName("노랑")
									.build();
		
		VoteOptionDto optionC = VoteOptionDto.builder()
									.voteTopicNo(topicNo)
									.voteOptionName("초록")
									.build();
		
		optionList.add(optionA);
		optionList.add(optionB);
		optionList.add(optionC);
		
		System.out.println("@@@@@@@@@@@@"+ optionList);
			
		for(int i =0;  i< optionList.size(); i++) {
			sqlSession.insert("vote.insertOption", optionList.get(i));
		}
	}
	
}
