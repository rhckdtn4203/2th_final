package com.kh.khblind.board.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.khblind.board.entity.MetamonBoardListVO;
import com.kh.khblind.board.entity.StartEndVoForAjax;
import com.kh.khblind.board.repository.BoardDao;
import com.kh.khblind.member.entity.MemberDto;

import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/board")
@Slf4j
public class BoardRestController {
	
	@Autowired
	private BoardDao boardDao;
	
	@GetMapping("/ajaxBoardList")
	public List<MetamonBoardListVO> boardList(
			HttpSession session,
			String boardType,
			@RequestParam int startNo,
			@RequestParam int endNo,
			@RequestParam(required = false) Integer boardCategoryNo,
			@RequestParam(required = false) String boardKeyword			
			) {
		log.debug("startNo-{}, endNo", startNo, endNo);
		log.debug("boardKeyword-{}", boardKeyword);
		MemberDto memberDto = (MemberDto)session.getAttribute("dtoss");
		

		//업종별 게시판 목록

		if(boardType.equals("job")) {
			int jobCategoryNo = memberDto.getJobCategoryNo();
			StartEndVoForAjax startEndVoForAjax  = StartEndVoForAjax.builder()
					.startNo(startNo)
					.endNo(endNo)
					.jobCategoryNo(jobCategoryNo)
					.keyword(boardKeyword)
					.build();
			log.debug("startEndVoForAjax - ", startEndVoForAjax);
			//일단 저장소를 만든다.(자바가 멍청한건지 if문안에 변수가 있으면 모름)
			List<MetamonBoardListVO> jobCategoryBoardList = new ArrayList<>();

			if(boardKeyword.equals("")) { //키워드가 없으면 일반목록 조회
				jobCategoryBoardList = boardDao.ajaxJobCategoryBoardList(startEndVoForAjax);
			
				for(int i =0; i<jobCategoryBoardList.size(); i++) {
					String target = jobCategoryBoardList.get(i).getBoardContent();
					if(target.length()>25) {
						target = target.substring(0, 25) + "...";
					}
					
					jobCategoryBoardList.get(i).setBoardContent(target);
				}
			}	
			else if(!boardKeyword.equals("")) {
				jobCategoryBoardList	= boardDao.ajaxSearchJobCategoryBoardList(boardKeyword);
				
				for(int i =0; i<jobCategoryBoardList.size(); i++) {
					String target = jobCategoryBoardList.get(i).getBoardContent();
					if(target.length()>25) {
						target = target.substring(0, 25) + "...";
					}
					
					jobCategoryBoardList.get(i).setBoardContent(target);
				}
			}
			return jobCategoryBoardList;
		}

		//토픽별 게시판 목록
		
		else if(boardType.equals("boardCategory")) {

			StartEndVoForAjax startEndVoForAjax  = StartEndVoForAjax.builder()
					.startNo(startNo)
					.endNo(endNo)
					.boardCategoryNo(boardCategoryNo)
					.keyword(boardKeyword)
					.build();
			List<MetamonBoardListVO> boardCategoryBoardList = new ArrayList<>();
			if(boardKeyword.equals("")) {
				boardCategoryBoardList = boardDao.ajaxBoardCategoryBoardList(startEndVoForAjax);
				
				for(int i =0; i<boardCategoryBoardList.size(); i++) {
					String target = boardCategoryBoardList.get(i).getBoardContent();
					if(target.length()>25) {
						target = target.substring(0, 25) + "...";
					}
					
					boardCategoryBoardList.get(i).setBoardContent(target);
				}
				
				
			}
			else if(!boardKeyword.equals("")) {
				boardCategoryBoardList	= boardDao.ajaxSearchBoardCategoryBoardList(boardKeyword);
				
				for(int i =0; i<boardCategoryBoardList.size(); i++) {
					String target = boardCategoryBoardList.get(i).getBoardContent();
					if(target.length()>25) {
						target = target.substring(0, 25) + "...";
					}
					
					boardCategoryBoardList.get(i).setBoardContent(target);
				}
				
			}
			return boardCategoryBoardList;
		}
		
		//기업별 게시판 목록
		
		else if(boardType.equals("company")) {
			int companyNo = memberDto.getCompanyNo();
			StartEndVoForAjax startEndVoForAjax  = StartEndVoForAjax.builder()
					.startNo(startNo)
					.endNo(endNo)
					.companyNo(companyNo)
					.keyword(boardKeyword)
					.build();
			List<MetamonBoardListVO> companyBoardList = new ArrayList<>();
			if(boardKeyword.equals("")) {
				companyBoardList = boardDao.ajaxCompanyBoardList(startEndVoForAjax);
				
				for(int i =0; i<companyBoardList.size(); i++) {
					String target = companyBoardList.get(i).getBoardContent();
					if(target.length()>25) {
						target = target.substring(0, 25) + "...";
					}
					
					companyBoardList.get(i).setBoardContent(target);
				}
				
			}	
			else if(!boardKeyword.equals("")) {
				companyBoardList	= boardDao.ajaxSearchCompanyBoardList(boardKeyword);
				
				for(int i =0; i<companyBoardList.size(); i++) {
					String target = companyBoardList.get(i).getBoardContent();
					if(target.length()>25) {
						target = target.substring(0, 25) + "...";
					}
					
					companyBoardList.get(i).setBoardContent(target);
				}
				
			}		
			
			return companyBoardList;
		}
		
		//boardType = 이도저도 아닌거 들어올때의 경우의 수
		else {
			return null; //글없다 페이지
		}
		
		
			
	}
		
	

}
