<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	$(function() {
		$(".insert-btn").click(function() {
			alert("신청 완료");
		});
	});
</script>

<style>
/* #modiBack {
	height: 700px;
	padding-top: 30px;
	padding-bottom: 10px;
}

#aa {
	padding-bottom: 30px;
	margin-bottom: 0 0 60px 0;
}

<<<<<<< HEAD
#group-back {
	height: 240px;
} */
	#modiBack{
		height: 650px;
		padding-bottom: 5px;
	}
</style>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style4.css">

<section id="modiBox">
	<div class="modiBack" id="modiBack">
		<div id="modititle">
			<h3>APPLY FOR YOUR COUMPANY</h3>
		</div>
		<figure class="snip1200">
			<div id="a">
				<img src="http://localhost:8080/khblind/img/img4.png"
					alt="backgroung-img" />
				<figcaption>
					<p>
						회사 정보가 등록되지 않은 경우 등록 신청이 가능합니다.<br> 
					요청하신 회사는 검증절차를 거친  후 평균 2일 이내 등록됩니다</p>
					<div class="heading">
						<h3>회사 신청하기</h3>
					</div>
				</figcaption>
			</div>
		</figure>

		<div class="input-modiBox">
			<div id="group-back">
				<form action="registCompany" method="post">
					<div class="group" id="aa">
						<label></label> 회사명 <input type="text" name="companyRegistName"
							 required class="sb">
					</div>
					<div class="group" id="aa">
						<label>E mail</label> <input type="text" name="companyRegistDomain"
							placeholder="&nbsp사내 이메일 주소" required class="sb">
					</div>

					<div class="login-btn-box insert-btn">
						<input type="submit" value="신청하기" class="login-btn">
					</div>
			
				</form>
			</div>


		</div>
	</div>
</section>

<form action="registCompany" method="post">
	<input type="text" name="companyRegistName" placeholder="회사 이름">
	<input type="text" name="companyRegistDomain" placeholder="회사 이메일 주소">
	<input class="insert-btn" type="submit" value="신청하기">
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
