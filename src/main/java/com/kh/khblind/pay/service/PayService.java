package com.kh.khblind.pay.service;

import java.net.URISyntaxException;

import com.kh.khblind.pay.vo.PayApprovePrepareVO;
import com.kh.khblind.pay.vo.PayApproveVO;
import com.kh.khblind.pay.vo.PayReadyPrepareVO;
import com.kh.khblind.pay.vo.PayReadyVO;

public interface PayService {
	
	// 결제 준비 요청
	PayReadyVO ready(PayReadyPrepareVO payReadyPrepareVO)throws URISyntaxException;
	
	// 결제 승인 요청
	PayApproveVO approve(PayApprovePrepareVO payApprovePrepareVO) throws URISyntaxException;
	
}
