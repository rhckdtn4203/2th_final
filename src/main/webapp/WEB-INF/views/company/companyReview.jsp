<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<img src="${pageContext.request.contextPath}/company/companyProfile?companyNo=${companyVO.companyNo}" width=200 height=200></img>
<h1>${companyVO.companyName}</h1>

<br><br>

<h4>${companyVO.companyName} 리뷰</h4>

<span>${reviewRate}</span>
<!-- 별 개수에 따른 이미지 추가 -->
<span>${reviewCount}개의 리뷰</span><br>

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

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>