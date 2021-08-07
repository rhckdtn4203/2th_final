package com.kh.khblind.admin.approveImageCert.restcontroller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.khblind.board.repository.BoardDao;
import com.kh.khblind.board.uploadImage.repository.UploadImageDao;

@RestController
@RequestMapping("/admin")
public class ApproveImageCertDataController {

	@Autowired
	private BoardDao boardDao;
	
	@Autowired
	private UploadImageDao uploadImageDao; 
	
	//(현재 사용되지 않음)신청시 업종명을 제시할 수 있었음
	@RequestMapping(value ="/getJobCategoryName", produces = "application/text; charset=utf8")
	public String getJobCategoryName(int jobCategoryNo) {
		String jobCategoryName = boardDao.getJobCategoryName(jobCategoryNo);
		
		return jobCategoryName;
		
	}
	
	
	@RequestMapping("getImageCertUrl")
	public String getImageCertUrl(int memberNo) {
		String fileUrl = uploadImageDao.getImageCertInfo(memberNo);
		
		return fileUrl;
		
	}
	
	@RequestMapping("/getImageToImageCertJsp")
	public ResponseEntity<ByteArrayResource> getImageToImageCertJsp(int memberNo){
		
		ResponseEntity<ByteArrayResource> image;
		try {
			image = uploadImageDao.getImageToImageCertJsp(memberNo);
			
			return image;
		} catch (IOException e) {
			e.printStackTrace();
			
			return null;
		}
		
	}
	
}
