package com.kh.khblind.company.service;

import java.io.File;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.khblind.company.entity.CompanyDto;
import com.kh.khblind.company.entity.CompanyProfileDto;
import com.kh.khblind.company.repository.CompanyDao;
import com.kh.khblind.company.repository.CompanyProfileDao;
import com.kh.khblind.company.vo.CompanyVO;

@Service
public class CompanyServiceImpl implements CompanyService {
	
	private final File ResDir = new File("D:/upload/kh7b/resources/5.company-logo-image/");
	
	@Autowired
	private CompanyDao companyDao;

	@Autowired
	private CompanyProfileDao profileDao;
	
	@Override
	public void companyRegistration(CompanyVO companyVO) throws IllegalStateException, IOException {
		// 1. 회사 번호 추출
		int companyNo = companyDao.sequence();
		
		// 2. 회사 등록
		CompanyDto companyDto = CompanyDto.builder()
				.companyNo(companyNo)
				.companyName(companyVO.getCompanyName())
				.companyUrl(companyVO.getCompanyUrl())
				.companyDomain(companyVO.getCompanyDomain())
				.companyAddr(companyVO.getCompanyAddr())
				.companyIndustry(companyVO.getCompanyIndustry())
				.companyEstablishment(companyVO.getCompanyEstablishment())
				.companyIntroduce(companyVO.getCompanyIntroduce())
				.build();
		companyDao.insert(companyDto);
		
		// 2. 회사 프로필 등록
		if(!companyVO.getCompanyProfile().isEmpty()) {
			File dir = ResDir;
			dir.mkdirs();
			File target = new File(dir, String.valueOf(companyNo));
			companyVO.getCompanyProfile().transferTo(target);
			
			// 3. 프로필 정보 등록
			CompanyProfileDto profileDto = CompanyProfileDto.builder()
					.companyNo(companyNo)
					.companyProfileUploadName(companyVO.getCompanyProfile().getOriginalFilename())
					.companyProfileSaveName(companyVO.getCompanyName())
					.companyProfileContentType(companyVO.getCompanyProfile().getContentType())
					.companyProfileSize(companyVO.getCompanyProfile().getSize())
					.build();
			profileDao.insert(profileDto);
		}
	}

}
