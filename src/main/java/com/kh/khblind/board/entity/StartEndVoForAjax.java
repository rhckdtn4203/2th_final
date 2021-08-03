package com.kh.khblind.board.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class StartEndVoForAjax {
int startNo, endNo, jobCategoryNo, companyNo;
Integer boardCategoryNo;
String keyword;


}
