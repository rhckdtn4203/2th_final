package com.kh.khblind;

import static org.junit.Assert.assertTrue;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.kh.khblind.company.entity.CompanyDto;
import com.kh.khblind.member.cert.entity.CertDto;
import com.kh.khblind.member.cert.repository.CertDao;

public class CompanyDomainTest {
	
	@Autowired
	private CertDao certDao;
	
	@Autowired
	private SqlSession sqlSession;
	
	@Test
	public void test() {
		String email = "jyha0424@gmail.com";
		String companyDomain = email.substring(email.lastIndexOf("@"));
		
		CertDto certDto = CertDto.builder()
				.email("hjy---@daum.net")
				.emailCertNo("122426")
				.build();
		boolean result = certDao.check(certDto);
		if(result) {
			certDao.deleteByEmail(certDto.getEmail());
		}
		assertTrue(result);
		
//		CompanyDto dto =  sqlSession.selectOne("cert.check", );
//		if(dto == null) System.out.println("null");
//		else System.out.println(dto);
	}
	
}
