<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 여기 되는지 확인해야 함 -->
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
// 	$(function() {
// 		var src = "D:/proj/khblind/resources/5.company-logo-image/";
// 		var fileName = ${companyVO.companyProfileSaveName};
// 		var type = ${companyVO.companyProfileContentType};
// 		var resultSrc = src + fileName + type;
		
// 		$("#companyImg").attr("src", resultSrc);
// 	});
</script>
    
<!-- <img id="companyImg" width=512 height=384></img> -->
<h1>${companyVO.companyName}</h1>

<br><br>

<a href="${pageContext.request.contextPath}/company/companyReview?companyNo=${param.companyNo}">리뷰</a>
<br>
<a href="${pageContext.request.contextPath}/company/companyBoard?companyNo=${param.companyNo}">게시판</a>

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