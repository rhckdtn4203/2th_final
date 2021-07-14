<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<c:set var="isLogin" value="${not empty memberNo}"></c:set>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Blind</title>
	<link rel="stylesheet" type="text/css" href="${root}/css/common.css">
	<link rel="stylesheet" type="text/css" href="${root}/css/menu.css">
	<link rel="stylesheet" type="text/css" href="${root}/css/layout.css">
	<link rel="stylesheet" type="text/css" href="${root}/css/test.css">
	<style></style>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="${root}/js/confirm-link.js"></script>
</head>
<body>
	<main>
		<header>
			<h1>Blind</h1>
		</header>
		<nav>
			<!-- 메뉴 -->
			<ul class="menu">
				<li>
					<a href="#">회원 기능</a>
					<ul>
						<c:choose>
							<c:when test="${isLogin}">
								<li><a href="${root}/index">홈</a></li>
								<li><a href="${root}#">기업리뷰</a></li>
								<li><a href="${root}/member/login">로그인</a></li>
								<li><a href="${root}/member/signup">회원 가입</a></li>

							</c:when>
							<c:otherwise>
								
								
								<li><a href="${root}/index">홈</a></li>
								<li><a href="${root}#">기업리뷰</a></li>
								<li><a href="${root}#">글쓰기</a></li>
								<li><a href="${root}/member/logout">로그아웃</a></li>
								<li><a href="${root}/member/mypage">내 정보 보기</a></li>
							</c:otherwise>	
						</c:choose>
					</ul>
				</li>
				
			</ul>
		</nav>
		<section>