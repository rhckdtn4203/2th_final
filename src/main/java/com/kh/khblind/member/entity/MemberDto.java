package com.kh.khblind.member.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class MemberDto {
	private int memberNo;
	private int companyNo;
	private int gradeNo;
	private int jobCategoryNo;
	private String memberName;
	private String memberNick;
	private String memberId;
	private String memberPw;
	private String memberPhone;
	private String memberEmail;
	

}
