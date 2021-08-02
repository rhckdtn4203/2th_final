package com.kh.khblind.admin.approveImageCert.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.khblind.admin.approveImageCert.entity.ApproveImageCertDto;

@Repository
public class ApproveImageCertDaoImpl implements ApproveImageCertDao{

	@Autowired
	private SqlSession sqlSession; 
	
	@Override
	public List<ApproveImageCertDto> getApproveImageCertList() {
		List<ApproveImageCertDto> approveImageCertReadyList = sqlSession.selectList("cert.getApproveImageCertList");
		return approveImageCertReadyList;
	}

}
