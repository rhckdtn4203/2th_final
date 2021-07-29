package com.kh.khblind.board.basic.test;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.junit.Test;

public class Test01 {

	@Test
	public void test1(){
		String s="</div> </input> \" \" ";
		//꺽쇠 처리s
		s = s.replaceAll("<", "&gt;");
		s = s.replaceAll(">", "&l1t;");
		
		//따옴표 처리
		s = s.replaceAll("\"", "\\u0022;");
		s = s.replaceAll("\'", "\\u0022;");
		System.out.println(s);
	}
}
