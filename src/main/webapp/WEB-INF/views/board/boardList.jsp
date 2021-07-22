<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<h2>게시판 목록</h2>
<!-- boardNo?, boardTitle, boardContent, memberNick, 좋아요 수,  댓글 수?-->
<table border="1" width="700" align="center">
	<thead>
		<tr>
			<th>번호></th>
			<th width="40%">제목</th>
			<th>내용</th>
			<th>작성자</th>
			<th>내용</th>
			<th>좋아요 수</th>
			<th>댓글 수</th>
		</tr>
	</thead>
	<tbody>
	<!-- for~ -->
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>	
	</tbody>
</table>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>