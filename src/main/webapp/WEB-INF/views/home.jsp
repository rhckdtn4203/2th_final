<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="${root}/css/common.css">
	<link rel="stylesheet" type="text/css" href="${root}/css/menu.css">
	<link rel="stylesheet" type="text/css" href="${root}/css/layout.css">
	<link rel="stylesheet" type="text/css" href="${root}/css/test.css">
	<style>
		li.write{float:right;}
	</style>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body>
	<main>
		<header>
			
		</header>
		<nav>
			<!-- 메뉴 -->
			<ul class="menu">
				<li>
					<a href="${root}/">홈</a>
				</li> 
				<li>
					<a href="#">기업 리뷰</a>
				</li>
				<li class="write">
					<a href="${root}/boardWrite">글쓰기</a>
				</li>
			</ul>
		</nav>
	</main>	
	</body>
</html>		