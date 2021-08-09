<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style5.css">

<body>

<div class="findwrap">
  
    <div class="sections">
      <div class="section active" data-bgcolor="#C0D85D">
        <div class="inputFind">
          <div class="findTitle">
            <h2>YOU GET SUCCESS!
            </h2>
          </div>
          
            <div class="row-left">
           
				<p id="p-search">회원님의 아이디는 <span id="p-span">${idresult}</span>입니다</p>
	
            </div>
            
            <div class="row-left">
            <a href="${pageContext.request.contextPath}/member/login">로그인</a>
            <a href="${pageContext.request.contextPath}/member/find_pw">비밀번호찾기</a>
         	</div>

        </div>
        </div>
        </div>
        </div>
        

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>