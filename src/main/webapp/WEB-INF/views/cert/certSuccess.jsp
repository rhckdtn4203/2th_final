<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    
<style>
	#modiBack {
		height: 700px;
		padding-top: 30px;
		padding-bottom: 10px;
	}
	
	#aa {
		padding-bottom: 30px;
		margin-bottom: 0 0 60px 0;
	}
	
	#group-back {
		height: 240px;
	}

	#box-padding {
		padding:10px;
	}
</style>
    
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style4.css">
    
<section id="modiBox">
	<div class="modiBack" id="modiBack">
		<div id="modititle">
			<h3>인증에 성공하였습니다!</h3>	
		</div>
		
		<div>
			<button id="veri-btn" onclick="location.href='${pageContext.request.contextPath}/'">메인 페이지로</button>
		</div>
	</div>
</section>

<!-- ... 내용 들어가야 한다면 넣기 -->

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>