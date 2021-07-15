package com.kh.khblind.pay.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class PaymentActionDetailVO {
	private String aid;						//Request 고유 번호
	private String approved_at;				//거래시간
	private int amount;						//결제/취소 총액
	private int point_amount;				//결제/취소 포인트 금액
	private int discount_amount;			//할인 금액
	private String payment_action_type;		//결제 타입(PAYMENT:결제, CANCEL:취소, ISSUED_SID:SID 발급)
	private String payload;					//Request로 전달할 값
}
