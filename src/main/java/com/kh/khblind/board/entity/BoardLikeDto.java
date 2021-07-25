package com.kh.khblind.board.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor @AllArgsConstructor @Data @Builder
public class BoardLikeDto {
private int boardNo,memberNo;
}
