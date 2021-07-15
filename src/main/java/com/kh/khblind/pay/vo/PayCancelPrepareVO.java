package com.kh.khblind.pay.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class PayCancelPrepareVO {
	private String tid;
	private int cancel_amount;
	private int cancel_tax_free_amount;
}
