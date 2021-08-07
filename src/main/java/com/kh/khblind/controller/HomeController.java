package com.kh.khblind.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.khblind.admin.category.entity.CategoryDto;
import com.kh.khblind.admin.category.repository.CategoryDao;
import com.kh.khblind.board.entity.BoardCategoryAllCountDto;
import com.kh.khblind.board.entity.BoardCategoryBoardDto;
import com.kh.khblind.board.entity.BoardCategoryListByLikeCountVO;
import com.kh.khblind.board.entity.MainCategoryDataVO;
import com.kh.khblind.board.repository.BoardDao;
import com.kh.khblind.member.entity.MemberDto;


@Controller
public class HomeController {
	
	@Autowired
	BoardDao boardDao;
	@Autowired
	CategoryDao categoryDao;
	
	
	@RequestMapping("/")
	public String home(
			HttpSession session, Model model, 
			@RequestParam(required = false) String keyword
			
			) {
		
		MemberDto memberDto = (MemberDto)session.getAttribute("dtoss");
		if(memberDto !=null) {
			int companyNo = memberDto.getCompanyNo();
			int jobCategoryNo = memberDto.getJobCategoryNo();
			String companyName = boardDao.getCompanyName(companyNo);
			String jobCategoryName = boardDao.getJobCategoryName(jobCategoryNo);
			model.addAttribute("companyName", companyName);
			model.addAttribute("jobCategoryName", jobCategoryName);
		}	
		
		//카테고리 메뉴를 가져오는 코드
		
		List<CategoryDto> categoryList = categoryDao.list();
		System.out.println("categoryList 비어있니?" + categoryList);
		model.addAttribute("categoryList", categoryList);
		
		System.out.println("if전 = " + keyword);
//		//토픽 검색 기능 연습
//		if(keyword !=null) {
//		System.out.println("if 안=" + keyword);
//		List<BoardCategoryBoardDto> boardCategoryboardList = boardDao.BoardCategorySearch(keyword);
//		model.addAttribute("boardCategoryboardList", boardCategoryboardList);
//		}

		//메인에 토픽 6개 조회수순으로 목록 코드
		
		for(int i =1; i<=2; i++) {
			int rn = i;
			BoardCategoryAllCountDto boardCategoryAllCountDto = boardDao.getBoardCategoryByAllCount(rn);
			int boardCategoryNo = boardCategoryAllCountDto.getBoardCategoryNo();
			
			
			List<MainCategoryDataVO> mainBoardCategoryList = boardDao.mainBoardCegoryList(boardCategoryNo);
			
			String modelName = "mainBoardCategoryList";
			int modelOrderNo = i;
			String finalModelName = modelName + modelOrderNo;

			model.addAttribute(finalModelName, mainBoardCategoryList);
			
//			${mainBoardCategoryList-1}
//			${mainBoardCategoryList-2}
//			${mainBoardCategoryList-3}
//			${mainBoardCategoryList-4}
//			${mainBoardCategoryList-5}
//			${mainBoardCategoryList-6}			
			
			//토픽베스트 List 관련 코드
			List<BoardCategoryListByLikeCountVO> BoardCategoryListByLikeCount = boardDao.getBoardCategoryListByLikeCount();
			
			//모델에 넣기
			model.addAttribute("BoardCategoryListByLikeCount", BoardCategoryListByLikeCount);
		}
	
	
		
//		BoardCategoryAllCountDto boardCategoryAllCountDto = boardDao.boardCategoryAllCount(rn);
//				int boardCategoryNo = boardCategoryAllCountDto.getBoardCategoryNo();
//				List<MainCategoryDataVO> mainBoardCategoryList = boardDao.mainBoardCegoryList(boardCategoryNo);
//		
//		model.addAttribute("mainBoardCategoryList", mainBoardCategoryList);
		
		return "/home";
	}
}	

