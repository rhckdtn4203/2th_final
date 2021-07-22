package com.kh.khblind.board.uploadImage;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

import org.junit.Test;

public class Test05_ImageRotation {
	@Test
	public void test1() throws IOException {
	File inputFile2 = new File("D:/proj/khblind/resources/1.raw-image/(2's)20210624_175217.jpg");
	
	BufferedImage finalImage = null;
	BufferedImage newImage2 = ImageIO.read(inputFile2);
	
	int orientation = 6;
	int radians = 0;
	
    if(orientation==1) {
    	//아무것도
    } else if(orientation ==6) {//90
    	finalImage = new BufferedImage(newImage2.getHeight(), newImage2.getWidth(), newImage2.getType());
    	radians = 90;
    } else if(orientation ==3) {//180
    	finalImage = new BufferedImage(newImage2.getWidth(), newImage2.getHeight(), newImage2.getType());
    	radians = 180;
    } else { //(orientation ==8) {//270
    	finalImage = new BufferedImage(newImage2.getHeight(), newImage2.getWidth(), newImage2.getType());
    	radians = 270;
    }

    
    Graphics2D graphics2d = (Graphics2D) finalImage.getGraphics();
    graphics2d.rotate(Math.toRadians(radians), finalImage.getWidth() / 2, finalImage.getHeight() / 2);
    System.out.println(radians + "||" + finalImage.getWidth() + "||" + finalImage.getHeight());
    graphics2d.translate((finalImage.getWidth() - newImage2.getWidth()) /2, (finalImage.getHeight() - newImage2.getHeight())/2);
    graphics2d.drawImage(newImage2, 0, 0, newImage2.getWidth(), newImage2.getHeight(), null);
   
    
	ImageIO.write(finalImage, "jpg", new File("D:\\proj\\khblind\\resources\\123.jpg"));
	}
	


	
}

