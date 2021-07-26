package com.kh.khblind.board.uploadImage;

import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

import org.junit.Test;


public class Test01_ImageResize {

	@Test
	public void test() {
        String inputImagePath = "D:\\sample\\0001.jpg";
        String outputImagePath = "D:\\sample\\0001-resized.jpg";
    
    try {
        // resize to a fixed width (not proportional)
        int setWidth = 1024;
        Test00_ImageResizer.resize(inputImagePath, outputImagePath, setWidth);
    } catch (IOException ex) {
        System.out.println("Error resizing the image.");
        ex.printStackTrace();
    }

	}
}
