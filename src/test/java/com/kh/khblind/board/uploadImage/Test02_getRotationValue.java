package com.kh.khblind.board.uploadImage;

import java.io.File;
import java.io.IOException;
import java.util.Collection;

import org.junit.Test;

import com.drew.imaging.ImageMetadataReader;
import com.drew.imaging.ImageProcessingException;
import com.drew.metadata.Directory;
import com.drew.metadata.Metadata;
import com.drew.metadata.MetadataException;
import com.drew.metadata.exif.ExifIFD0Directory;

public class Test02_getRotationValue {
	@Test
	public void test() throws MetadataException {
		 int orientation = 1;
		
		File file = new File("D:\\sample\\0001-resized.jpg");
		System.out.println("파일은 존재하는가? " +file.exists());
		try {
			Metadata metadata = ImageMetadataReader.readMetadata(file);
			Directory directory = metadata.getFirstDirectoryOfType(ExifIFD0Directory.class);
			System.out.println("directory" + directory);
			orientation = directory.getInt(ExifIFD0Directory.TAG_ORIENTATION);
			System.out.println(orientation);
			
		} catch (ImageProcessingException e) {
			e.printStackTrace();
			System.out.println("ImageProcessingException" + "이미지 문제");
		} catch (IOException e) {
			System.out.println("IOException" + "파일 문제");
		} catch (NullPointerException e) {
			e.printStackTrace();
			System.out.println("NullPointerException " + "오리엔테이션이 없다.");
			orientation = 0;
		}
	}
}
