package com.kh.khblind.pay.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class PayDto {
	private int payNo;
	private String payTid;
	private int paytBuyer;
	private String payStatus;
	private Date payTime;
}
