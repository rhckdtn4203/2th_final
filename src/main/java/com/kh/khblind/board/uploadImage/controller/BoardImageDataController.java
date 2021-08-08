package com.kh.khblind.board.uploadImage.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.khblind.board.uploadImage.entity.BoardImageDto;
import com.kh.khblind.board.uploadImage.repository.UploadImageDao;

import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/board")
@Slf4j
public class BoardImageDataController {
		
	@Autowired
	private UploadImageDao uploadImageDao;
	
	private final File ResDir = new File("D:/upload/kh7b");
	private final File SavedDir = new File(ResDir + "/4.saved-image/");
	
	@RequestMapping("getImageInfo")
	public List<BoardImageDto> getImageInfo (int boardNo) throws IOException {
		List<BoardImageDto> boardImageInfoList =  uploadImageDao.getBoardImageInfo(boardNo);
		return boardImageInfoList;
	}
	
	@GetMapping("getImageFlie")
	public ResponseEntity<ByteArrayResource> getImageFlie(int boardNo, String fileName) throws IOException {
		
		String superFolderName = uploadImageDao.getImageFolderName(boardNo); 
		String finalFolderName = SavedDir+"\\"+superFolderName+"\\"+boardNo+"\\";
		
		File target = new File(finalFolderName, fileName);
		log.debug("파일명 : {}의 파일 존재 여부 {}", target, target.exists());
		
		byte[] data = FileUtils.readFileToByteArray(target);
		ByteArrayResource resource = new ByteArrayResource(data);

		return 	ResponseEntity.ok()
				.contentType(MediaType.APPLICATION_OCTET_STREAM)
				.contentLength(target.length())
				.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\""+URLEncoder.encode(target.getName(), "UTF-8")+"\"")
				.header(HttpHeaders.CONTENT_ENCODING, "UTF-8")
				.body(resource);

	}
}
