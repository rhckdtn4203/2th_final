package com.kh.khblind.board.uploadImage.vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class ConvertImageVo {
	int boardNo;
	List<String> fileNameList;
	List<Integer> rotationValueList;
	String superFolderName;
	String folderName;
}
