<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
	.my-board-list {
		margin: 0;
		padding:0;
		list-style: none;
		border:1px solid black;
	}
	.my-board-list > li{
		padding:0.5rem;
	}
	.my-board-list > li:nth-child(2n) {
		background-color:rgba(0, 0, 0, 0.1);
	}
	.my-board-list > li > a{
		text-decoration: none;
		color:black;
	}
	.my-board-list > li > a:hover{
		color:red;
	}
</style>

<script>
	$(function(){
		$("#confirm-link").click(function(e){
			
			//var message=$(this).attr("data-message")||"이동하시겠습니까?";
			var choice = window.confirm("정말 탈퇴하시겠습니까?");
			if(!choice){
			e.preventDefault();				
			}
		});
	}); 

</script>

<script>

/* function deleteCheck(){
	if(window.confirm("정말 탈퇴하시겠습니까?")==true){
		return;
	}
	else{
		return false;
	}
} */
</script>

<div class="container-600">
	<div class="row">
		<h2>나의 정보</h2>
	</div>
	<div class="row">
			<table class="table table-border">
				<tr>
					<th>아이디:</th>
					<td>${dtoss.memberId}</td>
				</tr>
				<tr>
					<th>닉네임:</th>
					<td>${dtoss.memberNick}</td>
				</tr>
			
				<tr>
					<th>전화번호:</th>
					<td>${dtoss.memberPhone}</td>
				</tr>
				<tr>
					<th>이메일:</th>
					<td>${dtoss.memberEmail}</td>
				</tr>
				<tr>
			
			</table>
	</div>
	
	<!-- 이용 가능한 메뉴 구성 -->
	<div class="row">

		<c:if test="${dtoss.gradeNo == 1 || dtoss.gradeNo == 2}">
			<a href="${pageContext.request.contextPath}/cert/emailInsert" class="link-btn">이메일 인증</a>
		</c:if>
		<a href="${pageContext.request.contextPath}/member/change_pw" class="link-btn">비밀번호 변경</a>

		<a href="${pageContext.request.contextPath}/member/changeinfo" class="link-btn">개인정보 변경</a>
		<a href="${pageContext.request.contextPath}/member/exit" class="link-btn" id="confirm-link" onclick="deleteCheck">회원 탈퇴</a>
	
	</div>
	
	<div class="row text-left">
		<h4>내가 작성한 게시글</h4>
	</div>
	<div class="row text-left">
		<ul class="my-board-list">
			<c:forEach var="boardListDto"  items="${boardList}">
				<li>
					<a href="${pageContext.request.contextPath}/board/boardDetail.jsp?boardNo=${boardListDto.boardNo}"></a>
				</li>
			</c:forEach>
		</ul>
	</div>
	
	<div class="row text-left">
		<h4>내가 좋아요한 게시글</h4>
	</div>
	<div class="row text-left">
		<ul class="my-board-list">
			<c:forEach var="boardListDto" items="${boardList}">
				<li>
					<a href="${pageContext.request.contextPath}/board/boardDetail.jsp?boardNo=${boardListDto.boardNo}">
					</a>
				</li>
			</c:forEach>
		</ul>
	</div>
</div>


<script>

function preventClick(e){
	e.preventDefalut()
}
</script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>




