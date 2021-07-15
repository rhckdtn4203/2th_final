package com.kh.khblind;

import java.net.URISyntaxException;
import java.util.UUID;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.khblind.pay.service.PayService;
import com.kh.khblind.pay.vo.PayReadyPrepareVO;
import com.kh.khblind.pay.vo.PayReadyVO;

import lombok.extern.slf4j.Slf4j;

// PayTest의 내용을 PayService로 옮긴 후 작동 확인

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
@Slf4j
public class PayTest3 {
	
	@Autowired
	private PayService payService;
	
	@Test
	public void test() throws URISyntaxException {
		// 결제 준비 요청
		PayReadyPrepareVO prepareVO = PayReadyPrepareVO.builder()
												.partner_order_id(UUID.randomUUID().toString())
												.partner_user_id(UUID.randomUUID().toString())
												.item_name("결제 테스트")
												.quantity(1)
												.total_amount(5000)
												//.tax_free_amount(0)
							.build();
		PayReadyVO readyVO = payService.ready(prepareVO);
		log.debug("readyVO = {}",readyVO);
	}
}
