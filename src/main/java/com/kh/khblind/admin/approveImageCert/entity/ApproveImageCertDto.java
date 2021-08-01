package com.kh.khblind.admin.approveImageCert.entity;
//뷰approve_image_cert_view 뷰 기준

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class ApproveImageCertDto {
	private int imageCertNo;
	private int memberNo;
	private int jobCategoryNo;
	private String imageCertUrl;
	private String memberName;
	private String memberNick;
	private String imageCertProgress;
	private String imageCertMessage;

}
