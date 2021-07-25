package com.kh.khblind.board.uploadImage;

import org.junit.Test;

public class Test04_folderCounter2 {
	
	@Test
	public void test1() {
		int tempBoardNo = 2000;
		int k = 1000;
		int i = 0;
		boolean calc = true;
		while(calc) {
			System.out.println(tempBoardNo + "하고" + k*i +"를 비교");
			if(tempBoardNo<=k*i) {
				calc = false;
			}else {
			i++;
			System.out.println("현재 i 는 " + i);
			}
		}
		int folderNo = i;
		System.out.println("folderNo = " + folderNo);
		
	}
}
