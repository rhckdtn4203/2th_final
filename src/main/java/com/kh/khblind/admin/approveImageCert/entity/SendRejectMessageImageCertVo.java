package com.kh.khblind.admin.approveImageCert.entity;
//메시지 전송을 위한Vo
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor  @Builder
public class SendRejectMessageImageCertVo {
	String imageCertMessage;
	int memberNo;
}
