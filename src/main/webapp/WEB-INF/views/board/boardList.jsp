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
            <!-- 부트스트랩을 가져온다 -->
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
            <!-- 제이쿼리를 가져온다 -->
            <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
            <!-- UI제이쿼리를  가져온다 -->
            <script  src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"  integrity="sha256-T0Vest3yCU7pafRw9r+settMBX6JkKN06dqBnpQ8d30="   crossorigin="anonymous"></script>
            <!-- Popper를 가져온다 -->
            <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.9.2/umd/popper.min.js" integrity="sha512-2rNj2KJ+D8s1ceNasTIex6z4HWyOnEYLVC3FigGOmyQCZc2eBXKgOxQmo3oKLHyfcj53uz4QMsRCWNbLd32Q1g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
            <!-- 폰트어썸 아이콘을 가져온다-->
            <script src="https://kit.fontawesome.com/77858aaef8.js" crossorigin="anonymous"></script>
            <!-- 부트와치를 가져온다.-->
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.5.2/dist/flatly/bootstrap.min.css" integrity="sha384-qF/QmIAj5ZaYFAeQcrQ6bfVMAh4zZlrGwTPY7T/M+iTTLJqJBJjwwnsE5Y0mV7QK" crossorigin="anonymous">
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
 				boardKeyword : "${boardKeyword}"
 				},
 				
	  		success: function(resp) {
	  			console.log(resp)
	  			console.log(resp.length);
	  			for(var i=0; i < resp.length; i++){
	  				var template = $("#list-board-template").html();
	  				template = template.replace("{{boardNo}}", resp[i].boardNo);
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
 		       
 		       	if(rate>75){
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
 			 				boardKeyword : "${boardKeyword}"
 		       				},
 		       				
 			       		success: function(resp) {
 			       			console.log(resp)
 			       			console.log("길이" + resp.length);
 			       			for(var i=0; i < resp.length; i++){
 			       				var template = $("#list-board-template").html();
 			       				template = template.replace("{{boardNo}}", resp[i].boardNo);
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
   	<div id="board-{{boardNo}}|" class="board-cell col-6">

                <div class="board-area row">
                    <!-- <div class="board-type col-12"><small>{{boardCategoryName}}</small></div> -->
                    <div class="board-title col-12 mt-2"><b>{{boardTitle}}</b></div>
                    <div class="baord-content col-12 p-2 px-4"><small>{{boardContent}}</small></div>
                </div>

                <div class="writer-area row">
                    <div class="writer-info">
                        <small><span>{{memberNick}}</span></small>
                    </div>
                </div>

                <div class="info-area row">
                    <div class="view-count col-2">
                        <small><i class="fas fa-mouse fa-1x">{{boardCount}}</i></small>
                    </div>

                    <div class="like-count col-2">
                        <small><i class="far fa-thumbs-up fa-1x">{{likeCount}}</i></small>
                    </div>

                    <div class="like-count col-2">
                        <small><i class="far fa-comment-dots fa-1x">{{commentsCount}}</i></small>
                    </div>

                    <div class="empty col-5"></div>

                    <div class="write-time-col-3">
                        <small><i class="far fa-clock">&nbsp;{{boardDate}}</i></small>
                    </div>
                </div>
            </div>

   </script>         
    <style>
        /* div{
        border: 1px red dotted;    
        } */

        .board-cell{
        border-bottom: #f2f2f3 solid;
        }

        .board-title{
        font-weight: 700;
        }
        
       #wrap{
      text-align: left;
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


	


	<div id="here" class="offset-3 col-6 row mt-5">
	</div>
	
	

	



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
