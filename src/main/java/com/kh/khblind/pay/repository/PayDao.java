package com.kh.khblind.pay.repository;

import com.kh.khblind.pay.entity.PayDto;

public interface PayDao {
	int getSequence();
	void ready(PayDto payDto);
}
