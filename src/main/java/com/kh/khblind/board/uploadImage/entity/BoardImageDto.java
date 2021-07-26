package com.kh.khblind.board.uploadImage.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class BoardImageDto {
	private int boardImageNo;
	private int boardNo;
	private String boardImageUrl;
}
