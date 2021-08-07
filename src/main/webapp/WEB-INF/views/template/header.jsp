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

  <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/bb.png"/>
   
  <script src="https://kit.fontawesome.com/77858aaef8.js" crossorigin="anonymous">
</script>
<style>


        .modal {
           justify-content:center; 
  align-items:center;     
  position:fixed;         
  top:0;
  left:0;
  right:0;
  bottom:0;               
  display:none; 
  display:flex;
  padding:15px; 
         
        }

        .modal .bg {
          width: 100%;
          height: 100%;
          background-color: rgba(0, 0, 0, 0.6);
          
        }
        .bg{
        backdrop-filter: blur(4px);
        }

        .modalBox {
                        
  		  border-radius:10px;
  		  overflow:hidden;
 	 	  background-color:#264db5;
          box-shadow: 5px 10px 10px 1px rgba(0,0,0,.3); 
        }
        .popup-head{
  width:100%;
  height:50px;  
  display:flex; 
  align-items:center;
  justify-content:center;
}
.popup-body{                
  width:100%;
  background-color:#ffffff; 
}
.body-content{              
  width:100%;
  padding:30px;             
}
.body-titlebox{             
  text-align:center;       
  width:100%;
  height:40px;
  margin-bottom:10px;      
}
.body-contentbox{           
  word-break:break-word;    
  overflow-y:auto;          
  min-height:100px;         
  max-height:200px;         
}

        .modalBox button {
          display: block;
          width: 80px;
          margin: 0 auto;
        }

        .hidden {
          display: none;
        }

		.zzzz{
		width: 500px;
		margin: auto;
		margin-top: 200px;
		}
    </style>
  





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
         }
      });
   });   
</script>
<script id="template" type="text/template">
   <div class="row text-left">
      <span>{{rank}} {{keyword}}</span>
   </div>      
</script>


  <style>
  html{
  background-color: white;
  }
  #wrap{
  text-align:left;
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
              <a href="${rt}/company/"class="menu-item">기업리뷰</a>
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
              <!-- <ul>
                <li><a href="">서브1</a></li>
                <li><a href="">서브2</a></li>
              </ul> -->
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
         <c:if test="${dtoss.gradeNo != 5}">	
          <div class="btn-box">
             <a href="${rt}/member/mypage" id="btn-top">내 정보</a>
            <a href="${rt}/member/logout" id="btn-top">로그아웃</a>
          </div>
          </c:if>
          <c:if test="${dtoss.gradeNo == 5}">
          <div class="btn-box">
            <a class="openBtn" id="btn-top">관리메뉴</a>
            <a href="${rt}/member/logout" id="btn-top">로그아웃</a>
          </div>
        <div class="modal hidden">
      		<div class="bg">
      			<div class="modalBox zzzz">
        			<div class="popup-head">  
        				<span class="head-title">BamBoo</span>
       				</div>
        			<div class="popup-body">	
        				<div class="body-content">
          					<div class="body-titlebox">
            					<h1>관리자 페이지</h1>
          					</div>
          					<div class="body-contentbox">
        						<ul>
						            <li><a href="${rt}/admin/categoryList">카테고리 수정|삭제</a></li>
						            <li><a href="${rt}/admin/insertCompany">기업등록</a></li>
						            <li><a href="${rt}/admin/companyRegistList">기업신청목록</a></li>
						            <li><a href="${rt}/admin/approveImageCert">등업관리</a></li>
        						</ul>
         					</div>
						</div>
      				</div>
      				<div class="popup-foot"> 
        				<button class="closeBtn">창 닫기</button>
					</div>
    			</div>
            </div>
          </div>
          </c:if>
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
       
       const open = () => {
           document.querySelector(".modal").classList.remove("hidden");
         }
       
         const close = () => {
           document.querySelector(".modal").classList.add("hidden");
         }
       
         document.querySelector(".openBtn").addEventListener("click", open);
         document.querySelector(".closeBtn").addEventListener("click", close);
         document.querySelector(".bg").addEventListener("click", close);

    </script>
      

    <hr>
    