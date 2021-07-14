package com.kh.khblind.member.cert.service;

import java.util.Random;

import org.springframework.stereotype.Service;

@Service
public class RandomServiceImpl implements RandomService {

	@Override
	public String generateCertification(int size) {
		Random rand = new Random();
		StringBuffer buffer = new StringBuffer();
		
		for(int i = 0; i < size; i++) {
			int tmp = rand.nextInt(3);
			
		    if(tmp == 0) {
		    	buffer.append((char)((int)(rand.nextInt(26))+97));
		    }
		    else if(tmp == 1) {
		    	buffer.append((char)((int)(rand.nextInt(26))+65));
		    }
		    else {
		    	buffer.append((rand.nextInt(10)));
		    }
		}
		
		return buffer.toString();
	}

}
