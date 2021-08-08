package com.kh.khblind.company.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

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

import com.kh.khblind.board.entity.BoardCategoryBoardDto;
import com.kh.khblind.board.repository.BoardDao;
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
	
	private final File ResDir = new File("D:/upload/kh7b/resources/5.company-logo-image/");
	
	@Autowired
	private CompanyDao companyDao;
	
	@Autowired
	private CompanyReviewDao companyReviewDao;
	
	@Autowired
	private CompanyProfileDao profileDao;
	
	@Autowired
	private BoardDao boardDao;
	
	@GetMapping("/")
	public String company(Model model) {
		List<HashMap<String, String>> rateTopSix = companyDao.rateTopSix();
		
		for(int i = 0; i < rateTopSix.size(); i++) {
			for(Entry<String, String> elem : rateTopSix.get(i).entrySet()){
	            if(elem.getKey().equals("RATE_AVG")) {
	            	DecimalFormat form = new DecimalFormat("#.##");
	            	elem.setValue(form.format(elem.getValue()));
	            }
	        }
		}
		
		model.addAttribute("topSixList", rateTopSix);
		
		return "company";
	}
	
	@PostMapping("/")
	public String company(@RequestParam String keyword, Model model) {
		List<HashMap<String, String>> search = companyDao.searchKeyword(keyword);
		List<HashMap<String, String>> rateTopSix = companyDao.rateTopSix();
		
		for(int i = 0; i < search.size(); i++) {
			for(Entry<String, String> elem : search.get(i).entrySet()){
				if(elem.getKey().equals("RATE_AVG")) {
	            	DecimalFormat form = new DecimalFormat("#.##");
	            	elem.setValue(form.format(elem.getValue()));
	            	System.out.println(elem.getValue());
	            }
	        }
		}
		
		for(int i = 0; i < rateTopSix.size(); i++) {
			for(Entry<String, String> elem : rateTopSix.get(i).entrySet()){
				if(elem.getKey().equals("RATE_AVG")) {
	            	DecimalFormat form = new DecimalFormat("#.##");
	            	elem.setValue(form.format(elem.getValue()));
	            	System.out.println(elem.getValue());
	            }
	        }
		}
		
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
		Double reviewRate = companyReviewDao.companyReviewRate(companyNo);
		
		if(companyVO != null && reviewRate != null) {;
			DecimalFormat form = new DecimalFormat("#.##");
			int reviewCount = companyReviewDao.companyReviewCount(companyNo);
		
			model.addAttribute("companyVO", companyVO);
			model.addAttribute("reviewRate", form.format(reviewRate));
			model.addAttribute("reviewCount", reviewCount);
			return "company/companyDetail";
		}
		else if(reviewRate == null) {
			model.addAttribute("companyVO", companyVO);
			model.addAttribute("reviewRate", 0.0);
			model.addAttribute("reviewCount", 0);
			return "company/companyDetail";
		}
		else {
			// 임시.. 404가 정상 나중에 Filter로 500 떴을 때 error 페이지 보여줌
			return "company/companyDetail/error";
		}
	}
	
	@GetMapping("/companyReview")
	public String companyReview(int companyNo, HttpSession session, Model model) {
		MemberDto memberDto = (MemberDto)session.getAttribute("dtoss");
		int memberGrade = memberDto.getGradeNo();
		Double reviewRate = companyReviewDao.companyReviewRate(companyNo);
		CompanyVO companyVO = companyDao.companyFind(companyNo);
		
		model.addAttribute("grade", memberGrade);

		List<HashMap<String, String>> reviewCountList = companyReviewDao.companyScoreCount(companyNo);
		System.out.println(reviewCountList);
		
		if(companyVO != null && reviewRate != null) {
			DecimalFormat form = new DecimalFormat("#.##");
			int reviewCount = companyReviewDao.companyReviewCount(companyNo);
			
			model.addAttribute("companyVO", companyVO);
			model.addAttribute("reviewCountList", reviewCountList);
			model.addAttribute("reviewRate", form.format(reviewRate));
			model.addAttribute("reviewCount", reviewCount);
			model.addAttribute("list", companyReviewDao.companyReviewList(companyNo));
			
			return "company/companyReview";
		}
		else if(reviewRate == null) {
			model.addAttribute("companyVO", companyVO);
			model.addAttribute("reviewCountList", reviewCountList);
			model.addAttribute("reviewRate", 0.0);
			model.addAttribute("reviewCount", 0);
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
		Double reviewRate = companyReviewDao.companyReviewRate(companyNo);
		DecimalFormat form = new DecimalFormat("#.##");
		int reviewCount = companyReviewDao.companyReviewCount(companyNo);
		
		if(companyVO != null && reviewRate != null) {;
			model.addAttribute("companyVO", companyVO);
			model.addAttribute("reviewRate", form.format(reviewRate));
			model.addAttribute("reviewCount", reviewCount);
			
			//기업키워드 리스트 추가
			String keyword = companyVO.getCompanyName();
			System.out.println("keyword@@@@@" + keyword);
			
			List<BoardCategoryBoardDto> companyKeywordList = boardDao.getCompanyKeywordList(keyword);
			
			for(int i =0; i<companyKeywordList.size(); i++) {
				String target = companyKeywordList.get(i).getBoardContent();
				if(target.length() > 25) {
					target = target.substring(0, 25) + "...";
				}
				
				companyKeywordList.get(i).setBoardContent(target);
			}
			
			model.addAttribute("companyKeywordList", companyKeywordList);
			
			return "company/companyBoard";
		}
		else if(reviewRate == null) {
			model.addAttribute("companyVO", companyVO);
			model.addAttribute("reviewRate", 0.0);
			model.addAttribute("reviewCount", 0);

			//기업키워드 리스트 추가
			String keyword = companyVO.getCompanyName();
			System.out.println("keyword@@@@@" + keyword);
			
			List<BoardCategoryBoardDto> companyKeywordList = boardDao.getCompanyKeywordList(keyword);
			
			for(int i =0; i<companyKeywordList.size(); i++) {
				String target = companyKeywordList.get(i).getBoardContent();
				if(target.length() > 25) {
					target = target.substring(0, 25) + "...";
				}
				
				companyKeywordList.get(i).setBoardContent(target);
			}
			
			model.addAttribute("companyKeywordList", companyKeywordList);
			
			return "company/companyBoard";
		}
		else {
			// 임시.. 404가 정상 나중에 Filter로 500 떴을 때 error 페이지 보여줌
			return "company/companyBoard/error";
		}
	}

}
