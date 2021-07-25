package com.kh.khblind.member.repository;

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



//마이페이지
	@Override
	public MemberDto mypage(int memberNo) {
		MemberDto dto = sqlss.selectOne("member.mypage", memberNo);
		return dto;
	}

//마이페이지 수정	
	@Override
	public boolean changeinfo(MemberDto dto) {
		Map<String,Object>param = new HashMap<>();
		param.put("memberNick", dto.getMemberNick());
		param.put("memberPhone", dto.getMemberPhone());
		param.put("memberNo", dto.getMemberNo());
		int count = sqlss.update("member.changeinfo",param);
		return count>0;
		
		}
	
//비빌번호 변경
	@Override
	public boolean change_pw(String newPw, int memberNo, String curPw) {
		Map<String, Object> param = new HashMap<>();
		param.put("newPw", newPw);
		param.put("memberNo", memberNo);
		param.put("curPw", curPw);
		
		int count =sqlss.update("member.change_pw",param);
		
		return count>0;
		
	}	
//아이디찾기
	@Override
	public boolean find_id(String memberName, int memberNo, String memberPhone) {
		Map<String, Object> param = new HashMap<>();
		param.put("memberName", memberName);
		param.put("memberNo", memberNo);
		param.put("memberPhone", memberPhone);
		
		return sqlss.selectOne("member.find_id",param);
	}
	
//회원 탈퇴
	@Override
	public void exit(int memberNo) {
		sqlss.delete("member.exit", memberNo);
	}
	
	// 회원 등급 업데이트 (결제) 
	@Override
	public void gradeup(int memberNo) {
		sqlss.update("member.gradeup", memberNo);
		
}

}