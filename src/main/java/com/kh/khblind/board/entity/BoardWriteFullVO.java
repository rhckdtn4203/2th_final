package com.kh.khblind.board.entity;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class BoardWriteFullVO {
	//BoardWriteVo
	private List<Integer> hashtagNo;
	private List<String> hashtagName;

	String boardTitle, boardContent;
	int boardNo, boardCount, memberNo;
	Date boardDate;
	
	//BoardCategoryGroupDto
	private int boardCategoryNo;
	
	//CompanyGroupDto 
	private int companyNo;
	
	//JobCategoryGroupDto 
	private int jobCategoryNo;
	
	//UploadImageVo
	List<MultipartFile> images;
	
	//VoteInsertInfoVo
	//private int boardNo;
	private int voteTopicNo;
	private String voteTopicTitle;
	private List<String> voteTopicOption;
}
