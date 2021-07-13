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

import com.kh.khblind.pay.vo.PayReadyVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class PayTest {
	
	@Test
	public void test() throws URISyntaxException {
		// 서버 to 서버
		// RestTemplate 이용(spring)
		
		// 요청 도구 생성
		RestTemplate template = new RestTemplate();
		
		// Http Header 생성
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "KakaoAK 35653eec91c802cc306677b8a75fc4c6");
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		// Http Body 생성
		String partner_order_id = UUID.randomUUID().toString();
		log.debug("partner_order_id = {}", partner_order_id);
		
		String partner_user_id = UUID.randomUUID().toString();
		log.debug("partner_user_id = {}", partner_user_id);
		
		MultiValueMap<String,String> body = new LinkedMultiValueMap<>();
		body.add("cid", "TC0ONETIME");
		body.add("partner_order_id", partner_order_id);
		body.add("partner_user_id", partner_user_id);
		body.add("item_name", "회원 플러스");//명세서에 표시될 구매 내역(다건 구매일 경우 ???외 ?건 형식)
		body.add("quantity", "3");//구매수량
		body.add("total_amount", "999900");//총 구매금액
		body.add("tax_free_amount", "0");//면세금액(없으면 0)
		
		
		body.add("approval_url", "http://localhost:8080/khblind/pay/success");
		body.add("cancel_url", "http://localhost:8080/khblind/pay/cancel");
		body.add("fail_url", "http://localhost:8080/khblind/pay/fail");
		
		// header + body 
		HttpEntity<MultiValueMap<String,String>> entity = new HttpEntity<>(body,headers);
		
		// 목적지 주소 작성
		URI uri = new URI("https://kapi.kakao.com/v1/payment/ready");
		
		// 전송 
		//template.postForLocation(uri, entity); // 단순 요청만(응답 기대 x)
		PayReadyVO readyVO = template.postForObject(uri, entity,PayReadyVO.class); // 응답 후 JSON 수신
		log.debug("readyVO = {}",readyVO);
		log.debug("url = {}", readyVO.getNext_redirect_pc_url());
		log.debug("tid = {}", readyVO.getTid());
	}
}
