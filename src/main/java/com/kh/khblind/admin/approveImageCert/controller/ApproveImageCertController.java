package com.kh.khblind.admin.approveImageCert.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.khblind.admin.approveImageCert.entity.ApproveImageCertDto;
import com.kh.khblind.admin.approveImageCert.repository.ApproveImageCertDao;
import com.kh.khblind.board.uploadImage.repository.UploadImageDao;
import com.kh.khblind.member.cert.repository.CertDao;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin")
@Slf4j
public class ApproveImageCertController {
	
	@Autowired
	private ApproveImageCertDao approveImageCertDao;
	
	@Autowired
	private CertDao certDao;
	
	@Autowired
	private UploadImageDao uploadImageDao;

	@GetMapping("/approveImageCert")
	public String approveImageCert(Model model) {
		
		List<ApproveImageCertDto> approveImageCertReadyList = approveImageCertDao.getApproveImageCertList();
		model.addAttribute("approveImageCertReadyList", approveImageCertReadyList);
		
		return "admin/approveImageCert";
	}
	
	
	@PostMapping("/approveImageCert")
	public String approveImageCert(int memberNo) {
		log.debug("{}번 회원의  사원증을 회원 승인하는 중 ", memberNo);
		//승인 후 등업 (+2)
		certDao.upgrade(memberNo);	
		
		//DB변경 ing-> end
		certDao.approveImageCert(memberNo); 
		
		//원본 파일 삭제
		uploadImageDao.deleteImageChainToImageCert(memberNo); 
		return "redirect:approveImageCert";
		
	}
	
	@PostMapping("/rejectImageCert")
	public String rejectImageCert(int memberNo, String imageCertMessage) {
		log.debug("{}번 회원의  사원증을 회원 거절하는 중 ", memberNo);
		certDao.rejectImageCert(memberNo, imageCertMessage);
		
		return "redirect:approveImageCert";
	}
}
