package com.kh.khblind.member.repository;

import com.kh.khblind.member.entity.MemberDto;

public interface MemberDao {
	
	MemberDto login(MemberDto dto);
	void insert(MemberDto dto);
	
}
