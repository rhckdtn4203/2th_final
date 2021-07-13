package com.kh.blind.board.vote.test;

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
public class Test01_isExistInDB {

	@Autowired
	private SqlSession sqlSession;

	@Test
	public void Test1() {

		VoteTopicDto isExistInDB = new VoteTopicDto();
		int boardNo = 1;
		try {
			isExistInDB = sqlSession.selectOne("vote.isExistInDB", boardNo);
			
			if(isExistInDB != null) {
				System.out.println("있다 " + isExistInDB);
			}
			else {
				System.out.println("없다 " + isExistInDB);
			}
		} catch (NullPointerException e) {
			System.out.println("없다" + isExistInDB);
		}

	}
}
