package com.kh.khblind.pay.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class PayCancelVO {
	private String aid;
	private String tid;
	private String cid;
	private String status;
	private String partner_order_id;
	private String partner_user_id;
	private String payment_method_type;
	private PayAmountVO amount;
	private PayAmountVO approved_cancel_amount ;
	private PayAmountVO canceled_amount;
	private PayAmountVO cancel_available_amount;
	private String item_name;
	private String item_code;
	private int quantity;
	private String created_at;
	private String approved_at;
	private String canceled_at;
	private String payload;
}
