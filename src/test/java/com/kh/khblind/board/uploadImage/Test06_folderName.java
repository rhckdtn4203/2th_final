package com.kh.khblind.board.uploadImage;

import java.io.File;

import org.junit.Test;

public class Test06_folderName {
	
	private final File ResDir = new File("D:/upload/kh7b");
	private final File RawDir = new File(ResDir + "/1.raw-image/");
	private final File SavedDir = new File(ResDir + "/4.saved-image/");
	
	@Test
	public void test01() {
		
		int boardNo = 127;
		
		int k = 1000;
		int folderNo = 0;
		boolean reCalc = true;

		while (reCalc) {
			System.out.println(boardNo + "하고" + k * folderNo + "를 비교");
			if (boardNo <= k * folderNo) {
				reCalc = false;
			} else {
				folderNo++;
			}
		}
		String fullPath = SavedDir +"\\" + folderNo + "\\" + boardNo;
		
		File targetFolder = new File(fullPath);
		File[] allFiles = targetFolder.listFiles();
		if (allFiles != null) {
            for (File targetFile : allFiles) {
            	targetFile.delete();
            }
        }
		targetFolder.delete();
	}

}
