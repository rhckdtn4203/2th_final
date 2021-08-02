package com.kh.khblind.company.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.khblind.company.entity.CompanyProfileDto;
import com.kh.khblind.company.entity.CompanyRegistDto;
import com.kh.khblind.company.entity.CompanyReviewDto;
import com.kh.khblind.company.repository.CompanyDao;
import com.kh.khblind.company.repository.CompanyProfileDao;
import com.kh.khblind.company.repository.CompanyReviewDao;
import com.kh.khblind.company.vo.CompanyVO;
import com.kh.khblind.member.entity.MemberDto;

@Controller
@RequestMapping("/company")
public class CompanyController {
	
	private final File ResDir = new File("D:/proj/khblind/resources/5.company-logo-image/");
	
	@Autowired
	private CompanyDao companyDao;
	
	@Autowired
	private CompanyReviewDao companyReviewDao;
	
	@Autowired
	private CompanyProfileDao profileDao;
	
	@GetMapping("/")
	public String company(Model model) {
		List<HashMap<String, Integer>> rateTopSix = companyDao.rateTopSix();
		
		model.addAttribute("topSixList", rateTopSix);
		
		return "company";
	}
	
	@PostMapping("/")
	public String company(@RequestParam String keyword, Model model) {
		List<HashMap<String, Integer>> search = companyDao.searchKeyword(keyword);
		List<HashMap<String, Integer>> rateTopSix = companyDao.rateTopSix();
		
		model.addAttribute("searchList", search);
		model.addAttribute("size", search.size());
		model.addAttribute("topSixList", rateTopSix);
		
		return "company";
	}

	@GetMapping("/registCompany")
	public String registCompany() {
		return "company/registCompany";
	}
	
	@PostMapping("/registCompany")
	public String registCompany(@ModelAttribute CompanyRegistDto companyRegistDto) {
		companyDao.registCompany(companyRegistDto);
		return "company/registCompany";
	}
	
	@RequestMapping("/companyProfile")
	public ResponseEntity<ByteArrayResource> companyProfile(int companyNo) throws IOException {
		CompanyProfileDto profileDto = profileDao.getCompanyNo(companyNo);
		
		if(profileDto == null)
			return ResponseEntity.notFound().build();

		File target = new File(ResDir, String.valueOf(profileDto.getCompanyNo()));
		byte[] data = FileUtils.readFileToByteArray(target);
		ByteArrayResource resource = new ByteArrayResource(data);
		
		return ResponseEntity.ok()
				.contentLength(profileDto.getCompanyProfileSize())
				.header(HttpHeaders.CONTENT_TYPE, profileDto.getCompanyProfileContentType())
				.header(HttpHeaders.CONTENT_ENCODING, "UTF-8")
				.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\""+URLEncoder.encode(profileDto.getCompanyProfileUploadName(), "UTF-8")+"\"")
				.body(resource);
	}
	
	@GetMapping("/companyDetail")
	public String companyDetail(int companyNo, Model model) {
		CompanyVO companyVO = companyDao.companyFind(companyNo);
		double reviewRate = companyReviewDao.companyReviewRate(companyNo);
		int reviewCount = companyReviewDao.companyReviewCount(companyNo);
		
		if(companyVO != null) {;
			model.addAttribute("companyVO", companyVO);
			model.addAttribute("reviewRate", reviewRate);
			model.addAttribute("reviewCount", reviewCount);
			return "company/companyDetail";
		}
		else {
			// 임시.. 404가 정상 나중에 Filter로 500 떴을 때 error 페이지 보여줌
			return "company/companyDetail/error";
		}
	}
	
	@GetMapping("/companyReview")
	public String companyReview(int companyNo, Model model) {
		CompanyVO companyVO = companyDao.companyFind(companyNo);
		double reviewRate = companyReviewDao.companyReviewRate(companyNo);
		int reviewCount = companyReviewDao.companyReviewCount(companyNo);
		
		model.addAttribute("list", companyReviewDao.companyReviewList(companyNo));
		model.addAttribute("reviewRate", reviewRate);
		model.addAttribute("reviewCount", reviewCount);

		List<HashMap<String, Integer>> reviewCountList = companyReviewDao.companyScoreCount(companyNo);
		System.out.println(reviewCountList);
		
		if(companyVO != null) {;
			model.addAttribute("companyVO", companyVO);
			model.addAttribute("reviewCountList", reviewCountList);
			return "company/companyReview";
		}
		else {
			// 임시.. 404가 정상 나중에 Filter로 500 떴을 때 error 페이지 보여줌
			return "company/companyReview/error";
		}
	}
	
	@GetMapping("/reviewWrite")
	public String reviewWrite(int companyNo, HttpSession session, Model model) {
		MemberDto memberDto = (MemberDto)session.getAttribute("dtoss");
		int memberNo = memberDto.getMemberNo();
		
		System.out.println(memberNo);
		
		Map<String, Object> map = new HashMap<>();
		map.put("memberNo", memberNo);
		map.put("companyNo", companyNo);

		if(memberNo != 0 && companyNo != 0) {
			model.addAttribute("map", map);
			model.addAttribute("category", companyDao.categories());
		}
		
		return "company/reviewWrite";
		
		// 로그인 상황 아닌 경우 처리 해야 함
	}
	
	@PostMapping("/reviewWrite")
	public String reviewWrite(@ModelAttribute CompanyReviewDto companyReviewDto) {
		companyReviewDao.reviewWrite(companyReviewDto);
		return "redirect:companyReview?companyNo="+companyReviewDto.getCompanyNo();
	}
	
	@GetMapping("/companyBoard")
	public String companyBoard(int companyNo, Model model) {
		CompanyVO companyVO = companyDao.companyFind(companyNo);
		double reviewRate = companyReviewDao.companyReviewRate(companyNo);
		int reviewCount = companyReviewDao.companyReviewCount(companyNo);
		
		if(companyVO != null) {;
			model.addAttribute("companyVO", companyVO);
			model.addAttribute("reviewRate", reviewRate);
			model.addAttribute("reviewCount", reviewCount);
			
			return "company/companyBoard";
		}
		else {
			// 임시.. 404가 정상 나중에 Filter로 500 떴을 때 error 페이지 보여줌
			return "company/companyBoard/error";
		}
	}

}
