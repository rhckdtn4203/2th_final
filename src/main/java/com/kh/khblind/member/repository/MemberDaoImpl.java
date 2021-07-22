package com.kh.khblind.member.repository;

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

//마이페이지
	@Override
	public MemberDto mypage(int memberNo) {
		MemberDto dto = sqlss.selectOne("member.mypage", memberNo);
		return dto;
	}

//마이페이지 수정	
	@Override
	public boolean changeinfo(MemberDto dto) {
		int count = sqlss.update("member.changeinfo", dto);
		return count > 0;
	}

//회원 탈퇴
	@Override
	public void exit(int memberNo) {
		sqlss.delete("member.exit", memberNo);
	}
	
	// 회원 등급 올리기 (결제) 
	@Override
	public void gradeup(int memberNo) {
		sqlss.update("member.gradeup", memberNo);
		
	}
	
	// 회원 등급 내리기 (결제)
	@Override
	public void gradedown(int memberNo) {
		sqlss.update("member.gradedown",memberNo);
		
	}
	
	
	

}