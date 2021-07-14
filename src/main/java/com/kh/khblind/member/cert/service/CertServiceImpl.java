package com.kh.khblind.member.cert.service;

import java.io.File;
import java.io.IOException;
import java.util.Scanner;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.khblind.member.cert.entity.CertDto;
import com.kh.khblind.member.cert.repository.CertDao;

@Service
public class CertServiceImpl implements CertService {
	
	@Autowired
	private JavaMailSender sender;
	
	@Autowired
	private CertDao certDao;
	
	@Autowired
	private RandomService randomService;

	// 인증번호 발송 기능
	@Override
	@Transactional
	public void sendCertification(String email) throws MessagingException, IOException {
		//번호 생성
		String no = randomService.generateCertification(6);

		//이메일 발송
		MimeMessage message = sender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message, false, "UTF-8");
		
		helper.setTo(email);
		helper.setSubject("[khblind] 인증번호 발송 메일");
		
		ClassPathResource resource = new ClassPathResource("email/template.html");
		File file = resource.getFile();
		
		StringBuffer buffer = new StringBuffer();
		
		Scanner sc = new Scanner(file);
		while(sc.hasNextLine()) {
			String line = sc.nextLine();
			
			//line = line.replace("{{nickname}}", memberDto.getMemberNick());
			line = line.replace("{{certNo}}", no);
			
			buffer.append(line);
		}
		sc.close();
		
		helper.setText(buffer.toString(), true);
		
		//데이터베이스 등록
		certDao.insert(CertDto.builder()
				.email(email)
				.emailCertNo(no)
				.build());
		
		sender.send(message);
	}

	// 인증번호 검사 기능
	@Override
	public boolean checkCertification(CertDto certDto) {
		boolean result = certDao.check(certDto);
		if(result) {
			certDao.deleteByEmail(certDto.getEmail());
		}
		return result;
	}

	// 인증 시간이 지난 인증 데이터 삭제 기능(스케줄러)
	// 스케줄러를 이용한 지속적인 삭제 (매 정각마다 삭제)
	@Scheduled(cron = "0 0 * * * *")
	@Override
	public void clearCertification() {
		certDao.clear();
	}

}
