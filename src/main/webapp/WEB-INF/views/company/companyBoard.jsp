<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- 해야 함 -->
    
<img src="${pageContext.request.contextPath}/company/companyProfile?companyNo=${companyVO.companyNo}" width=200 height=200></img>
<h1>${companyVO.companyName}</h1>

<br><br>

<!-- 별 이미지 추가 -->
<span>${reviewRate}</span>
<!-- 별 개수에 따른 이미지 추가 -->
<span>${reviewCount}개의 리뷰</span><br>

<hr>

<!-- 회사 이름 키워드 게시글 인기순 / 최신순 n개 보여주기 -->
<table>
	<thead>
		<tr>
			<th>제목</th>
			<th>내용</th>
			<th>조회수</th>
			<th>좋아요 수</th>
			<th>댓글 수</th>
			<th>글쓴 날</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="companyKeywordListDto" items="${companyKeywordList}">
			<tr>
				<td>${companyKeywordListDto.boardTitle}</td>
				<td>${companyKeywordListDto.boardContent}</td>
				<td>${companyKeywordListDto.boardCount}</td>
				<td>${companyKeywordListDto.likeCount}</td>
				<td>${companyKeywordListDto.commentsCount}</td>
				<td>${companyKeywordListDto.boardDate}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>