<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>

	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script>
		function submitCheck() {
			var regexp = /^@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
			var result = regexp.test($("#companyDomain").val());

			if(result) {
				alert("추가 완료");
				return true;
			}
			else {
				alert("입력한 항목이 제대로 작성되었는지 확인바랍니다.");
				return false;
			}
		};
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
	
	<form action="insertCompany" method="post" onsubmit="return submitCheck();" enctype="multipart/form-data">
		<input type="hidden" name="companyRegistNo" value="${param.companyRegistNo}">
		<input type="text" name="companyName" value="${param.companyName}" placeholder="회사 이름" required>
		<input type="text" name="companyUrl" placeholder="회사 홈페이지 URL" required>
		<input type="text" name="companyDomain" id="companyDomain" value="${param.companyDomain}" placeholder="회사 메일 도메인 주소" required>
		<span></span>
		<br><br>
		<input type="button" id="execDaumPostcode" value="주소 찾기"><br>
		<input type="text" name="companyAddr" id="address" placeholder="본사 도로명 주소" required><br>
		<br><br>
		<input type="text" name="companyIndustry" placeholder="산업분류" required><br>
		<input type="date" name="companyEstablishment" placeholder="설립일" required><br>
		<input type="text" name="companyIntroduce" placeholder="회사소개" required><br>
		<br><br>
		<input type="file" name="companyProfile">
		<input type="submit" value="추가하기" class="insert-btn">
	</form>

</body>