package com.kh.khblind.member.repository;

import java.lang.reflect.Member;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.khblind.member.entity.MemberDto;

@Repository
public class MemberDaoImpl implements MemberDao {
	@Autowired
	private SqlSession sqlss;

//로그인
	@Override
	public MemberDto login(MemberDto dto) {
		return sqlss.selectOne("member.login", dto);
	}

//회원가입
	@Override
	public void insert(MemberDto dto) {
		sqlss.insert("member.signup", dto);
	}



}
