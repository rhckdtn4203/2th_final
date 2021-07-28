<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<h2>게시판 목록</h2>
<!-- boardNo?, boardTitle, boardContent, memberNick, 좋아요 수,  댓글 수?-->
	<c:if test="${companyBoardList != null}">
	<form action="${root}/board/boardList" method="get">
		<input type="hidden" name="type" value="companyBoard">
		<input type="text" name="keyword" required>
		<input type="submit" value="검색">
	</form>
	</c:if>
	
	<c:if test="${jobCategoryBoardList != null}">
	<form action="${root}/board/boardList" method="get">
		<input type="hidden" name="type" value="jobCategoryBoard">
		<input type="text" name="keyword" required>
		<input type="submit" value="검색">
	</form>
	</c:if>
	
	<c:if test="${boardCategoryBoardList != null}">
	<form action="${root}/board/boardList" method="get">
		<input type="hidden" name="type" value="boardCategoryBoard">
		<input type="text" name="keyword" required>
		<input type="submit" value="검색">
	</form>
	</c:if>
	
<table border="1" width="700" align="center">
	<thead>
		<tr>
			<th>번호</th>
			<th width="40%">제목</th>
			<th>내용</th>
			<th>작성자</th>
			<th>조회수</th>
			<th>작성일</th>
			<th>댓글 수</th>
			<th>좋아요수</th>
		</tr>
	</thead>
	<tbody>
		<c:if test="${companyBoardList != null}">
		<c:forEach var="companyBoardDto" items="${companyBoardList}">
		<tr>
			<td>"${companyBoardDto.companyNo}"</td>
			<td><a href="${root}/board/boardDetail?boardNo=${companyBoardDto.boardNo}">"${companyBoardDto.boardTitle}"</a></td>
			<td>"${companyBoardDto.boardContent}"</td>
			<td>"${companyBoardDto.memberNick}"</td>
			<td>"${companyBoardDto.boardCount}"</td>
			<td>"${companyBoardDto.boardDate}"</td>
			<td>?</td>
			<td>?</td>
		</tr>
		</c:forEach>
		</c:if>
		
		<c:if test="${jobCategoryBoardList != null}">
		<c:forEach var="jobCategoryBoardDto" items="${jobCategoryBoardList}">
		<tr>
			<td>"${jobCategoryBoardDto.jobCategoryNo}"</td>
			<td>"${jobCategoryBoardDto.boardTitle}"</td>
			<td>"${jobCategoryBoardDto.boardContent}"</td>
			<td>"${jobCategoryBoardDto.memberNick}"</td>
			<td>"${jobCategoryBoardDto.boardCount}"</td>
			<td>"${jobCategoryBoardDto.boardDate}"</td>
			<td>?</td>
			<td>?</td>
		</tr>
		</c:forEach>
		</c:if>
		
		<c:if test="${boardCategoryBoardList != null}">
		<c:forEach var="boardCategoryBoardDto" items="${boardCategoryBoardList}">
		<tr>
			<td>"${boardCategoryBoardDto.boardCategoryNo}"</td>
			<td>"${boardCategoryBoardDto.boardTitle}"</td>
			<td>"${boardCategoryBoardDto.boardContent}"</td>
			<td>"${boardCategoryBoardDto.memberNick}"</td>
			<td>"${boardCategoryBoardDto.boardCount}"</td>
			<td>"${boardCategoryBoardDto.boardDate}"</td>
			<td>?</td>
			<td>?</td>
		</tr>
		</c:forEach>
		</c:if>	
	</tbody>
</table>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>