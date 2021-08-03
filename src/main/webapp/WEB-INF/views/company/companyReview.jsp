<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>
	$(function(){
		var pixel = ${reviewRate} * 20;
		$('#start-percent').width(pixel+'%');
	});
</script>

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
		margin-left:-700px;
	}
	
	.star-ratings {
	  color: #aaa9a9; 
	  position: relative;
	  unicode-bidi: bidi-override;
	  width: max-content;
	  -webkit-text-fill-color: transparent; /* Will override color (regardless of order) */
	  -webkit-text-stroke-width: 1.3px;
	  -webkit-text-stroke-color: #2b2a29;
	}
	 
	.star-ratings-fill {
	  color: #fff58c;
	  padding: 0;
	  position: absolute;
	  z-index: 1;
	  display: flex;
	  top: 0;
	  left: 0;
	  overflow: hidden;
	  -webkit-text-fill-color: gold;
	}
	 
	.star-ratings-base {
	  z-index: 0;
	  padding: 0;
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
		<button type="button" class="btn btn-outline-dark" onclick="location.href='${pageContext.request.contextPath}/company/companyBoard?companyNo=${param.companyNo}'">게시글</button>
		<c:if test="${grade > 2}">
			<button type="button" class="btn btn-outline-dark" onclick="location.href='${pageContext.request.contextPath}/company/reviewWrite?companyNo=${param.companyNo}'">리뷰 작성하기</button>
		</c:if>
	</div>
	
	<hr>
	
	<div>
		<div id="title-text" style="text-align:left; margin:20px 0px">
			<span>${companyVO.companyName} 리뷰</span>
		</div>
	
		<div class="rate-box">
			<div class="star-ratings">
				<div class="star-ratings-fill" id="start-percent">
					<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
				</div>
				<div class="star-ratings-base">
					<span>★</span><span>★</span><span>★</span><span>★</span><span>★</span>
				</div>
			</div>
			
			<div>
				<span>${reviewRate}</span>
				<span>(${reviewCount}개의 리뷰)</span>
			</div>
		</div>
		
		<div class="part-rate-box">
			<c:forEach var="reviewCountList" items="${reviewCountList}" varStatus="status">
				<span>${5-status.index}</span>
				<div class="one-star">
					<span>★</span> 
				</div>
				<span> 
					<c:forEach var="count" items="${reviewCountList}">
						<c:if test="${count.key != 'RATE' && reviewCount != 0}">
							${count.value}개 (${(count.value * 100) / reviewCount} %)
						</c:if>
					</c:forEach>
				</span><br>	
			</c:forEach>
		</div>
	</div>
	
	<hr>
	
	<div>
		<c:choose>
			<c:when test="${grade == 1}">
				<div>
					<p>회원 플러스 또는 정회원이 되어 전체 리뷰를 확인하세요!</p>
					<button type="button" class="btn btn-outline-dark" onclick="location.href='${pageContext.request.contextPath}/pay/upgrade'">회원 플러스 결제하기</button>
					<button type="button" class="btn btn-outline-dark" onclick="location.href='${pageContext.request.contextPath}/cert/emailInsert'">정회원 인증하기</button>
				</div>
			</c:when>
			<c:otherwise>
				<c:forEach var="reviewMemberCategoryVO" items="${list}">
					<div class="review-box">
						<div style="font-size:18px; font-weight:700; margin:10px;">
							<div class="one-star">
								<span>★</span> 
							</div>
							<span>${reviewMemberCategoryVO.reviewRate}</span>
							<span>" ${reviewMemberCategoryVO.reviewTitle} "</span>
						</div>
						
						<div style="font-size:14px; color:gray; margin-left:20px; margin-bottom:20px;">
							<span>${reviewMemberCategoryVO.memberNick} ·</span>
							<span>${reviewMemberCategoryVO.jobCategoryName} ·</span>
							<span>${reviewMemberCategoryVO.reviewDate}</span>
						</div>
						
						<div style="margin-left:20px; margin-bottom:20px;">
							<p style="font-weight:bold">장점</p>
							<span>${reviewMemberCategoryVO.reviewMerit}</span>
							<p style="font-weight:bold">단점</p>
							<span>${reviewMemberCategoryVO.reviewDemerit}</span>
						</div>
					</div>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>