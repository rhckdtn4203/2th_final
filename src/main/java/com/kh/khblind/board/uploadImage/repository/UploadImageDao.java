package com.kh.khblind.board.uploadImage.repository;

import java.io.IOException;
import java.util.List;

import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import com.kh.khblind.board.uploadImage.entity.BoardImageDto;
import com.kh.khblind.board.uploadImage.vo.ConvertImageVo;


public interface UploadImageDao {
	//단순 업로드
	List<String> uploadOriginalFile(List<MultipartFile> images, int memberNo);
	//로테이션 정보 추출
	List<Integer> getRotationValue(List<String> fileNameList);
	//폴더이름 정하기
	String getImageFolderName(int boardNo);
	//변환작업 거치기
	List<String> convertImage(ConvertImageVo convertImageVo) throws IOException;
	//원본 파일 지우기
	boolean deleteOrigin(ConvertImageVo convertImageVo, List<String> deleteFileList);
	//썸네일만들기
	boolean makeThumb (ConvertImageVo convertImageVo, String firstFileFinalName) throws IOException;

	//이미지 가져오기
	List<ResponseEntity<ByteArrayResource>> getImageToJsp(int boardNo) throws IOException; //ByteArrayResource은 거들뿐 어렵게 생각하지 말자
	List<BoardImageDto> getBoardImageInfo(int boardNo);
	
	
	//글 삭제시 같이 지워짐
	boolean deleteImageChainToBoard (int boardNo);
}
