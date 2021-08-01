package com.kh.khblind.member.cert.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.kh.khblind.admin.category.entity.CategoryDto;
import com.kh.khblind.admin.category.repository.CategoryDao;
import com.kh.khblind.board.uploadImage.repository.UploadImageDao;
import com.kh.khblind.member.cert.entity.ImageCertDto;
import com.kh.khblind.member.cert.repository.CertDao;
import com.kh.khblind.member.entity.MemberDto;

//나중에 1에 합칠거에요!(석현)
@Controller
@RequestMapping("/cert")
public class ImageCertController {
	
	@Autowired
	private UploadImageDao uploadImageDao;
	
	@Autowired
	private CertDao certDao;
	
	@GetMapping("/imageInsert")
	public String imageInsert(HttpSession session, Model model) {
		//만약 인터셉터가 있다면 아래 구문은 지울겁니당.
		MemberDto memberDto = (MemberDto) session.getAttribute("dtoss");
		if(memberDto==null) {
			return "member/login"; //로그인페이지
		}
		int memberNo = memberDto.getMemberNo();
		String imageCertProgress = certDao.checkImageCertProgress(memberNo);
		System.out.println("[컨]" + memberNo +"|||" + imageCertProgress);
		if(imageCertProgress.equals("didnt")) {
			model.addAttribute("imageCertProgress", "didnt");
		} else if (imageCertProgress.equals("ing")) {
			model.addAttribute("imageCertProgress", "ing"); //진행중 
		} else if (imageCertProgress.equals("end")) {
			model.addAttribute("imageCertProgress", "end");	//인증완료
		} else if (imageCertProgress.equals("reject")) {
			model.addAttribute("imageCertProgress", "reject");//에러!
		} 
		
		String imageCertMessage = certDao.getImageCertMessage(memberNo);
		
		model.addAttribute("imageCertMessage", imageCertMessage);//에러!
		//회원이 선택할 카테고리 목록을 가져온다. 메소드가 없다...(취소)
		
		return "cert/imageInsert";
	}
	
	@PostMapping("/imageInsert")
	public String imageInsert(HttpSession session, MultipartFile imageCertFile, ImageCertDto imageCertDto) {
		MemberDto memberDto = (MemberDto) session.getAttribute("dtoss");
		//만약 인터셉터가 있다면 아래 구문은 지울겁니당.
		if(memberDto==null) {
			return "member/login"; //로그인페이지
		}
		int memberNo = memberDto.getMemberNo(); 
		
		//이미지 업로드
		String imageUrl = uploadImageDao.uploadImageCert(memberNo, imageCertFile);
		
		//DB에 정보 추가
		ImageCertDto imageCertDtoToDB = ImageCertDto.builder()
													.memberNo(memberNo)
													.jobCategoryNo(imageCertDto.getJobCategoryNo())
													.imageCertUrl(imageUrl)
													.imageCertProgress("ing")//didnt ->ing -> end ->error
													.build();
		
		boolean insertToDBAfterUploadSuccess = uploadImageDao.insertToDBAfterUpload(imageCertDtoToDB);
		if(!insertToDBAfterUploadSuccess) {return "삭제";}
		return "redirect:imageInsert";
	}
	
	@PostMapping("/imageInsertAgain")
	public String imageInsertAgain(HttpSession session, MultipartFile imageCertFile, ImageCertDto imageCertDto){
		MemberDto memberDto = (MemberDto) session.getAttribute("dtoss");
		//만약 인터셉터가 있다면 아래 구문은 지울겁니당.
		if(memberDto==null) {
			return "member/login"; //로그인페이지
		}
		int memberNo = memberDto.getMemberNo(); 
		
		//이미지 업로드(덮어쓰기 됨)
		String imageUrl = uploadImageDao.uploadImageCert(memberNo, imageCertFile);
		
		//DB정보 수정
		boolean insertToDBAfterUploadSuccess = uploadImageDao.insertToDBAfterUploadAgain(memberNo);
		if(!insertToDBAfterUploadSuccess) {return "삭제";}
		return "redirect:imageInsert";

	}
	
}
