package com.kh.khblind.member.cert.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.khblind.admin.approveImageCert.entity.SendRejectMessageImageCertVo;
import com.kh.khblind.company.entity.CompanyDto;
import com.kh.khblind.member.cert.entity.CertDto;
import com.kh.khblind.member.cert.entity.ImageCertDto;

@Repository
public class CertDaoImpl implements CertDao {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insert(CertDto certDto) {
		sqlSession.insert("cert.insert", certDto);
	}

	@Override
	public boolean check(CertDto certDto) {
		CertDto find = sqlSession.selectOne("cert.check", certDto);
		return find != null;
	}

	@Override
	public void deleteByEmail(String email) {
		sqlSession.delete("cert.deleteByEmail", email);
	}

	@Override
	public void clear() {
		sqlSession.delete("cert.deleteByTime");
	}

	@Override
	public void upgrade(int memberNo) {
		sqlSession.update("cert.upgrade", memberNo);
	}

	@Override
	public boolean checkCompany(String companyDomain) {
		CompanyDto check = sqlSession.selectOne("cert.checkCompany", companyDomain);
		return check != null;
	}

	// 아래는 석현
	@Override
	public String checkImageCertProgress(int memberNo) {
		String imageCertProgress = "didnt"; // 가장 기본값
		ImageCertDto imageCertDto =  new ImageCertDto();
		imageCertDto = sqlSession.selectOne("cert.checkImageCertProgress", memberNo);
		if (imageCertDto != null) {
			imageCertProgress = imageCertDto.getImageCertProgress();
		}
		return imageCertProgress;
	}

	@Override
	public void approveImageCert(int memberNo) {
		sqlSession.update("cert.approveImageCert", memberNo);
	}

	@Override
	public void rejectImageCert(int memberNo, String imageCertMessage) {
		sqlSession.update("cert.rejectImageCert", memberNo);
		SendRejectMessageImageCertVo sendRejectMessageImageCertVo = 
				SendRejectMessageImageCertVo.builder()
				.imageCertMessage(imageCertMessage)
				.memberNo(memberNo)
				.build();
		sqlSession.update("cert.sendRejectMessageImageCert", sendRejectMessageImageCertVo);
	}

	@Override
	public String getImageCertMessage(int memberNo) {
		String imageCertMessage =  sqlSession.selectOne("cert.getImageCertMessage", memberNo);
		return imageCertMessage;
	}
}