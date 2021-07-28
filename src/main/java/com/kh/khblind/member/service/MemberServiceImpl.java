package com.kh.khblind.member.service;

import org.springframework.beans.factory.annotation.Autowired;

import com.kh.khblind.member.entity.MemberDto;
import com.kh.khblind.member.repository.MemberSearchDao;

public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberSearchDao dao;
	

	@Override
	public MemberDto findId(MemberDto vo) {
		// TODO Auto-generated method stub
		return dao.findId(vo);
	}

	@Override
	public MemberDto findPassword(MemberDto vo) {
		// TODO Auto-generated method stub
		return dao.findPassword(vo);

	}

	@Override
	public void updatePassword(MemberDto vo) {
		dao.updatePassword(vo);
		
	}

}
