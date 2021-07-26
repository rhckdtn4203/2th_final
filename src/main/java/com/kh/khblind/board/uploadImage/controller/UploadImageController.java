package com.kh.khblind.board.uploadImage.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.khblind.board.uploadImage.repository.UploadImageDao;
import com.kh.khblind.board.uploadImage.vo.ConvertImageVo;

@Controller
@RequestMapping("/board")
public class UploadImageController {
	
	@Autowired
	private UploadImageDao uploadImageDao; 
	
	@GetMapping("/imageUploadTest")
	public String imageUploadTest() {
		return "/board/imageUploadTest";
	}
	
	@PostMapping("/imageUploadTest")
	public String uploadImageFile(@RequestParam List<MultipartFile> images, HttpSession session) throws IOException {
		//1. 단순 업로드를 하면서 파일이름 리스트를 내뱉는다.
		int memberNo = 2;
		List<String> fileNameList = uploadImageDao.uploadOriginalFile(images, memberNo);
		if(fileNameList==null) {return "/board/파일업로드실패/이유는-서버에업로드가되지않음";}	
		
		//2. 1에서 받은 리스트를 활용하여 각 이미지의 로테이션 번호로 회전해야할 각도 리스트를 가져온다.
		List<Integer> rotationValueList = uploadImageDao.getRotationValue(fileNameList);
		
		//3. 폴더 이름을 미리 정한다.
		int tempBoardNo = 2034;
		String superFolderName = uploadImageDao.getImageFolderName(tempBoardNo);
		
		//4. 1과 2를 활용하여 파일 리사이즈를 거친다
		ConvertImageVo convertImageVo =ConvertImageVo.builder()
														.fileNameList(fileNameList)
														.rotationValueList(rotationValueList)
														.superFolderName(superFolderName)
														.folderName(Integer.toString(tempBoardNo))
														.build();
		System.out.println("convertImageVo" + convertImageVo);
		
		List<String> readyFileNameList = uploadImageDao.convertImage(convertImageVo);
		
		//5. 삭제하기
		boolean deleteSuccess = uploadImageDao.deleteOrigin(convertImageVo, readyFileNameList);
		
		//6. 썸네일 만들기
		String firstFileFullName = readyFileNameList.get(0);
		String firstFileFinalName = firstFileFullName.replace("-ready", "");
		boolean makeThumbSuccess = uploadImageDao.makeThumb(convertImageVo, firstFileFinalName);


		
		return "/board/사진 업로드 성공!";
	}
	

}
