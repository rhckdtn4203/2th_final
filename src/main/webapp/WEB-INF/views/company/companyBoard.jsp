<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 해야 함 -->
    
<span>{{회사 이미지}}</span>
<h1>${companyVO.companyName}</h1>

<br><br>

<!-- 별 이미지 추가 -->
<span>${reviewRate}</span>
<!-- 별 개수에 따른 이미지 추가 -->
<span>${reviewCount}개의 리뷰</span><br>

<hr>

<!-- 회사 이름 키워드 게시글 인기순 / 최신순 n개 보여주기 -->