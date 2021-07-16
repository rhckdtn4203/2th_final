package com.kh.khblind.board.vote.test;

import org.junit.Test;

public class Test06_mathProblem {

	@Test
	public void test1(){
		int all = 100;
		int part = 2;
		int c = (int)((float)part/(float)all*100)/1;
		int d = (int)c;
		System.out.println("c = " + c);
		
		String e = String.format("%.0f", c);
		
		System.out.println("d = " + d);
		
		
	}
	
}
