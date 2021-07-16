package com.kh.khblind.board.vote.test;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.khblind.board.vote.entity.VoteOptionInfoVo;
import com.kh.khblind.board.vote.entity.VoteViewInfoVo;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })
@WebAppConfiguration
public class Test05_voteFullInfo {

	@Autowired
	private SqlSession sqlSession;
	
	@Test
	public void test1() {
		
		int boardNo=2;
		
		//투표제목, 만료시점가져오기 -_-
		VoteViewInfoVo voteViewFullVo =  sqlSession.selectOne("vote.getTopicInfo", boardNo);
		
		
		System.out.println("@@@@@@@@" + voteViewFullVo);
		
		//투표선택지 결과 가져오기
		List<VoteOptionInfoVo> voteOptionInfoVoList = sqlSession.selectList("vote.getOptionInfo", boardNo);
		System.out.println(voteOptionInfoVoList);
		
		voteViewFullVo.setVoteOptionInfoVoList(voteOptionInfoVoList);
		
		System.out.println("&&&&&&&&&&&&" + voteViewFullVo);
		
	}
}
