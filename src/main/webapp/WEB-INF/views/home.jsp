<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>


<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
	<!-- 임시 검색 화면(토픽) -->
	<form action="${root}/board/boardList" method="get">
		<input type="hidden" name="type" value="boardCategoryBoard">
		<input type="text" name="keyword" required>
		<input type="submit" value="검색">
	</form>
	<section>
		
	<c:if test="${dtoss != null }">
		<p>${dtoss.memberNick}님환영합니다.
	</c:if>

</section>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

