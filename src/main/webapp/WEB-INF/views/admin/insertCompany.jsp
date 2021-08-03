<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
	.title-text {
		font-size:23px;
		font-weight:bold;
		margin:15px;
	}
	
	.form-input {
		width:400px;
		padding:0.5rem;
		outline:none;
	}
	
	textarea.form-input {
		resize: vertical;
		min-height:150px;/*수치는 자유롭게 설정*/
		height:150px;/*수치는 자유롭게 설정*/
		max-height:500px;/*수치는 자유롭게 설정*/
	}
	
	.container {
		width:600px;
		text-align:center;
		margin: 0 auto;
	}
	
	.login-btn-box{
		background-color: var(--color-green);
		height: 40px;
	}
	
	.login-btn{
	  	position: relative;
	    margin: 5px;
	    border: none;
	    color: wheat;
	    background-color: var(--color-green);
	    font-size: 20px;
	    font-weight: var(--weight-6);
	    
	    cursor: pointer;
	    overflow: hidden;
	    text-transform: uppercase;
	    transition: 0.5s;
	}
	
	.text-center {
		text-align: center;
	}
	
	.table {
		width:100%;
	}
	
	.table > thead > tr > th, 
	.table > thead > tr > td,
	.table > tbody > tr > th,
	.table > tbody > tr > td,
	.table > tfoot > tr > th,
	.table > tfoot > tr > td {
		padding:0.5rem;
	}
</style>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap_reboot.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap_grid.css">

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
	
	$(document).ready(function(){ 
		  var fileTarget = $('#input-file'); 
		  fileTarget.on('change', function(){ // 값이 변경되면
		      var cur=$("input[type='file']").val();
		    $(".upload-name").val(cur);
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

<div class="container">
	<div class="title-text">
		<span>회사 등록하기</span>
	</div>
	
	<div style="border:1px solid black;">
		<form action="insertCompany" method="post" onsubmit="return submitCheck();" enctype="multipart/form-data">
			<table class="table">
				<tbody>
					<tr>
						<th>회사 이름</th>
						<td>
							<input type="text" name="companyName" class="form-input" value="${param.companyName}" placeholder="회사 이름" required>
						</td>
					</tr>
						
					<tr>
						<th>회사 홈페이지 URL</th>
						<td>
							<input type="text" name="companyUrl" class="form-input" placeholder="회사 홈페이지 URL" required>
						</td>
					</tr>
					
					<tr>
						<th>회사 메일 도메인 주소</th>
						<td>
							<input type="text" name="companyDomain" id="companyDomain" class="form-input" value="${param.companyDomain}" placeholder="회사 메일 도메인 주소" required>
						</td>
					</tr>
					
					<tr>
						<th>본사 주소</th>
						<td>
							<button type="button" id="execDaumPostcode" class="btn btn-outline-dark">주소 찾기</button>
							<input type="text" name="companyAddr" id="address" class="form-input" placeholder="본사 도로명 주소" required><br>
						</td>
					</tr>
					
					<tr>
						<th>산업 분류</th>
						<td>
							<input type="text" name="companyIndustry" class="form-input" placeholder="산업분류" required><br>
						</td>
					</tr>
					
					<tr>
						<th>설립일</th>
						<td>
							<input type="date" name="companyEstablishment" class="form-input" placeholder="설립일" required><br>
						</td>
					</tr>
					
					<tr>
						<th>회사 소개</th>
						<td>
							<textarea name="companyIntroduce" rows="15" class="text-right form-input"></textarea>
						</td>
					</tr>
					
					<tr>
						<th>회사 로고 이미지</th>
						<td>
							<label class="btn btn-outline-dark" for="input-file">파일 찾기</label>
							<input type="file" id="input-file" name="companyProfile" style="display:none">
							<input class="upload-name" value="파일선택">
						</td>
					</tr>
				</tbody>
			</table>
	
			<input type="hidden" name="companyRegistNo" value="${param.companyRegistNo}">
			
			<div class="login-btn-box">
				<input type="submit" value="추가하기" class="login-btn insert-btn">
			</div>
		</form>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>