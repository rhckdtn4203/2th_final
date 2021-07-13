package com.kh.khblind;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.Map;
import java.util.UUID;

import org.junit.Test;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.kh.khblind.pay.vo.PayApproveVO;
import com.kh.khblind.pay.vo.PayReadyVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class PayTest2 {
	
	
	// 무조건 paytest 후 정보 받아와서 실행해야 함
	
	@Test
	public void test() throws URISyntaxException {
		// 요청 도구 생성
		RestTemplate template = new RestTemplate();
			
		// Http Header 생성
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "KakaoAK 35653eec91c802cc306677b8a75fc4c6");
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
				
		// Http Body 생성
		MultiValueMap<String,String> body = new LinkedMultiValueMap<>();
		body.add("cid", "TC0ONETIME");
		body.add("tid", "T2918420957972174273"); // 결제 준비요청에 포함된 tid값
		body.add("partner_order_id", "ca203274-1667-4816-b8f9-05763a479767"); // partner_order_id 항목 값
		body.add("partner_user_id", "415f417e-b3ed-483f-8e04-9e960eb7a6dc"); // partenr_user_id 항목값
		body.add("pg_token", "b8ec590974ad36636668"); // 결제 성공 시 파라미터로 전달되는 pg_token
	
		// header + body 
		HttpEntity<MultiValueMap<String,String>> entity = new HttpEntity<>(body,headers);
				
		// 목적지 주소 작성
		URI uri = new URI("https://kapi.kakao.com/v1/payment/approve");
				
		// 전송 
		//Q : 카카오 레퍼런스 문서를 보고 결과를 저장할 수 있는 VO 클래스를 생성하여 요청
		//클래스명은 PayApproveVO 라고 작성합니다.
		//= 내부에는 PayAmountVO , PayCardInfoVO 를 포함하도록 구성
		PayApproveVO approveVO = 
						template.postForObject(uri, entity, PayApproveVO.class);
		log.debug("approveVO = {}", approveVO);
		
	}
	
}

