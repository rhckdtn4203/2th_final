package com.kh.khblind.board.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@AllArgsConstructor @NoArgsConstructor @Data @Builder 
public class BoardCategoryVO {
private int boardNo;
private String boardTitle,boardCategoryName;
private Date boardDate;
}
