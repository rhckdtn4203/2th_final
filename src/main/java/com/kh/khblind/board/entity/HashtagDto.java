package com.kh.khblind.board.entity;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class HashtagDto {
	private int hashtagNo;
	private String hashtagName;
}
