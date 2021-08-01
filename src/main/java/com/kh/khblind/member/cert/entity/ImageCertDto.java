package com.kh.khblind.member.cert.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class ImageCertDto {
	private int imageCertNo;
	private int memberNo;
	private int jobCategoryNo;
	private String imageCertUrl;
	private String imageCertProgress;
	private String imageCertMessage;
}
