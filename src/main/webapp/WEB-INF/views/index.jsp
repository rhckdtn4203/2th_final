<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<h1>WELCOME</h1>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

<h1>홈</h1>
<a href="${pageContext.request.contextPath}/admin/category">관리자 카테고리</a>

