package com.kh.khblind.member.repository;

import java.util.*;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.khblind.member.entity.MemberDto;

@Repository
public class MemberSearchDao {

	@Autowired
	private SqlSessionTemplate mybatis;

	public MemberDto loginUser(MemberDto vo) {
		System.out.println("==> Mybatis로 loginUser() 기능 처리");
		return mybatis.selectOne("UserDAO.loginUser", vo);
	}

	public MemberDto findId(MemberDto vo) {
		System.out.println("==> Mybatis로 findId() 기능 처리");
		return mybatis.selectOne("UserDAO.findId", vo);
	}

	public MemberDto findPassword(MemberDto vo) {
		System.out.println("==> Mybatis로 findPassword() 기능 처리");
		return mybatis.selectOne("UserDAO.findPassword", vo);
	}

	public void updatePassword(MemberDto vo) {
		System.out.println("==> Mybatis로 updatePassword() 기능 처리");
		mybatis.update("UserDAO.updatePassword", vo);
	}
}