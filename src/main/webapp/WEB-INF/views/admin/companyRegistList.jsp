<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
		width:1000px;
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
	
	th, td {
		border:1px solid black;
	}
</style>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap_reboot.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap_grid.css">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	$(function() {
		$(".companyRegistDelete").click(function() {
			var chk = confirm("정말 삭제하시겠습니까?");
			if (chk) {
				var companyRegistNo = $(this).parents("tr").children().eq(0).text();
				location.href='companyRegistList/delete?companyRegistNo='+companyRegistNo;
			}
		});
	});

	$(function() {
		$(".companyRegist").click(function(){
			var companyRegistNo = $(this).parents("tr").children().eq(0).text();
			var companyRegistName = $(this).parents("tr").children().eq(1).text();
			var companyRegistDomain = $(this).parents("tr").children().eq(2).text();

			$.ajax({
				url:"${pageContext.request.contextPath}/admin/companyRegistList",
				data:{
					companyRegistName : companyRegistName
				},
				type:"post",
				success:function(resp) { //"Y"는 없는 도메인, "N"은 이미 존재하는 도메인으로 처리
					if(resp === "Y") {
						location.href='insertCompany?companyRegistNo='+companyRegistNo+
						'&companyName='+companyRegistName+
						'&companyDomain='+companyRegistDomain;
					}
					else if(resp === "N"){
						alert("이미 존재하는 회사입니다");
					}
				}
			});
		});
	});
</script>

<div class="container">
	<div class="title-text">
		<span>회사 신청 목록보기</span>
	</div>
	
	<div>
		<form action="reviewWrite" method="post">
			<table class="table">
				<thead>
					<tr>
						<th>번호</th>
						<th>회사 이름</th>
						<th>회사 주소</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="companyRegistDto" items="${list}">
						<tr>
							<td>${companyRegistDto.companyRegistNo}</td>
							<td>${companyRegistDto.companyRegistName}</td>
							<td>${companyRegistDto.companyRegistDomain}</td>
							<td>
								<button type="button" class="btn btn-outline-dark companyRegist" name="companyRegist">등록</button>
								<button type="button" class="btn btn-outline-dark companyRegistDelete" name="companyRegistDelete">삭제</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</form>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>