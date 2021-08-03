<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js" integrity="sha256-T0Vest3yCU7pafRw9r+settMBX6JkKN06dqBnpQ8d30=" crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/77858aaef8.js" crossorigin="anonymous"></script>

<style>
	img {
		float:left;
	}
	
	.title-box {
		text-align:left;
	}
	
	#title-text {
		font-size:23px;
		font-weight:700;
	}
	
	#title-text-box {
		padding-top:100px;
		margin-left:160px;
	}
	
	.one-star {
	  	color: #fff58c;
	 	padding: 0;
	 	z-index: 1;
	 	display: flex;
	  	left: 0;
	  	overflow: hidden;
	  	-webkit-text-fill-color: gold;
	  	float:left;
	}
	
	.company-button-box {
		font-size:20px;
		margin-top:20px;
		margin-left:-750px;
	}
	
	.rate-box {
		text-align:left;
		font-size:19px;
		font-weight:700;
		width:100%;
		margin-left:20px;
	}
	
	.part-rate-box {
		text-align:left;
		margin-left:20px;
	}
	
	.review-box {
		text-align:left;
		border:1px solid black;
		margin:20px;
		background-color:white;
	}
</style>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap_reboot.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap_grid.css">

<div class="container-1000">
	<div class="title-box">
		<img src="${pageContext.request.contextPath}/company/companyProfile?companyNo=${companyVO.companyNo}" width=150 height=150></img>
		
		<div id="title-text-box">
			<div id="title-text">
				<span>${companyVO.companyName}</span>
			</div>
		
			<div class="one-star">
				<span>★</span>
			</div>
			<span>${reviewRate}</span>
			<span>(${reviewCount}개의 리뷰)</span>
		</div>
	</div>
	
	<div class="company-button-box">
		<button type="button" class="btn btn-outline-dark" onclick="location.href='${pageContext.request.contextPath}/company/companyDetail?companyNo=${param.companyNo}'">소개</button>
		<button type="button" class="btn btn-outline-dark" onclick="location.href='${pageContext.request.contextPath}/company/companyReview?companyNo=${param.companyNo}'">리뷰</button>
	</div>
	
	<hr>
	
	<div>
		<div id="title-text" style="text-align:left; margin:20px 0px">
			<span>${companyVO.companyName} 게시글 인기순</span>
		</div>
		
		<div class="part-rate-box">
			<c:forEach var="companyKeywordListDto" items="${companyKeywordList}">
				<div style="margin-left:20px; margin-bottom:20px;">
					<p style="font-weight:bold">${companyKeywordListDto.boardTitle}</p>
					<p>${companyKeywordListDto.boardContent}</p>
					<i class="fas fa-mouse">${companyKeywordListDto.boardCount}</i>
					<i class="far fa-thumbs-up fa-1x">${companyKeywordListDto.likeCount}</i>
					<i class="far fa-comment-dots fa-1x bbxb">${companyKeywordListDto.commentsCount}</i>
					<i class="far fa-clock">${companyKeywordListDto.boardDate}</i>
				</div>
			</c:forEach>
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>