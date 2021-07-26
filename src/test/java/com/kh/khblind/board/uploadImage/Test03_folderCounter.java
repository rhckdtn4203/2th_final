package com.kh.khblind.board.uploadImage;

import java.io.File;

import org.junit.Test;

public class Test03_folderCounter {
	
	private final File resDir = new File("D:/proj/khblind/resources");
	
	@Test
	public void test1() {
		
		File dir = new File(resDir + "/4.saved-image/");
		
		String[] folderCounter = dir.list();
		System.out.println(folderCounter.length  + "개의 폴더가 있음");
		
		String targetDirName = Integer.toString(folderCounter.length);
		File targetDir = new File(dir+"/"+targetDirName); 
		
		String[] fileCounter = targetDir.list();
		System.out.println(fileCounter.length  + "개의 파일이 있음");
		
		String saveFolderNo = "0";
		
		if(fileCounter.length>10) { //초과하면
			saveFolderNo = Integer.toString(fileCounter.length+1);
		}
		else {
			saveFolderNo = Integer.toString(fileCounter.length);
		}
		
		File saveDir = new File(dir+"/"+saveFolderNo);
		
		System.out.println("최종 경로는~" + saveDir);
	}
}
