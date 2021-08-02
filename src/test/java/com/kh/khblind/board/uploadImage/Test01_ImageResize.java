package com.kh.khblind.board.uploadImage;

import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

import org.junit.Test;


public class Test01_ImageResize {

	private final String root = "D:\\bamboo";
	
	@Test
	public void test() {
        String inputImagePath = root+"\\image-resized\\01.before.jpg";
        String outputImagePath = root+"\\image-resized\\02.after.jpg";
    
    try {
        // resize to a fixed width (not proportional)
        int setWidth = 1024;
        Test00_ImageResizer.resize(inputImagePath, outputImagePath, setWidth);
    } catch (IOException ex) {
        System.out.println("에러에러!");
        ex.printStackTrace();
    }

	}
}
