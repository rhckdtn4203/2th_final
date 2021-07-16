package com.kh.khblind.board.vote.test;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.junit.Test;

public class Test00_getHashTags {

	@Test
	public void test1() {
		String text = "#소개 #일상 \r\n" + 
				"안녕하세요! 이건 테스트입니다.\r\n" + 
				"\r\n  </div></div>" + 
				"#삼성 # LG #프로젟트 # 석현";
		
		String regexPattern = "([#][a-zA-Z가-힣0-9]{1,})"; //정규표현식
		
//		List<String> HashtagInBoardContentList = new ArrayList<>();
		
		Pattern p = Pattern.compile(regexPattern);
		Matcher m = p.matcher(text);
		
		while (m.find()) {
		    String hashtag = m.group(1);
		    
		    System.out.println("현재 hashtag =" + hashtag);
		    
		    String hashtagWithAnchor = "<a href=/kr/tag/"+hashtag+">"+hashtag+"</a>";
		    
		    System.out.println(hashtagWithAnchor);
		    
		    text = text.replace(hashtag, hashtagWithAnchor);
		    
//		    System.out.println("현재 태그 = " + hashtag);
//		    HashtagInBoardContentList.add(hashtag);
		}
		
//		System.out.println("해시 태그들 = " + HashtagInBoardContentList);
		System.out.println("------------------------");
		System.out.println(text);
		
	}
}
