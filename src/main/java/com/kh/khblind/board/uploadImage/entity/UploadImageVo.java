package com.kh.khblind.board.uploadImage.entity;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class UploadImageVo {
	List<MultipartFile> imageList;
}
