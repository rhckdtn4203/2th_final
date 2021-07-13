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
import com.kh.khblind.pay.vo.PayApprovePrepareVO;
import com.kh.khblind.pay.vo.PayApproveVO;
import com.kh.khblind.pay.vo.PayReadyPrepareVO;
import com.kh.khblind.pay.vo.PayReadyVO;

import lombok.extern.slf4j.Slf4j;

// PayTest2의 내용을 PayService로 옮긴 후 작동 확인

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
@Slf4j
public class PayTest4 {
	
	@Autowired
	private PayService payService;
	
	@Test
	public void test() throws URISyntaxException {
		// 결제 승인 요청
		PayApprovePrepareVO prepareVO = PayApprovePrepareVO.builder()
															.tid("T2918433447736994952")
															.partner_order_id("6ea3fb5f-96b8-456b-8814-ce096aeb3c03")
															.partner_user_id("9c7a5f5c-8048-4b27-b31b-e2a2f6acf160")
															.pg_token("dbbcf5592fdbcab40ba8")
										.build();
		PayApproveVO approveVO = payService.approve(prepareVO);
		log.debug("approveVO = {}",approveVO);
	}
}
