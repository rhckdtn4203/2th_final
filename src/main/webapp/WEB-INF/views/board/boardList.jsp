<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
            
            <!-- 제이쿼리를 가져온다 -->
            <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
            <!-- UI제이쿼리를  가져온다 -->
            <script  src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"  integrity="sha256-T0Vest3yCU7pafRw9r+settMBX6JkKN06dqBnpQ8d30="   crossorigin="anonymous"></script>
            
            <!-- 폰트어썸 아이콘을 가져온다-->
            <script src="https://kit.fontawesome.com/77858aaef8.js" crossorigin="anonymous"></script>
            
            <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.css">
			<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap_reboot.css">
			<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap_grid.css">
            
            
   <script>
   //로드되면 한 번 실행
   $(document).ready(function(){
	   console.log("최초");
	   var startNo = 1;
	   var per = 20;
	   var endNo = startNo + per - 1;
	   
	   console.log("초기값" + startNo + "|" + endNo)
 		$.ajax({
 			url: '${pageContext.request.contextPath}/board/ajaxBoardList',//1
 			type:"get",
 			dataType: "json",
 			data: {
 				boardType : "${boardType}",
 				boardCategoryNo : "${boardCategoryNo}",
 				startNo : startNo,
 				endNo : endNo,
 				boardKeyword : "${boardKeyword}",
 				jobCategoryNo : "${jobCategoryNo}"
 				},
 				
	  		success: function(resp) {
	  			console.log(resp)
	  			console.log(resp.length);
	  			for(var i=0; i < resp.length; i++){
	  				var template = $("#list-board-template").html();
	  				template = template.replace("{{boardNo1}}", resp[i].boardNo);
       				template = template.replace("{{boardNo2}}", resp[i].boardNo);
       				template = template.replace("{{boardNo3}}", resp[i].boardNo);
	  				template = template.replace("{{boardCategoryName}}", resp[i].boardCategoryName);
	       		template = template.replace("{{boardTitle}}", resp[i].boardTitle);
	       		template = template.replace("{{boardContent}}", resp[i].boardContent);
// 	       		template = template.replace("{{companyName}}", resp[i].companyName);
                template = template.replace("{{likeCount}}", resp[i].likeCount);
	       		template = template.replace("{{memberNick}}", resp[i].memberNick);
	       		template = template.replace("{{boardCount}}", resp[i].boardCount);
	       		template = template.replace("{{commentsCount}}", resp[i].commentsCount);
	       		template = template.replace("{{boardDate}}", resp[i].boardDate);
	       		$("#here").append(template);
	  			}
			}
 		}) //ajax끝
 		
 		
 	   $(window).scroll(function () {
 			 //보는 기준 높이
 		       var scrollValue = $(document).scrollTop(); 
 			 
 		     //전체 높이
 		       var body = document.body,
 		       html = document.documentElement;
 		       var pageHeight = Math.max( body.scrollHeight, body.offsetHeight, html.clientHeight, html.scrollHeight, html.offsetHeight );
 		       // var windowHeight = window.innerHeight;
 		       
 		       var rate = scrollValue/pageHeight*100
 		       
 		       console.log(rate + " \%");
 		       
 		       	if(rate>50){
 		   		startNo = startNo+per;
 		        endNo = endNo+per;
 		       		$.ajax({
 		       			url: '${pageContext.request.contextPath}/board/ajaxBoardList',//1
 		       			type:"get",
 		       			dataType: "json",
 		       			data: {
 		       				boardType : "${boardType}",
 		       				boardCategoryNo : "${boardCategoryNo}",
 		       				startNo : startNo,
 			 				endNo : endNo,
 			 				boardKeyword : "${boardKeyword}",
 			 				jobCategoryNo : "${jobCategoryNo}"
 		       				},
 		       				
 			       		success: function(resp) {
 			       			console.log(resp)
 			       			console.log("길이" + resp.length);
 			       			for(var i=0; i < resp.length; i++){
 			       				var template = $("#list-board-template").html();
 			       				template = template.replace("{{boardNo1}}", resp[i].boardNo);
 			       				template = template.replace("{{boardNo2}}", resp[i].boardNo);
 			       				template = template.replace("{{boardNo3}}", resp[i].boardNo);
 			       				template = template.replace("{{boardCategoryName}}", resp[i].boardCategoryName);
 			            		template = template.replace("{{boardTitle}}", resp[i].boardTitle);
 			            		template = template.replace("{{boardContent}}", resp[i].boardContent);
//  			            		template = template.replace("{{companyName}}", resp[i].companyName);
                                template = template.replace("{{likeCount}}", resp[i].likeCount);
 			            		template = template.replace("{{memberNick}}", resp[i].memberNick);
 			            		template = template.replace("{{boardCount}}", resp[i].boardCount);
 			            		template = template.replace("{{commentsCount}}", resp[i].commentsCount);
 			            		template = template.replace("{{boardDate}}", resp[i].boardDate);
 			            		$("#here").append(template);
 			       			}
 			  			}
 		       		}) //ajax끝
 		        
 		       	}
 		     });
	});
   
   
   
   

  
// 	$(function(){
// 		$("#test-btn").click(function(){
// 			console.log("버튼을 누")
			
// 			$.ajax({
// 				url: '${pageContext.request.contextPath}/board/ajaxBoardList',//1
// 				type:"get",
// 				dataType: "json",
// 				data: {
// 					boardType : "${boardType}",
// 					boardCategoryNo : "${boardCategoryNo}"
// 					},
						
// 				success: function(resp) {
//                 	console.log(resp)
// 					console.log(resp.length);
//                 	for(var i=0; i < resp.length; i++){
//                 		var template = $("#list-board-template").html();
//                 		template = template.replace("{{boardNo}}", resp[i].boardNo);
//                 		template = template.replace("{{boardCategoryBoardName}}", resp[i].boardCategoryBoardName);
//                 		template = template.replace("{{boardTitle}}", resp[i].boardTitle);
//                 		template = template.replace("{{boardContent}}", resp[i].boardContent);
//                 		template = template.replace("{{companyName}}", resp[i].companyName);
//                 		template = template.replace("{{memberNick}}", resp[i].memberNick);
//                 		template = template.replace("{{boardCount}}", resp[i].boardCount);
//                 		template = template.replace("{{commentCount}}", resp[i].commentCount);
//                 		template = template.replace("{{uploadTime}}", resp[i].uploadTime);
//                 		$("#here").append(template);
//                 		}
// 				}
// 			})//ajx끝
// 		})
// 	});

		 

   </script>
   
   <!--
   	목표 : 비동기 통신 등에서 사용할 화면 조각들을 "템플릿"으로 보관하고 싶다
   	
   	= script 영역을 만들고 type을 "text/template"으로 지정하면 템플릿 문자열로 인식
   	= script 영역에 id를 부여하여 불러와서 사용한다.
     -->
   <script id="list-board-template" type="text/template">
   	<div id="board-{{boardNo1}}|" class="board-cell col-6 bbxb">

                <div class="board-area row bbxb">
                    <!-- <div class="board-type col-12 bbxb"><small>{{boardCategoryName}}</small></div> -->
                    <div class="kk-bamboo-color board-title col-12 mt-2 bbxb"><a href = ${root}/board/boardDetail?boardNo={{boardNo2}}><b class="font-size-1p5 p-1">{{boardTitle}}</b></a></div>
                    <div class="baord-content col-12 p-2 px-4 bbxb"><a href = ${root}/board/boardDetail?boardNo={{boardNo3}}><small class="font-size-1p2 pl-1">{{boardContent}}</small></a></div>
                </div>

                <div class="writer-area row bbxb">
                    <div class="writer-info bbxb  ml-auto">
                        <small><span class="kk-bamboo-color font-size-1p1 pr-3"><b>{{memberNick}}</b></span></small>
                    </div>
                </div>

                <div class="info-area row bbxb mb-2">
                    <div class="view-count col-2 bbxb">
                        <i class="fas fa-mouse fa-1x">{{boardCount}}</i>
                    </div>

                    <div class="like-count col-2 bbxb">
                        <i class="far fa-thumbs-up fa-1x">{{likeCount}}</i>
                    </div>

                    <div class="like-count col-2 bbxb">
                        <i class="far fa-comment-dots fa-1x">{{commentsCount}}</i>
                    </div>

                    <div class="empty col-5 bbxb"></div>

                     <!--<div class="write-time-col-3 bbxb">-->
                         <!--<small><i class="far fa-clock">&nbsp;{{boardDate}}</i></small>-->
                    <!-- </div>-->
                </div>
            </div>

   </script>         
    <style>
        /* div{
        border: 1px red dotted;    
        } */

        .board-cell{
        border: #ffffff solid;
        background-color: #fafad0;
        }

        .board-title{
        font-weight: 700;
        }
        
       #wrap{
      text-align: left;
      }
      
	       .bbxb{
	   box-sizing: border-box;
	
	   }   
	   
	   .font-size-1p5{
	   font-size: 1.5em;
	   }
	   
	  .font-size-1p2{
	   font-size: 1.2em;
	   }
	   
   	  .font-size-1p1{
	   font-size: 1.1em;
	   }
	   
       .kk-bamboo-color{
       color: #1e3932;
       }    
    </style>
</head>
<!-- <button id="test-btn">TEST</button> -->

<h2>게시판 목록</h2>
<hr>
<div id="board-list" class="row">

	<div id="search-zone" class="offset-2 col-8 text-center">
<!-- boardNo?, boardTitle, boardContent, memberNick, 좋아요 수,  댓글 수?-->
	<c:if test="${boardType == 'company'}">
	<form action="${root}/board/boardList" method="get">
		<input type="hidden" name="type" value="companyBoard" class="form-control">
		<input type="text" name="keyword" required class="form-control" placeholder="회사 게시판에서 검색">
		<input type="submit" value="검색" class="btn btn-primary">
	</form>
	</c:if>
	
	<c:if test="${boardType == 'job'}">
	<form action="${root}/board/boardList" method="get">
		<input type="hidden" name="type" value="jobCategoryBoard" class="form-control">
		<input type="text" name="keyword" required class="form-control" placeholder="업종 게시판에서 검색">
		<input type="submit" value="검색" class="btn btn-primary">
	</form>
	</c:if>
	
	<c:if test="${boardType == 'boardCategory'}">
	<form action="${root}/board/boardList" method="get">
		<input type="hidden" name="type" value="boardCategoryBoard" class="form-control">
		<input type="hidden" name="boardCategoryNo" value="${boardCategoryNo}" class="form-control">
		<input type="text" name="keyword" required class="form-control" placeholder="에서 검색">
		<input type="submit" value="검색" class="btn btn-primary">
	</form>
	</c:if>
	</div>
</div>		


	


	<div id="here" class="offset-1 col10- row mt-5">	</div>
	
	

	



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
