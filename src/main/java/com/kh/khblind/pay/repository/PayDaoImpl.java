package com.kh.khblind.pay.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.khblind.pay.entity.PayDto;

@Repository
public class PayDaoImpl implements PayDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int getSequence() {
		return sqlSession.selectOne("pay.sequence");
	}

	@Override
	public void ready(PayDto payDto) {
		sqlSession.insert("pay.ready",payDto);
		
	}
	
	
}
