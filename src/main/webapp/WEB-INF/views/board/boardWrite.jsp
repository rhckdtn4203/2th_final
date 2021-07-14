<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="${root}/css/common.css">
	<link rel="stylesheet" type="text/css" href="${root}/css/menu.css">
	<link rel="stylesheet" type="text/css" href="${root}/css/layout.css">
	<link rel="stylesheet" type="text/css" href="${root}/css/test.css">
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			$('.s1').hide();
			$('.s0').change(function(){
				$('.s1').hide();
				$('.s'+$(this).val()+'').show();
			})
		});
	</script>
	
</head>	
<body>
	<main>
		<header>
			
		</header>
		<nav>
			<!-- 메뉴 -->
			<ul class="menu">
				<li>
					<a href="${root}/board/boardWrite">홈</a>
				</li> 
				<li>
					<a href="#">기업 리뷰</a>
				</li>
			</ul>
		</nav>
		
		<h2>게시글 등록</h2>
		
		<form action="boardWrite" method="post">
		
				<h3>등록 위치 선택</h3>
				<!-- 토픽을 클릭하면 다른 select가 뜨게 됌 -->
					<select class="s0">
						<option value="1">토픽</option>
						<option>내 회사</option>
						<option>업종</option>
					</select>
					
					<select class="s1">
						<option>토픽을 선택해주세요</option><!-- 나중에 토픽들 다 뜨도록 반복문 처리해야 함 -->
						<option>여행</option>
						<option>회사 생활</option>
					</select>
			<br><br>	
					
			제목 : <input type="text" name="boardTitle" required>
			<br><br>
			내용 : <textarea name="boardContent" required></textarea>
			<br><br>
			<!-- 해시태그수정후 작성  -->
<!-- 			해시태그  : <input type="text" name="boardHashtag"> -->
			<br><br>
			<input type="submit" value="등록">
		</form>
	</main>	
	</body>
</html>