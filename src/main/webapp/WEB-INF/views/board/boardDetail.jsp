<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

 <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<script>
$(function(){

   $(".notLogin").click(function(e){
      e.preventDefault()
      window.alert("로그인이 필요한 기능입니다")
      });
   });

</script>
<script>
//대댓글 입력창 클릭시 대댓글 입력창 추가 스크립트
$(function(){
	$(".nestedComment-area").hide();
	$(".nestedComment-btn").click(function(){
   var originCmtNo= $(this).attr("id");
   console.log(originCmtNo);

	$("#comment-id-"+originCmtNo).show();
   
   
// 				$("#comment-id-"+originCmtNo).submit(function(){
// 				   $("#comment-id-"+originCmtNo).hide();
// 				});
   });

});
   </script>
<style>
div{
border: 1px red dotted;
}
</style>

<div>
	<div>
		<p>글번호 : ${boardDto.boardNo}</p>
	</div>
	<div>
		<p>${boardDto.memberNo}</p>
		<!-- memberNo가 아니라 닉네임 or 아이디를 띄어 줘야 함 --> 
		<p>${boardMemberVO.memberNick}</p>
	</div>
	<div>
		<p>${boardDto.boardTitle}</p>
	</div>
	<div>	
		<p>${boardDto.boardContent}</p>
	</div>
		<p>${boardDto.boardCount}</p>
		<p>${boardDto.boardDate}</p>
</div>
<!-- 글쓰기 탭은 header에 있음 -->          <!-- 현재 글번호 전달하여, 현재글의 수정페이지 이동 -->
<a href="${root}/board/boardEdit?boardNo=${boardDto.boardNo}">수정</a>
<a href="${root}/board/boardDelete?boardNo=${boardDto.boardNo}">삭제</a> 
<a href="#">목록</a>   

<!-- 좋아요를 클릭한상태 -->

<c:if test="${isLiked == 1}">
<a class="board_unlike_btn" href="${root}/board/boardLikeInsert?boardNo=${boardDto.boardNo}">
<i class="far fa-thumbs-up fa-3x"></i></a>
</c:if>
<c:if test="${isLiked == 2}">
<a class="deleteLike" href="${root}/board/boardUnLikeInsert?boardNo=${boardDto.boardNo}"><i class="fas fa-thumbs-up fa-3x"></i></a>
</c:if>
<c:if test="${empty dtoss}">
<div class="notLogin">
<i class="far fa-thumbs-up fa-3x"></i>
</div>
</c:if>

<!-- <form class="boardLikeDeleteForm" action="boardLike" -->


<!-- <form class="boardLikeInsertForm" action="boardLikeInsert"> -->
<!-- <input type="hidden" name ="board_no"> -->
<!-- </form>  -->


<!-- 비어있는 하트를 누르면  bookmarkInsert를 실행하게하기 -->
<c:if test="${isMarked == 1}">
<a href="${root}/board/bookmarkInsert?boardNo=${boardDto.boardNo}"><i class="far fa-heart"></i></a>
</c:if>

<c:if test="${isMarked == 2}">
<!-- 차있는 하트를 누르면 bookmarkDelete를 실행하게 하기 -->
<a href="${root}/board/bookmarkDelete?boardNo=${boardDto.boardNo}"><i class="fas fa-heart"></i></a>
</c:if>
<c:if test="${empty dtoss}">
<div class="notLogin">
<i class="far fa-heart"></i>
</div>
</c:if>


<!-- 댓글영역 -->

<!-- 댓글 전체영역을 감싸는  div-->
<div>
<!-- 원댓글 작성부분 -->
<form action="commentInsert" method="post">
<input type="hidden" name="boardNo" value="${boardDto.boardNo}">
<textarea name="commentsContent"></textarea>
<input type="submit">
</form>

<!-- 원댓글 출력부분 -->
   <c:forEach var="commentsVO" items="${commentsList}">
<div>
   <p>${commentsVO.commentsContent}</p>
   <p>${commentsVO.commentsMemberName}</p>
   <p>${commentsVO.commentsDate}</p>
   <button id="${commentsVO.commentsNo}" class= "nestedComment-btn">댓글달기</button>
</div>
<!-- 대댓글 입력부분 -->
<div class="nestedComment-area" id="comment-id-${commentsVO.commentsNo}">
<form action="nestedCommentInsert">
   <input type="hidden" name="superNo" value="${commentsVO.commentsNo}">
   <input type="hidden" name="boardNo" value="${boardDto.boardNo}">
   <textarea name="commentContent"></textarea>
   <input type="submit">
</form>
</div>
</c:forEach>

</div>
<!-- 대댓글 출력부분 -->
   <c:forEach var="commentsVO" items="${commentsList}">
<div>
   <p>${commentsVO.commentsContent}</p>
   <p>${commentsVO.commentsMemberName}</p>`
   <p>${commentsVO.commentsDate}</p>
   
</div>
</c:forEach>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>