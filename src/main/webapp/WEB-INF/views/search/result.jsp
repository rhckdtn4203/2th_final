<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h1>검색 결과</h1>

<c:forEach var="boardDto" items="${list}">
	${boardDto.memberNo}
	${boardDto.boardTitle}
	${boardDto.boardContent}
</c:forEach>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>