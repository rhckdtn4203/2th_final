package com.kh.khblind.pay.repository;

import java.util.List;

import com.kh.khblind.pay.entity.PayDto;

public interface PayDao {
	int getSequence();
	void ready(PayDto payDto);
	void approve(int payNo);
	List<PayDto> list(int payBuyer);
	PayDto get(int payNo);
	void cancel(int payNo);
	void expire();
	List<PayDto> selectexpire();
}
