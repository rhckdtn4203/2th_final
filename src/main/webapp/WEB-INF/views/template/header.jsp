<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<c:set var="isLogin" value="${not empty memberNo}"></c:set>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="${root}/css/common.css">
<link rel="stylesheet" type="text/css" href="${root}/css/menu.css">
<link rel="stylesheet" type="text/css" href="${root}/css/layout.css">
<link rel="stylesheet" type="text/css" href="${root}/css/test.css">
<style>
li.write {
	float: right;
}
</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${root}/js/confirm-link.js"></script>
</head>

<body>
		<header>
			<h1>Blind</h1>
		</header>
		<nav>
			<!-- 메뉴 -->
			<ul class="menu">

				<c:if test="${dtoss != null}">

					<li><a href="${root}">홈</a></li>
					<li><a href="${root}#">기업리뷰</a></li>

					<li class="write"><a href="${root}/boardWrite">글쓰기</a></li>
					<li><a href="${root}/member/logout">로그아웃</a></li>
					<li><a href="${root}/member/mypage">내 정보 보기</a></li>
				</c:if>

				<c:if test="${dtoss == null }">
					<li><a href="${root}">홈</a></li>
					<li><a href="${root}#">기업리뷰</a></li>

					<li><a href="${root}/member/login">로그인</a></li>
					<li><a href="${root}/member/signup">회원 가입</a></li>
				</c:if>


			</ul>

		</nav>
	