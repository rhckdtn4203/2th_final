package com.kh.khblind.board.entity;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor @NoArgsConstructor @Data @Builder
public class BoardSearchListVO {
   private int  boardCount;
   private String boardCategoryName,boardTitle,boardContent,companyName,memberName;
   private Date boardDate;
   
   
   
   
}