<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<img src="${pageContext.request.contextPath}/company/companyProfile?companyNo=${companyVO.companyNo}" width=200 height=200></img>
<h1>${companyVO.companyName}</h1>

<br><br>

<a href="${pageContext.request.contextPath}/company/companyReview?companyNo=${param.companyNo}">리뷰</a>
<br>
<a href="${pageContext.request.contextPath}/company/companyBoard?companyNo=${param.companyNo}">게시판</a>

<br><br>

<!-- 별 이미지 추가 -->
<span>${reviewRate}</span>
<span>${reviewCount}개의 리뷰</span>

<hr>

<span>홈페이지 : ${companyVO.companyUrl}</span>
<span>업계 : ${companyVO.companyIndustry}</span>
<br>
<span>본사 : ${companyVO.companyAddr}</span>
<!-- 년도로 바꿔야 함 -->
<span>설립일 : ${companyVO.companyEstablishment}</span>
<br>
<span>회사 소개 : ${companyVO.companyIntroduce}</span>