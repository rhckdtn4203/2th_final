package com.kh.khblind.pay.service;

import java.net.URISyntaxException;

import com.kh.khblind.pay.vo.PayApprovePrepareVO;
import com.kh.khblind.pay.vo.PayApproveVO;
import com.kh.khblind.pay.vo.PayCancelPrepareVO;
import com.kh.khblind.pay.vo.PayCancelVO;
import com.kh.khblind.pay.vo.PayReadyPrepareVO;
import com.kh.khblind.pay.vo.PayReadyVO;
import com.kh.khblind.pay.vo.PaySearchVO;

public interface PayService {
	
	// 결제 준비 요청
	PayReadyVO ready(PayReadyPrepareVO payReadyPrepareVO)throws URISyntaxException;
	
	// 결제 승인 요청
	PayApproveVO approve(PayApprovePrepareVO payApprovePrepareVO) throws URISyntaxException;
	
	// 결제 조회 기능
	PaySearchVO search(String tid) throws URISyntaxException;
	
	// 결제 취소 기능
	PayCancelVO cancel(PayCancelPrepareVO prepareVO) throws URISyntaxException;
	
	// 스케줄러 추가
	void gradeExipre();
}
