<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<span>{{회사 이미지}}</span>
<h1>${companyVO.companyName}</h1>

<br><br>

<!-- 별 이미지 추가 -->
<span>{{별점}}</span>
<span>{{리뷰 개수}}개의 리뷰</span>

<hr>

<span>홈페이지 : ${companyVO.companyUrl}</span>
<span>업계 : ${companyVO.companyIndustry}</span>
<br>
<span>본사 : ${companyVO.companyAddr}</span>
<!-- 년도로 바꿔야 함 -->
<span>설립일 : ${companyVO.companyEstablishment}</span>
<br>
<span>회사 소개 : ${companyVO.companyIntroduce}</span>