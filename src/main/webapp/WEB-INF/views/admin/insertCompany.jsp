<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>jQuery</title>

	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script>
		$(function() {
			// 지금은 unique 조건이 없어서..
			$(".insert-btn").click(function() {
				window.alert("추가 완료");
			});
		});
	</script>
	
</head>
<body>
    
	<h1>회사 추가 페이지</h1>
	
	<form action="insertCompany" method="post">
		<input type="text" name="companyName" placeholder="회사 이름" required>
		<input type="text" name="companyUrl" placeholder="회사 홈페이지 URL" required>
		<input type="text" name="companyDomain" placeholder="회사 메일 도메인 주소" required>
		<input type="text" name="companyAddr" placeholder="본사 도로명 주소" required>
		<input type="submit" value="추가하기" class="insert-btn">
	</form>

</body>