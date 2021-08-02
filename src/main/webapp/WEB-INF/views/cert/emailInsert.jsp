<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<<<<<<< HEAD
=======
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
>>>>>>> refs/remotes/origin/kangmijin

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
#modiBack {
	height: 700px;
	padding-top: 30px;
	padding-bottom: 10px;
}

<<<<<<< HEAD
#aa {
	padding-bottom: 30px;
	margin-bottom: 0 0 60px 0;
}

#group-back {
	height: 240px;
}
</style>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/style4.css">

<section id="modiBox">
	<div class="modiBack" id="modiBack">
		<div id="modititle">
			<h3>E-MAIL VERIFICATION</h3>
		</div>
		<figure class="snip1200">
			<div id="a">
				<img src="http://localhost:8080/khblind/img/img3.png"
					alt="backgroung-img" />
				<figcaption>
					<p>
						인증 후 정회원으로 등업하실 수 있습니다!<br> 만약 사내 메일이 없는 경우,<br> <span><button
								id="veri-btn">사원증인증</button></span>에서 진행하실 수 있습니다
					</p>
					<div class="heading">
						<h3>'이메일'로 회사인증</h3>
					</div>
				</figcaption>
		</figure>


		<div class="input-modiBox">
			<div id="group-back">
				<form action="emailInsert" method="post">
					<div class="group" id="aa">
						<label>E mail</label> <input type="text" name="email"
							placeholder="&nbsp메일 주소를 입력하세요" required class="sb">
					</div>

					<div class="login-btn-box">
						<input type="submit" value="인증 요청" class="login-btn">
					</div>
					<c:if test="${param.error != null}">
						<br>
						<span style="color: red;">메일 정보가 없는 회사입니다.</span>

					</c:if>
				</form>
			</div>

			<div class="move">
				<h5>
					<i class="far fa-building"></i>&nbsp우리회사를 밤부로!
				</h5>
				<a href="${pageContext.request.contextPath}/company/registCompany"
					id="delete-b"> <span>회사등록 신청</span></a>
			</div>

		</div>
</section>
=======
<form action="emailInsert" method="post">
	<input type="text" name="email" placeholder="인증할 메일 입력" required>
	<input type="submit" value="인증 요청">
	
	<c:if test="${param.error != null}">
		<br><span style="color:red;">메일 정보가 없는 회사입니다.</span>
		<br><span style="color:red;">메일 주소를 확인해주시고, 등록이 안된 회사라면 다음 방식을 이용해주십시오.</span>
		<br>
		<br><a href="#">사원증으로 인증하기</a>
		<br><a href="${pageContext.request.contextPath}/company/registCompany">회사 등록 신청하기</a>
	</c:if>
</form>
>>>>>>> refs/remotes/origin/kangmijin

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>