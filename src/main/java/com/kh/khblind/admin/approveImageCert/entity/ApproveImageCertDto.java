package com.kh.khblind.admin.approveImageCert.entity;
//뷰 "approve_image_cert_view" 참고
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
