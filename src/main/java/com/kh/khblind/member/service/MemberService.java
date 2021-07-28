package com.kh.khblind.member.service;

import com.kh.khblind.member.entity.MemberDto;

public interface MemberService {

	MemberDto findId(MemberDto vo);

	MemberDto findPassword(MemberDto vo);

	void updatePassword(MemberDto vo);
}
