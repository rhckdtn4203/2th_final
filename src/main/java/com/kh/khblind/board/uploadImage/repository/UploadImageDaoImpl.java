package com.kh.khblind.board.uploadImage.repository;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.geom.AffineTransform;
import java.awt.image.AffineTransformOp;
import java.awt.image.BufferedImage;
import java.awt.image.RenderedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.imageio.ImageIO;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.drew.imaging.ImageMetadataReader;
import com.drew.imaging.ImageProcessingException;
import com.drew.metadata.Directory;
import com.drew.metadata.Metadata;
import com.drew.metadata.MetadataException;
import com.drew.metadata.exif.ExifIFD0Directory;
import com.kh.khblind.board.uploadImage.entity.BoardImageDto;
import com.kh.khblind.board.uploadImage.vo.ConvertImageVo;

//import com.drew.imaging.ImageMetadataReader;
//import com.drew.metadata.Metadata;

@Repository
public class UploadImageDaoImpl implements UploadImageDao {

	@Autowired
	private SqlSession sqlSession;

	private final File ResDir = new File("D:/proj/khblind/resources/");
	private final File RawDir = new File(ResDir + "/1.raw-image/");
	private final File SavedDir = new File(ResDir + "/4.saved-image/");

	@Override
	public List<String> uploadOriginalFile(List<MultipartFile> images, int memberNo) {

		List<String> fileNameList = new ArrayList<>();// 파일이름을 저장 할 저장소
		
		for (int i = 0; i < images.size(); i++) {
			String fileName = "(" + memberNo + "'s)" + images.get(i).getOriginalFilename();
			System.out.println(fileName + "- 작업합니다.");
			File target = new File(RawDir, fileName);

			try {
				images.get(i).transferTo(target);// 파일을 업로드 한다
				fileNameList.add(fileName);// 나중에 쓸 이름을 저장한다.

			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
				System.out.println("업로드 실패 : 'IllegalStateException' or 'IOException'");
				return null;
			}
			System.out.println(fileName + "- 업로드 완료(원본:" + images.get(i).getOriginalFilename() + ")");
		}
		return fileNameList;
	}

	@Override
	public List<Integer> getRotationValue(List<String> fileNameList) {

//		File s = new File(resDir + "/1.raw-image/");
		List<Integer> rotationValueList = new ArrayList<>();

		for (int i = 0; i < fileNameList.size(); i++) {
			int orientation = 0;
			String fileName = fileNameList.get(i);
			File target = new File(RawDir, fileName);

			try {
				Metadata metadata = ImageMetadataReader.readMetadata(target);
				Directory directory = metadata.getFirstDirectoryOfType(ExifIFD0Directory.class);
				if (directory != null) {
					orientation = directory.getInt(ExifIFD0Directory.TAG_ORIENTATION);
				}
			} catch (ImageProcessingException e) {
				e.printStackTrace();
				System.out.println("ImageProcessingException" + "이미지 문제");
			} catch (IOException e) {
				System.out.println("IOException" + "파일 문제");
			} catch (NullPointerException e) {
				e.printStackTrace();
				System.out.println("NullPointerException " + "오리엔테이션이 없다.");
				orientation = 1;
				rotationValueList.add(orientation);// 없으니 1을 넣는다.
			} catch (MetadataException e) {
				e.printStackTrace();
				System.out.println("MetadataException " + "메타데이터오류... 이건 언제 일어날까");
			}
			rotationValueList.add(orientation);// 이건 정상값
		}
		return rotationValueList;
	}

	@Override
	public String getImageFolderName(int boardNo) {

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
		System.out.println("folderNo = " + folderNo);
		return Integer.toString(folderNo);
	}

	@Override
	public List<String> convertImage(ConvertImageVo convertImageVo) throws IOException {
		 List<String> readyFileNameList = new ArrayList<>();
		
		for (int i = 0; i < convertImageVo.getFileNameList().size(); i++) {
			
			String finalFolderName = SavedDir + "\\" + convertImageVo.getSuperFolderName()  +"\\" + convertImageVo.getFolderName() +"\\";
			File checkFolder = new File(finalFolderName);
			if(!checkFolder.exists()) {
				checkFolder.mkdirs();
				System.out.println("없어서 만듦" + checkFolder);
				System.out.println("그래서 있어?" + checkFolder.exists());
			}
			else {
				System.out.println("있어서 안 만들어!" + checkFolder);
			}
			
			// 1. 랜덤 파일이름 만들기 (겹치지 않을 때까지)
			boolean isSameName = true;
			String randomFileName = "";

			System.out.println("최종 목적지" + finalFolderName);

			while (isSameName) {
				int start = 97; // a
				int end = 122; // z
				int length = 10;
				Random random = new Random();
				randomFileName = random.ints(start, end + 1).limit(length)
						.collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append).toString();

				File sameNameFile = new File(finalFolderName, randomFileName + ".jpg");
				if (!sameNameFile.exists()) {
					isSameName = false;
					System.out.println("만들어진 파일명 : " + randomFileName);
				} else {
					System.out.println("겹치는 파일 있음 (" + randomFileName + ") 반복");
				}
			}

			// 2. 이미지 리사이징 후 저장
			String imgFormat = "jpg";
			int setWidth = 1024;

			File inputFile = new File(RawDir, convertImageVo.getFileNameList().get(i));
//			File outputFile = new File(finalFolderName, randomFileName);
			String outputFilePath = finalFolderName + "\\" + randomFileName + "-ready.jpg";
			System.out.println("최종 파일 경로 가 있나요? " + outputFilePath);
//			String outputPath2 = outputFile.getPath();

//			System.out.println("outputPath" + outputPath);
//			System.out.println("outputPath2" + outputPath2);

			BufferedImage inputBufferdImage = ImageIO.read(inputFile);
			int originWidth = inputBufferdImage.getWidth(null);
			int originHeight = inputBufferdImage.getHeight(null);

			System.out.println(originWidth + " !! " + originHeight);
			double ratio = (double) setWidth / (double) originWidth;
			System.out.println(ratio);
			int newWidth = (int) (originWidth * ratio);
			int newHeight = (int) (originHeight * ratio);

			System.out.println(newWidth + "|" + newHeight);

			Image resizedImage = inputBufferdImage.getScaledInstance(newWidth, newHeight, Image.SCALE_AREA_AVERAGING);

			//-새 이미지 저장하기
			BufferedImage newImage = new BufferedImage(newWidth, newHeight, BufferedImage.TYPE_INT_RGB);
			Graphics g = newImage.getGraphics();
			g.drawImage(resizedImage, 0, 0, null);
			g.dispose();
			System.out.println(200);
			ImageIO.write(newImage, imgFormat, new File(outputFilePath));

			// 3. 이미지 회전해주기
			List<Integer> rotationValueList = convertImageVo.getRotationValueList();

			File inputFile2 = new File(finalFolderName, randomFileName + "-ready.jpg");
			BufferedImage finalImage = null;
			System.out.println(204);
			BufferedImage newImage2 = ImageIO.read(inputFile2);

			int orientation = rotationValueList.get(i);
			int radians = 0;
			System.out.println(208);
			if (orientation == 1) {
				finalImage = new BufferedImage(newImage2.getWidth(), newImage2.getHeight(), newImage2.getType());
				radians = 0;
				System.out.println("아무것도");// 아무것도
			} else if (orientation == 6) {// 90
				finalImage = new BufferedImage(newImage2.getHeight(), newImage2.getWidth(), newImage2.getType());
				radians = 90;
				System.out.println("6-90");
			} else if (orientation == 3) {// 180
				finalImage = new BufferedImage(newImage2.getWidth(), newImage2.getHeight(), newImage2.getType());
				radians = 180;
				System.out.println("3-180");
			} else { // (orientation ==8) //270
				finalImage = new BufferedImage(newImage2.getHeight(), newImage2.getWidth(), newImage2.getType());
				radians = 270;
				System.out.println("8-270");
			}

			Graphics2D graphics2d = (Graphics2D) finalImage.getGraphics();
			graphics2d.rotate(Math.toRadians(radians), finalImage.getWidth() / 2, finalImage.getHeight() / 2);
			System.out.println(radians + "||" + finalImage.getWidth() + "||" + finalImage.getHeight());
			graphics2d.translate((finalImage.getWidth() - newImage2.getWidth()) / 2,
					(finalImage.getHeight() - newImage2.getHeight()) / 2);
			graphics2d.drawImage(newImage2, 0, 0, newImage2.getWidth(), newImage2.getHeight(), null);
			System.out.println("여기는 온다");
			ImageIO.write(finalImage, "jpg", new File(finalFolderName, randomFileName + ".jpg"));
			
			readyFileNameList.add(randomFileName + "-ready.jpg");
			System.out.println("끝");
			
			BoardImageDto boardImageDto = BoardImageDto.builder()
					.boardNo(convertImageVo.getBoardNo())
					.boardImageUrl(finalFolderName +"/"+ randomFileName + ".jpg")
					.build();
			sqlSession.insert("upload-image.insert", boardImageDto);
		}
		return readyFileNameList;
	}

	@Override
	public boolean deleteOrigin(ConvertImageVo convertImageVo, List<String> readyFileNameList) {
		
		try {
			//1. raw파일부터 지웁니다.
			for(int i = 0; i<convertImageVo.getFileNameList().size(); i++) {
				File deleteOriginFile = new File(RawDir, convertImageVo.getFileNameList().get(i));
				System.out.println("삭제할 파일은 " +deleteOriginFile+"존재하는가? " + deleteOriginFile.exists());
				deleteOriginFile.delete();
			}
			
			String finalFolderName = SavedDir + "\\" + convertImageVo.getSuperFolderName()  +"\\" + convertImageVo.getFolderName();
			
			//2. ready파일을 지웁니다.
			for(int i = 0; i<readyFileNameList.size(); i++) {
				File deleteReadyFile = new File(finalFolderName, readyFileNameList.get(i));
				System.out.println("삭제할 파일은 " +deleteReadyFile+"존재하는가? " + deleteReadyFile.exists());
				deleteReadyFile.delete();
			}
		} catch (Exception e) {
			return false;		
		}
		return true;		
	}

	@Override
	public boolean makeThumb(ConvertImageVo convertImageVo, String firstFileFinalName) throws IOException {
		String finalFolderName = SavedDir + "\\" + convertImageVo.getSuperFolderName()  +"\\" + convertImageVo.getFolderName();
		
		File inputFile = new File(finalFolderName, firstFileFinalName);
		File outputFile = new File(finalFolderName, "thumb.jpg");
		System.out.println("썸네일 재료가 있니? " + inputFile);
		BufferedImage inputBufferdImage = ImageIO.read(inputFile);

		Image resizedImage = inputBufferdImage.getScaledInstance(120, 120, Image.SCALE_AREA_AVERAGING);

		//-새 이미지 저장하기
		BufferedImage newImage = new BufferedImage(120, 120, BufferedImage.TYPE_INT_RGB);
		Graphics g = newImage.getGraphics();
		g.drawImage(resizedImage, 0, 0, null);
		g.dispose();

		ImageIO.write(newImage, "jpg", outputFile);
		
		return false;
	}

} 