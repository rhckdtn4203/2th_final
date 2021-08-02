package com.kh.khblind.admin.approveImageCert.entity;
//꾀부리려다가 결국 만들어 버리는VO...

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor  @Builder
public class SendRejectMessageImageCertVo {
	String imageCertMessage;
	int memberNo;
}
