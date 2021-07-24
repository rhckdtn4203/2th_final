<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>

	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script>
		$(function() {
			$(".insert-btn").click(function() {
				window.alert("추가 완료");
			});
		});
		
		$(function(){
			//아이디 입력창의 input/blur 시점에 비동기통신을 이용하여 화면을 유지한 채로 중복검사 수행
			$("input[name=companyDomain]").blur(function(){
				//this : 입력창
				var companyDomain = $(this).val();
				var isTrue = false;
				
				if(isTrue) return;
				
				$.ajax({
					url:"${pageContext.request.contextPath}/admin/insertCompany",
					data:{
						companyDomain : companyDomain
					},
					type:"post",
					success:function(resp){ //"Y"는 없는 도메인, "N"은 이미 존재하는 도메인으로 처리
						if(resp === "Y") {
							$("input[name=companyDomain] + span").text("등록 가능한 회사 메일 주소입니다.");
							isTrue = true;
						}
						else if(resp === "N"){
							$("input[name=companyDomain] + span").text("이미 존재하는 회사 메일 주소입니다.");
						}
					}
				});
				
			});		
		});
	</script>
	
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		$(document).ready(function() {
			$("#execDaumPostcode").on("click", function() {
				 new daum.Postcode({
					 oncomplete: function(data) {
						 var addr = ''; // 주소 변수
							
				         //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				         if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
				        	 addr = data.roadAddress;
				         } else { // 사용자가 지번 주소를 선택했을 경우(J)
				             addr = data.jibunAddress;
				         }
						 
						 $("#address").val(addr);
					 }
				 }).open();
			});
		});
	</script>
	
</head>
<body>
    
	<h1>회사 추가 페이지</h1>
	
	<form action="insertCompany" method="post">
		<input type="text" name="companyName" value="${param.companyName}" placeholder="회사 이름" required>
		<input type="text" name="companyUrl" placeholder="회사 홈페이지 URL" required>
		<input type="text" name="companyDomain" value="${param.companyDomain}" placeholder="회사 메일 도메인 주소" required>
		<span></span>
		<br><br>
		<input type="button" id="execDaumPostcode" value="주소 찾기"><br>
		<input type="text" name="companyAddr" id="address" placeholder="본사 도로명 주소" required><br>
		<br>
		<input type="submit" value="추가하기" class="insert-btn">
	</form>

</body>