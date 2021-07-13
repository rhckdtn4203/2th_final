package com.kh.khblind.pay.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class PayApprovePrepareVO {
	private String tid;
	private String partner_order_id;
	private String partner_user_id;
	private String pg_token;
}
