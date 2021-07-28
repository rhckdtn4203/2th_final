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

            <!-- 부트스트랩을 가져온다 -->
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
            <!-- 제이쿼리를 가져온다 -->
            <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
            <!-- UI제이쿼리를  가져온다 -->
            <script  src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"  integrity="sha256-T0Vest3yCU7pafRw9r+settMBX6JkKN06dqBnpQ8d30="   crossorigin="anonymous"></script>
            <!-- Popper를 가져온다 -->
            <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.9.2/umd/popper.min.js" integrity="sha512-2rNj2KJ+D8s1ceNasTIex6z4HWyOnEYLVC3FigGOmyQCZc2eBXKgOxQmo3oKLHyfcj53uz4QMsRCWNbLd32Q1g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
            <!-- 폰트어썸 아이콘을 가져온다-->
            <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
            <!-- 부트와치를 가져온다.-->
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.5.2/dist/flatly/bootstrap.min.css" integrity="sha384-qF/QmIAj5ZaYFAeQcrQ6bfVMAh4zZlrGwTPY7T/M+iTTLJqJBJjwwnsE5Y0mV7QK" crossorigin="anonymous">

<script src="${root}/js/confirm-link.js"></script>

<script>

	$(function(){
		$.ajax({
			url:"${root}/search/keywordList",
			type:"get",
			dataType:"json",
			success:function(resp){
				$("#ranking").empty();
				for(var i=0; i <10; i++){
					var template = $("#template").html();
					template = template.replace("{{rank}}",i+1+".");
					template = template.replace("{{keyword}}", resp[i].keyword);
					$("#ranking").append(template);	
				}
			}
		});
	});

	
</script>

 <script id="template" type="text/template">
			
				<div class="row text-left">
					<h5>{{rank}} {{keyword}}</h5>
				</div>
</script>

</head>

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

		<header>
			<a href="${root}" class="company-logo">Blind</a>
		</header>
		<nav>
			<!-- 메뉴 -->
			<ul class="menu">

				<c:if test="${dtoss != null}">

					<li><a href="${root}">홈</a></li>
					<li><a href="${root}#">기업리뷰</a></li>

					<li class="write"><a href="${root}/board/boardWrite">글쓰기</a></li>
					<li><a href="${root}/member/logout">로그아웃</a></li>
					<li><a href="${root}/member/mypage">내 정보 보기</a></li>
					<li><a href="${root}/pay/upgrade">회원플러스 결제</a></li>
					<li><a href="${root}/board/boardList?type=companyBoard">${companyName}</a></li>
					<li><a href="${root}/board/boardList?type=jobCategoryBoard">${jobCategoryName}</a></li>
				</c:if>

				<c:if test="${dtoss == null }">
					<li><a href="${root}">홈</a></li>
					<li><a href="${root}#">기업리뷰</a></li>

					<li><a href="${root}/member/login">로그인</a></li>
					<li><a href="${root}/member/signup">회원 가입</a></li>
				</c:if>



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

		</nav>	
	
		
   <div id="nav-zone" class="offset-3 col-6 row p-2 text-center">
        <div id="inner-nav-zone" class="col-12 row">
        <!-- 여기에 추가 -->
        
        <c:forEach var="categoryDto" items="${categoryList}">
        <div class="col-2 p-4">
        	<a href ="${root}/board/boardList?type=boardCategoryBoard&boardCategoryNo=${categoryDto.boardCategoryNo}">${categoryDto.boardCategoryName}</a>
    	</div>
        </c:forEach>
        
        </div>
   </div>

		
