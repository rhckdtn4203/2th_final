package com.kh.khblind.board.uploadImage.repository;

import java.io.IOException;
import java.util.List;

import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import com.kh.khblind.board.uploadImage.entity.BoardImageDto;
import com.kh.khblind.board.uploadImage.vo.ConvertImageVo;
import com.kh.khblind.member.cert.entity.ImageCertDto;


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
	
	
	//사원증 인증 업로드(파일url을 반환)
	String uploadImageCert(int memberNo, MultipartFile image);
	//사원증 업로드 후 DB추가
	boolean insertToDBAfterUpload(ImageCertDto imageCertDto);
	//사원증 사진파일  URL 가져오는 메소드
	String getImageCertInfo(int memberNo);
	//사원증 사진파일 가져오는 메소드
	ResponseEntity<ByteArrayResource> getImageToImageCertJsp(int boardNo) throws IOException;
	//사원증 사진파일을 삭제하는 메소드(승인시)
	void deleteImageChainToImageCert(int memberNo);
	//거절 당하고 다시 업로드 할 때 진행과정 업데이트
	boolean insertToDBAfterUploadAgain(int memberNo);
}
