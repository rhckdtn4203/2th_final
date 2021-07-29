<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
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

<h4>${companyVO.companyName} 리뷰</h4>

<span>${reviewRate}</span>
<!-- 별 개수에 따른 이미지 추가 -->
<span>${reviewCount}개의 리뷰</span><br>
<!-- 개수에 따른 그래프..? 퍼센티지로.. -->
<c:forEach var="reviewCountList" items="${reviewCountList}" varStatus="status">
	<span> 
		${5-status.index}개의 별점 :
		<c:forEach var="count" items="${reviewCountList}">
			<c:if test="${count.key != 'RATE'}">
				${count.value}개 (${(count.value * 100) / reviewCount} %)
			</c:if>
		</c:forEach>
	</span><br>	
</c:forEach>

<hr>

<a href="${pageContext.request.contextPath}/company/reviewWrite?companyNo=${param.companyNo}">리뷰 작성하기</a>

<hr>

<table>
	<thead>
		<tr>
			<th>별점</th>
			<th>리뷰 제목</th>
			<th>닉네임</th>
			<th>업종 분류</th>
			<th>날짜</th>
			<th>장점</th>
			<th>단점</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="reviewMemberCategoryVO" items="${list}">
			<tr>
				<td>${reviewMemberCategoryVO.reviewRate}</td>
				<td>${reviewMemberCategoryVO.reviewTitle}</td>
				<td>${reviewMemberCategoryVO.memberNick}</td>
				<td>${reviewMemberCategoryVO.jobCategoryName}</td>
				<td>${reviewMemberCategoryVO.reviewDate}</td>
				<td>${reviewMemberCategoryVO.reviewMerit}</td>
				<td>${reviewMemberCategoryVO.reviewDemerit}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
