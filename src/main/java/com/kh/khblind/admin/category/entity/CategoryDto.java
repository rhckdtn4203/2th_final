package com.kh.khblind.admin.category.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor @AllArgsConstructor @Data @Builder
public class CategoryDto {
private int boardCategoryNo;
private String boardCategoryName,boardCategoryIcon;

}
