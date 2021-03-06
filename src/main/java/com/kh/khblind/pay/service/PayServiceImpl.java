package com.kh.khblind.pay.service;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.kh.khblind.member.repository.MemberDao;
import com.kh.khblind.pay.entity.PayDto;
import com.kh.khblind.pay.repository.PayDao;
import com.kh.khblind.pay.vo.PayApprovePrepareVO;
import com.kh.khblind.pay.vo.PayApproveVO;
import com.kh.khblind.pay.vo.PayCancelPrepareVO;
import com.kh.khblind.pay.vo.PayCancelVO;
import com.kh.khblind.pay.vo.PayReadyPrepareVO;
import com.kh.khblind.pay.vo.PayReadyVO;
import com.kh.khblind.pay.vo.PaySearchVO;

import lombok.extern.slf4j.Slf4j;

// 많은 결제 시스템 중 kakaoPay를 구현
@Service
@Slf4j
public class PayServiceImpl implements PayService{
	
	@Autowired
	private PayDao payDao;
	
	@Autowired
	private MemberDao memberDao;
	
	
	public static final String cid = "TC0ONETIME";
	public static final String adminKey = "35653eec91c802cc306677b8a75fc4c6";
	public static final String kakaoAk = "KakaoAK " + adminKey;
	public static final String contentType = "application/x-www-form-urlencoded;charset=utf-8";

	@Override
	public PayReadyVO ready(PayReadyPrepareVO payReadyPrepareVO) throws URISyntaxException {
		
		// 주문번호 생성 
		int payNo = payDao.getSequence();
		payReadyPrepareVO.setPartner_order_id(String.valueOf(payNo));
		
		// 요청 도구 생성 
		RestTemplate template = new RestTemplate();
		
		// Http Header 생성
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "KakaoAK "+adminKey);
		headers.add("Content-type", contentType);
		
		// Http Body 생성
		MultiValueMap<String,String> body = new LinkedMultiValueMap<>();
		body.add("cid", cid);
		body.add("partner_order_id", payReadyPrepareVO.getPartner_order_id());
		body.add("partner_user_id", payReadyPrepareVO.getPartner_user_id());
		body.add("item_name", payReadyPrepareVO.getItem_name());
		body.add("quantity", String.valueOf(payReadyPrepareVO.getQuantity()));//구매수량
		body.add("total_amount",String.valueOf(payReadyPrepareVO.getTotal_amount()));//총 구매금액
		body.add("tax_free_amount",String.valueOf(payReadyPrepareVO.getTax_free_amount()));//면세금액(없으면 0)
		
		
		body.add("approval_url", "http://localhost:8080/khblind/pay/success");
		body.add("cancel_url", "http://localhost:8080/khblind/pay/cancel");
		body.add("fail_url", "http://localhost:8080/khblind/pay/fail");
		
		// header + body 
		HttpEntity<MultiValueMap<String,String>> entity = new HttpEntity<>(body,headers);
		
		// 목적지 주소 작성
		URI uri = new URI("https://kapi.kakao.com/v1/payment/ready");
		
		// 전송 
		PayReadyVO readyVO = template.postForObject(uri, entity,PayReadyVO.class); // 응답 후 JSON 수신
		
		// DB 등록 
		PayDto payDto = PayDto.builder()
										.payNo(Integer.valueOf(payReadyPrepareVO.getPartner_order_id()))
										.payTid(readyVO.getTid())
										.payBuyer(Integer.valueOf(payReadyPrepareVO.getPartner_user_id()))
								.build();
			
		 
		payDao.ready(payDto);
		
		// 컨트롤러에서 사용할 수 있도록 추가 데이터 세팅하여 반환 
		readyVO.setPartner_order_id(payReadyPrepareVO.getPartner_order_id());
		readyVO.setPartner_user_id(payReadyPrepareVO.getPartner_user_id());
		
		return readyVO;
	}

	@Override
	public PayApproveVO approve(PayApprovePrepareVO payApprovePrepareVO) throws URISyntaxException {
		// 요청 도구 생성
		RestTemplate template = new RestTemplate();
					
		// Http Header 생성
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "KakaoAK "+adminKey);
		headers.add("Content-type", contentType);
						
		// Http Body 생성
		MultiValueMap<String,String> body = new LinkedMultiValueMap<>();
		body.add("cid", cid);
		body.add("tid", payApprovePrepareVO.getTid()); // 결제 준비요청에 포함된 tid값
		body.add("partner_order_id", payApprovePrepareVO.getPartner_order_id()); // partner_order_id 항목 값
		body.add("partner_user_id", payApprovePrepareVO.getPartner_user_id()); // partenr_user_id 항목값
		body.add("pg_token", payApprovePrepareVO.getPg_token()); // 결제 성공 시 파라미터로 전달되는 pg_token
			
		// header + body 
		HttpEntity<MultiValueMap<String,String>> entity = new HttpEntity<>(body,headers);
						
		// 목적지 주소 작성
		URI uri = new URI("https://kapi.kakao.com/v1/payment/approve");
						
		// 전송 
		PayApproveVO approveVO = 
							template.postForObject(uri, entity, PayApproveVO.class);
		
		// DB의 결제 상태를 승인으로 변경
		payDao.approve(Integer.parseInt(payApprovePrepareVO.getPartner_order_id()));
		
		// 결제 후 member의 grade 올리기
		int memberNo = Integer.valueOf(approveVO.getPartner_user_id());
		memberDao.gradeup(memberNo);
			
		return approveVO;
	}
	
	
	@Override
	public PaySearchVO search(String tid) throws URISyntaxException {
		//[1] 요청 도구 생성
		RestTemplate template = new RestTemplate();
		
		//[2] Http Header 생성
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", kakaoAk);
		headers.add("Content-type", contentType);
		
		//[3] Http Body 생성
		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("cid", cid);
		body.add("tid", tid);
		
		//[4] Http Header / Body 합성
		HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(body, headers);
		
		//[5] 목적지 주소 작성
		URI uri = new URI("https://kapi.kakao.com/v1/payment/order");
		
		//[6] 전송
		PaySearchVO searchVO = template.postForObject(uri, entity, PaySearchVO.class);
		
		return searchVO;
	}

	@Override
	public PayCancelVO cancel(PayCancelPrepareVO prepareVO) throws URISyntaxException {
		
		PayDto payDto = payDao.get(prepareVO.getPayNo());
		
		//[1] 요청 도구 생성
		RestTemplate template = new RestTemplate();
			
		//[2] Http Header 생성
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", kakaoAk);
		headers.add("Content-type", contentType);
				
		//[3] Http Body 생성
		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("cid", cid);
		body.add("tid", payDto.getPayTid());
		body.add("cancel_amount", String.valueOf(prepareVO.getCancel_amount()));
		body.add("cancel_tax_free_amount", String.valueOf(prepareVO.getCancel_tax_free_amount()));
				
		//[4] Http Header / Body 합성
		HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(body, headers);
				
		//[5] 목적지 주소 작성
		URI uri = new URI("https://kapi.kakao.com/v1/payment/cancel");
				
		//[6] 전송
		PayCancelVO cancelVO = 
					template.postForObject(uri, entity, PayCancelVO.class);
		
		// DB상태를 취소로 변경하는 코드 
		payDao.cancel(prepareVO.getPayNo());
		
		// 결제 취소 후 member의 grade 내리기
		int memberNo = payDto.getPayBuyer();
		memberDao.gradedown(memberNo);
		
		return cancelVO;	
	}
	
	// 결제 후 한달이 지난 멤버 등급 번호 내리기 
	// 회원마다 결제일이 다르므로 결제테이블의 결제만료날짜(결제일+30일)과 오늘날짜와 같으면 회원 등급 내리기 
	@Scheduled(cron = "0 0 * * * *")
	@Override
	public void gradeExipre() {
		payDao.expire();
		//log.debug("제발");
	}
	
}
