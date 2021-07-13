package com.kh.khblind.pay.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

// 결제 준비 요청에 필요한 데이터
@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class PayReadyPrepareVO {
	
	private String partner_order_id;
	private String partner_user_id;
	private String item_name;
	private int quantity;
	private int total_amount;
	private int tax_free_amount;
	
	
	
}
