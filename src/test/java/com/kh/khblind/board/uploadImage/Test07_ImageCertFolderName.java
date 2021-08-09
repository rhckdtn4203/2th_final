package com.kh.khblind.board.uploadImage;

import java.io.File;

import org.junit.Test;

public class Test07_ImageCertFolderName {

	private final File ResDir = new File("D:/upload/kh7b");
	private final File RawDir = new File(ResDir + "/1.raw-image/");
	private final File SavedDir = new File(ResDir + "/4.saved-image/");
	
	private final File ImageCertDir = new File(ResDir + "/ImageCertDir/");
	
	public String getImageFolderName(int no) {

		int k = 1000;
		int folderNo = 0;
		boolean reCalc = true;

		while (reCalc) {
			System.out.println(no + "하고" + k * folderNo + "를 비교");
			if (no <= k * folderNo) {
				reCalc = false;
			} else {
				folderNo++;
			}
		}
		System.out.println("folderNo = " + folderNo);
		return Integer.toString(folderNo);
	}
	
	@Test
	public void test01() {
		int memberNo = 50;
		
		String superFolderName = getImageFolderName(memberNo);
		String memberNoFolder = String.valueOf(memberNo);
		String finalFolderName= ImageCertDir+"\\"+superFolderName+"\\"+memberNoFolder;
		
		File targetFolder = new File(finalFolderName);
		targetFolder.mkdirs();
	}
}
