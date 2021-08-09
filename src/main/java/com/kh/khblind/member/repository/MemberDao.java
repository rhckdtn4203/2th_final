package com.kh.khblind.member.repository;

import com.kh.khblind.member.entity.MemberDto;

public interface MemberDao {
	
	MemberDto login(MemberDto dto);
	void insert(MemberDto dto);
	MemberDto mypage(int memberNo);
//	boolean changeinfo(MemberDto dto);
	void exit(int memberNo);
	void gradeup(int memberNo);

	boolean change_pw(String newPw, int memberNo, String curPw);
	String find_id(String memberName,String memberPhone);


	

	void gradedown(int memberNo);
	boolean changeinfo(String memberNick, int memberNo, String memberPhone);

}