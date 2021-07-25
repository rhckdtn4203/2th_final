<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<c:set var="rt" value="${pageContext.request.contextPath}"></c:set>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>밤부-직장인들의 수다 놀이터</title>
  <link rel="shortcut icon" href="imgs/bb.png" />

  <script 
  src="https://kit.fontawesome.com/77858aaef8.js" crossorigin="anonymous">
</script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@300;400;600;700&display=swap" 
  rel="stylesheet">

 <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">

  <style>
  </style>
</head>
<body>
 <div id="wrap">
      <section id="header">
        <div class="headerBox">
          <div class="logo-box">
            <div class="logo-sub">
              <h3 class="logo-sub1">밤</h3>
              <h3 class="logo-sub1">부</h3>
            </div>

            <h1><a href="${pageContext.request.contextPath}">BamBo</a></h1>
            <h1><i class="far fa-eye"></i></h1>
          </div>
        </div>
        
         <c:if test="${dtoss == null }">
        <div class="headerBox">
          <ul class="menu">
            <li class="menu-list">
              <a href="${rt}" class="menu-item">홈</a>
            </li>
            <li class="menu-list">
              <a href=""class="menu-item">기업리뷰</a>
              <!-- <ul>
                <li><a href="">서브1</a></li>
                <li><a href="">서브2</a></li>
              </ul> -->
            </li>
          </ul> 
          
          <div class="btn-box">
            <a href="${rt}/member/login" class="btn-top">로그인</a>
            <a href="${rt}/member/signup" class="btn-top">회원가입</a>
          </div>
         </div> 
       
          
          </c:if>
          
          
        <c:if test="${dtoss != null}">
          <div class="headerBox">
          <ul class="menu">
            <li class="menu-list">
              <a id="write" class="menu-item" href="${rt}/boardWrite">글쓰기</a>
            </li>
            <li class="menu-list">
              <a href=""class="menu-item">기업리뷰</a>
              <!-- <ul>
                <li><a href="">서브1</a></li>
                <li><a href="">서브2</a></li>
              </ul> -->
            </li>
            <li class="menu-list">
            <a class="menu-item" href="${rt}/pay/upgrade">
         	회원<span id="plus"><i class="fas fa-plus"></i></span>결제</a>
         	</li>
          </ul> 
          
          <div class="btn-box">
             <a href="${rt}/member/mypage"class="btn-top">내 정보</a>
            <a href="${rt}/member/logout"class="btn-top">로그아웃</a>
          </div>
          </div>
          </c:if>
       

      </section>
     
    <hr>
