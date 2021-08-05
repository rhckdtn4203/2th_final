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

  <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/bb.png" />
	
  <script src="https://kit.fontawesome.com/77858aaef8.js" crossorigin="anonymous">
</script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@300;400;600;700&display=swap" 
  rel="stylesheet">

 <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>

	$(function(){
		$.ajax({
			url:"${rt}/search/keywordList",
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
				

				//만들어낸 뒤
				$(".rank-keyword").click(function(e){
					console.log("click");
		 			var keywordarr = $(this).text().split('.');
		 			var keyword = keywordarr[1];
		 			location.href = "${rt}/board/boardList?type=boardCategoryBoard&keyword="+keyword;
		 			//$("a").attr("href","${rt}/board/boardList?type=boardCategoryBoard&keyword="+keyword);
					
					e.preventDefault();
				});	
			}
		});
	});	
</script>
<script id="template" type="text/template">
		<h5 class="rank-list"><a href="#" class="rank-keyword">{{rank}}{{keyword}}</a></h5>
</script>

  <script>
    $('form input').keydown(function(e) {
	    if (e.keyCode == 13) {
	        $('.search').submit();
	    }
	});
  </script>
  <style>
  	.rank-list{
  		font-size: 15px;
  		margin: 8.5px auto;
  	}
  	#ranking{
  		padding-left:45px;
  		text-align: left;
  	}
  	.rank-keyword:hover{
  		color: wheat;
  	}
  </style>


  <style>
  html{
  background-color: white;
  }
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
          <ul class="menu" id="menu">
            <li class="menu-list">
              <a href="${rt}" class="menu-item">홈</a>
            </li>
            <li class="menu-list">
              <a href="${pageContext.request.contextPath}/company/" class="menu-item">기업리뷰</a>
              <!-- <ul>
                <li><a href="">서브1</a></li>
                <li><a href="">서브2</a></li>
              </ul> -->
            </li>
            <li class="menu-list">
              <a href="${rt}" class="menu-item" id="invisable">로그인</a>
            </li>
            <li class="menu-list">
              <a href="${rt}" class="menu-item" id="invisable">회원가입</a>
            </li>
          </ul> 
          
          <div class="btn-box">
            <a href="${rt}/member/login" id="btn-top">로그인</a>
            <a href="${rt}/member/signup" id="btn-top">회원가입</a>
          </div>
         </div> 
 
          </c:if>
          
          
        <c:if test="${dtoss != null}">
          <div class="headerBox">
          <ul class="menu" id="menu">
            <li class="menu-list">
              <a id="write" class="menu-item" href="${rt}/board/boardWrite">글쓰기</a>
            </li>
            <li class="menu-list">
              <a href="${rt}/company/"class="menu-item">기업리뷰</a>
            </li>
            <li class="menu-list">
            <a class="menu-item" href="${rt}/pay/upgrade">
         	회원<span id="plus"><i class="fas fa-plus"></i></span>결제</a>
         	</li>
         	
         	 <li class="menu-list">
              <a href="${rt}" class="menu-item" id="invisable">내 정보</a>
            </li>
            <li class="menu-list">
              <a href="${rt}" class="menu-item" id="invisable">로그아웃</a>
            </li>
            
          </ul> 
          
          <div class="btn-box">
             <a href="${rt}/member/mypage" id="btn-top">내 정보</a>
            <a href="${rt}/member/logout" id="btn-top">로그아웃</a>
          </div>
          </div>
          </c:if>
       
           <!-- toggle btn -->
        <button id="toggle-btn">
          <i class="fas fa-bars"></i>
        </button>

      </section>
    
    
    <script type="text/javascript">
 
    // toggle-btn
    const toggleButton = document.querySelector('#toggle-btn');
    const menus = document.querySelector('#menu');
      
       toggleButton.addEventListener('click', () => {
          menus.classList.toggle('open')
       });

    </script>
      

    <hr>
    
