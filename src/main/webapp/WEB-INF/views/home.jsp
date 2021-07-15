<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>



<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

	<section>
		
	<c:if test="${dtoss != null }">
		<p>${dtoss.memberNick}님환영합니다.
	</c:if>

</section>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

