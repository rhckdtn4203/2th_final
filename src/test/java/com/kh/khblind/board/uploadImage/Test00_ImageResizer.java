package com.kh.khblind.board.uploadImage;

import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

public class Test00_ImageResizer {

	
    public static void resize(String inputImagePath, String outputImagePath, int setWidth)
            throws IOException {
    	
    	String imgFormat = "jpg"; 
    	
        // reads input image
        File inputFile = new File(inputImagePath);
        BufferedImage inputImage = ImageIO.read(inputFile);
        
        int originWidth = inputImage.getWidth(null);
        int originHeight = inputImage.getHeight(null);
        System.out.println(originWidth + " !! " + originHeight);
        double ratio = (double)setWidth/(double)originWidth;
        System.out.println(ratio);
        int newWidth = (int)(originWidth * ratio);
        int newHeight = (int)(originHeight * ratio);
        
        System.out.println(newWidth + "|" + newHeight);
        
        Image resizeImage = inputImage.getScaledInstance(newWidth, newHeight, Image.SCALE_SMOOTH);
        
        // 새 이미지  저장하기
        BufferedImage newImage = new BufferedImage(newWidth, newHeight, BufferedImage.TYPE_INT_RGB);
        Graphics g = newImage.getGraphics();
        g.drawImage(resizeImage, 0, 0, null);
        g.dispose();
        ImageIO.write(newImage, imgFormat, new File(outputImagePath));
    }
	
}
