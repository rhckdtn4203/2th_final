package com.kh.khblind.member.repository;

import com.kh.khblind.member.entity.MemberDto;

public interface MemberDao {
	
	MemberDto login(MemberDto dto);
	void insert(MemberDto dto);
	MemberDto mypage(int memberNo);
	boolean changeinfo(MemberDto dto);
	void exit(int memberNo);
	void gradeup(int memberNo);
	
}
