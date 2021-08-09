package com.kh.khblind.board.uploadImage.repository;

import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.imageio.ImageIO;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
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
import com.kh.khblind.member.cert.entity.ImageCertDto;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class UploadImageDaoImpl implements UploadImageDao {

	@Autowired
	private SqlSession sqlSession;

	private final File ResDir = new File("D:/upload/kh7b");
	private final File RawDir = new File(ResDir + "/1.raw-image/");
	private final File SavedDir = new File(ResDir + "/4.saved-image/");
	
	private final File ImageCertDir = new File(ResDir + "/ImageCertDir/");

	@Override
	public List<String> uploadOriginalFile(List<MultipartFile> images, int memberNo) {

		List<String> fileNameList = new ArrayList<>();// 파일이름을 저장 할 저장소
		
		for (int i = 0; i < images.size(); i++) {
			String fileName = "(" + memberNo + "'s)" + images.get(i).getOriginalFilename();
			log.debug("업로드 파일 작업 대상 {}", fileName);
			File target = new File(RawDir, fileName);

			try {
				images.get(i).transferTo(target);// 파일을 업로드 한다
				fileNameList.add(fileName);// 나중에 쓸 이름을 저장한다.

			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
				log.error("업로드 실패 : 'IllegalStateException' or 'IOException'");
				return null;
			}
			log.debug("파일명 {}의 업로드 완료 (원본 : {})", fileName, images.get(i).getOriginalFilename());
		}
		return fileNameList;
	}

	@Override
	public List<Integer> getRotationValue(List<String> fileNameList) {

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
				log.error("ImageProcessingException" + "이미지 문제");
			} catch (IOException e) {
				log.error("IOException" + "파일 문제");
			} catch (NullPointerException e) {
				e.printStackTrace();
				log.debug("NullPointerException " + "오리엔테이션이 없음 기본값인 1을 부여");
				orientation = 1;
				rotationValueList.add(orientation);
			} catch (MetadataException e) {
				e.printStackTrace();
				log.debug("MetadataException " + "메타데이터오류");
			}
			rotationValueList.add(orientation);// 정상값
		}
		return rotationValueList;
	}

	@Override
	public String getImageFolderName(int no) {

		int k = 1000;
		int folderNo = 0;
		boolean reCalc = true;

		while (reCalc) {
			log.debug("{}하고 {}를 비교", no, folderNo);
			if (no <= k * folderNo) {
				reCalc = false;
			} else {
				folderNo++;
			}
		}
		log.debug("folderNo = " + folderNo);
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
				log.debug("{} 없어서 만듦", checkFolder );
				log.debug("폴더 생성 여부 {},  checkFolder.exists())");
			}
			else {
				log.debug("{} 폴더가 이미 있음", checkFolder );
			}
			
			// 1. 랜덤 파일이름 만들기 (겹치지 않을 때까지)
			boolean isSameName = true;
			String randomFileName = "";

			log.debug("최종 목적지 {}", finalFolderName);

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
					log.debug("만들어진 파일명 : {}", randomFileName);
				} else {
					log.debug("겹치는 파일 있음 {} - 따라서 반복", randomFileName);
				}
			}

			// 2. 이미지 리사이징 후 저장
			String imgFormat = "jpg";
			int setWidth = 1024;

			File inputFile = new File(RawDir, convertImageVo.getFileNameList().get(i));
			String outputFilePath = finalFolderName + "\\" + randomFileName + "-ready.jpg";
			log.debug("최종 파일 경로 존재 여부{}", outputFilePath);

			BufferedImage inputBufferdImage = ImageIO.read(inputFile);
			int originWidth = inputBufferdImage.getWidth(null);
			int originHeight = inputBufferdImage.getHeight(null);

			double ratio = (double) setWidth / (double) originWidth;
			log.debug("원본파일의 W,H {},{} 바율 {}", originWidth, originHeight, ratio);
			int newWidth = (int) (originWidth * ratio);
			int newHeight = (int) (originHeight * ratio);

			log.debug("변환된 {},{}", newWidth, newHeight);

			Image resizedImage = inputBufferdImage.getScaledInstance(newWidth, newHeight, Image.SCALE_AREA_AVERAGING);

			//-새 이미지 저장하기
			BufferedImage newImage = new BufferedImage(newWidth, newHeight, BufferedImage.TYPE_INT_RGB);
			Graphics g = newImage.getGraphics();
			g.drawImage(resizedImage, 0, 0, null);
			g.dispose();
			ImageIO.write(newImage, imgFormat, new File(outputFilePath));

			// 3. 이미지 회전해주기
			List<Integer> rotationValueList = convertImageVo.getRotationValueList();

			File inputFile2 = new File(finalFolderName, randomFileName + "-ready.jpg");
			BufferedImage finalImage = null;
			BufferedImage newImage2 = ImageIO.read(inputFile2);

			int orientation = rotationValueList.get(i);
			int radians = 0;
			if (orientation == 1) {
				finalImage = new BufferedImage(newImage2.getWidth(), newImage2.getHeight(), newImage2.getType());
				radians = 0;
			} else if (orientation == 6) {// 90
				finalImage = new BufferedImage(newImage2.getHeight(), newImage2.getWidth(), newImage2.getType());
				radians = 90;
			} else if (orientation == 3) {// 180
				finalImage = new BufferedImage(newImage2.getWidth(), newImage2.getHeight(), newImage2.getType());
				radians = 180;
			} else { // (orientation ==8) //270
				finalImage = new BufferedImage(newImage2.getHeight(), newImage2.getWidth(), newImage2.getType());
				radians = 270;
			}

			Graphics2D graphics2d = (Graphics2D) finalImage.getGraphics();
			graphics2d.rotate(Math.toRadians(radians), finalImage.getWidth() / 2, finalImage.getHeight() / 2);
			graphics2d.translate((finalImage.getWidth() - newImage2.getWidth()) / 2,
					(finalImage.getHeight() - newImage2.getHeight()) / 2);
			graphics2d.drawImage(newImage2, 0, 0, newImage2.getWidth(), newImage2.getHeight(), null);
			ImageIO.write(finalImage, "jpg", new File(finalFolderName, randomFileName + ".jpg"));
			
			readyFileNameList.add(randomFileName + "-ready.jpg");
			
			BoardImageDto boardImageDto = BoardImageDto.builder()
					.boardNo(convertImageVo.getBoardNo())
					.boardImageUrl(finalFolderName +"\\"+ randomFileName + ".jpg")
					.build();
			
			//경로 오입력을 방지하는 코드
			String target = boardImageDto.getBoardImageUrl();
			target= target.replace("\\\\", "\\");
			boardImageDto.setBoardImageUrl(target);
			
			//DB에 등록
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
				log.debug("삭제할 파일은 {} 존재하는가? {}", deleteOriginFile, deleteOriginFile.exists());
				deleteOriginFile.delete();
			}
			
			String finalFolderName = SavedDir + "\\" + convertImageVo.getSuperFolderName()  +"\\" + convertImageVo.getFolderName();
			
			//2. ready파일을 지웁니다.
			for(int i = 0; i<readyFileNameList.size(); i++) {
				File deleteReadyFile = new File(finalFolderName, readyFileNameList.get(i));
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
		log.debug("썸네일 재료 존재여부 {} ", inputFile);
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
	
	@Override
	public List<BoardImageDto> getBoardImageInfo (int boardNo){
		List<BoardImageDto> boardImageInfoList = sqlSession.selectList("upload-image.getmageInfoInBoard", boardNo);
		log.debug("이미지 리스트를 가져오는중 {}", boardImageInfoList);
		return boardImageInfoList;
	}
	
	
	@Override
	public List<ResponseEntity<ByteArrayResource>> getImageToJsp(int boardNo) throws IOException {
		List<ResponseEntity<ByteArrayResource>> imageFileList = new ArrayList<>();
		
		List<BoardImageDto> boardImageList =sqlSession.selectList("upload-image.getmageInfoInBoard", boardNo);
		for(int i =0; i<boardImageList.size(); i++) {
			
			File target = new File(boardImageList.get(i).getBoardImageUrl());
			byte[] data = FileUtils.readFileToByteArray(target);
			
			ByteArrayResource resource = new ByteArrayResource(data);
			
			ResponseEntity<ByteArrayResource> responseEntity = ResponseEntity.ok()
			.contentType(MediaType.APPLICATION_OCTET_STREAM)
			.contentLength(target.length())
			.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\""+URLEncoder.encode(target.getName(), "UTF-8")+"\"")
			.header(HttpHeaders.CONTENT_ENCODING, "UTF-8")
			.body(resource);
			imageFileList.add(responseEntity);
		}
		
		return imageFileList;
	}

	@Override
	public boolean deleteImageChainToBoard(int boardNo) {
		String folderName = getImageFolderName(boardNo);
		log.debug("{}를 삭제 합니다.", folderName);
		
		String fullPath = SavedDir +"\\" + folderName + "\\" + boardNo;
		
		File targetFolder = new File(fullPath);
		File[] allFiles = targetFolder.listFiles();
		if (allFiles != null) {
            for (File targetFile : allFiles) {
            	targetFile.delete();
            }
        }
		targetFolder.delete();
	
		return false;
	}

	@Override
	public String uploadImageCert(int memberNo, MultipartFile image) {
		String superFolderName = getImageFolderName(memberNo);
		String memberNoFolder = String.valueOf(memberNo);
		String finalFolderName= ImageCertDir+"\\"+superFolderName+"\\"+memberNoFolder;
		
		File targetFolder = new File(finalFolderName);
		targetFolder.mkdirs();
		
		File targetFile = new File (finalFolderName, "certImage");
		
		try {
			image.transferTo(targetFile);// 파일을 업로드 한다
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
			log.error("업로드 실패 : 'IllegalStateException' or 'IOException'");
			return null;
		}
		
		//업로드를 성공하면 후에 DB에 저장할 정보를 모은다.
		String imageUrl = finalFolderName+"\\"+"certImage";
		
		return imageUrl;
	}

	@Override
	public boolean insertToDBAfterUpload(ImageCertDto imageCertDto) {
		int count = sqlSession.insert("cert.insertImageCert", imageCertDto);
		return count >0;
	}
	
	@Override
	public ResponseEntity<ByteArrayResource> getImageToImageCertJsp(int memberNo) throws IOException {
		String superFolderName = getImageFolderName(memberNo);
		String memberNoFolder = String.valueOf(memberNo);
		String finalFolderName= ImageCertDir+"\\"+superFolderName+"\\"+memberNoFolder;
		
		File targetFile = new File (finalFolderName, "certImage");
		log.debug("{} 파일은 존재 여부 {}", targetFile, targetFile.exists());
		
		byte[] data = FileUtils.readFileToByteArray(targetFile);
		
		ByteArrayResource resource = new ByteArrayResource(data);
		
		return ResponseEntity.ok()
				.contentType(MediaType.APPLICATION_OCTET_STREAM)
				.contentLength(targetFile.length())
				.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\""+URLEncoder.encode(targetFile.getName(), "UTF-8")+"\"")
				.header(HttpHeaders.CONTENT_ENCODING, "UTF-8")
				.body(resource);
		
	}

	@Override
	public String getImageCertInfo(int memberNo) {
		String imageUrl = sqlSession.selectOne("cert.getImageCertInfo", memberNo);
		return imageUrl;
	}

	@Override
	public void deleteImageChainToImageCert(int memberNo) {
		String superFolderName = getImageFolderName(memberNo);
		String memberNoFolder = String.valueOf(memberNo);
		String finalFolderName= ImageCertDir+"\\"+superFolderName+"\\"+memberNoFolder;
		
		File targetFolder = new File(finalFolderName);
		targetFolder.delete();
		
	}

	@Override
	public boolean insertToDBAfterUploadAgain(int memberNo) {
		int count = sqlSession.insert("cert.insertImageCertAgain", memberNo);
		return count >0;
	}
	
	
	
} 