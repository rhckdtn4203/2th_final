package com.kh.khblind.board.uploadImage.repository;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.khblind.board.uploadImage.vo.ConvertImageVo;


public interface UploadImageDao {
	//단순 업로드
	List<String> uploadOriginalFile(List<MultipartFile> images, int memberNo);
	//로테이션 정보 추출
	List<Integer> getRotationValue(List<String> fileNameList);
	//폴더이름 정하기
	String getImageFolderName(int boardNo);
	//변환작업 거치기
	void convertImage(ConvertImageVo convertImageVo) throws IOException;
	
	//랜버트 관련
//	List<String> makeRandomFileName();
//	List<Integer> getRotationValue(List<String> uploadOriginalFile);
//	String convertFile(List<String> fileNameList);
//	void deleteOrigin(String uploadPath);
//	
//	//DB관련
//	int getSequence();
//	boolean insert(PictureDto pictureDto);
}
