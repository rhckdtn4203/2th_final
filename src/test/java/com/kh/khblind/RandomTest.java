package com.kh.khblind;

import java.util.Random;

import org.junit.Test;

public class RandomTest {

	Random rand = new Random();
	StringBuffer buf =new StringBuffer();

	@Test
	public void test() {
		StringBuffer buf = new StringBuffer();
		
		for(int i = 0; i < 6; i++) {
			int tmp = rand.nextInt(3);
			
		    if(tmp == 0) {
		        buf.append((char)((int)(rand.nextInt(26))+97));
		    }
		    else if(tmp == 1) {
		    	buf.append((char)((int)(rand.nextInt(26))+65));
		    }
		    else {
		        buf.append((rand.nextInt(10)));
		    }
		}
		
		System.out.println(buf);
	}
}
