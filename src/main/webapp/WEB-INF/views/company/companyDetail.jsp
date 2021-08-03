<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

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
	
	.company-detail-label {
		width:17%;
		text-align:right;
		float:left;
		font-weight:700;
	}
	
	.company-detail-content {
		width:30%;
		text-align:left;
		float:left;
		margin-left:10px;
	}
	
	#company-introduce {
		float:left; 
		text-align:left; 
		margin-top:20px;
		margin-left:140px;
		margin-right:140px;
		font-size:14px;
	}
	
	.company-button {
		padding:10px 0px;
		transition: box-shadow 300ms ease-in-out, color 300ms ease-in-out;
		&:hover {
			box-shadow: 0 0 40px 40px $black inset;
		}
	}
	
</style>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style4.css">
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
		<button type="button" class="btn btn-outline-dark" onclick="location.href='${pageContext.request.contextPath}/company/companyReview?companyNo=${param.companyNo}'">리뷰</button>
		<button type="button" class="btn btn-outline-dark" onclick="location.href='${pageContext.request.contextPath}/company/companyBoard?companyNo=${param.companyNo}'">게시글</button>
	</div>
	
	<hr>

	<div>
		<div id="title-text" style="text-align:left; margin:20px 0px">
			<span>${companyVO.companyName} 회사 소개</span>
		</div>
	
		<div class="company-detail-label">
			<span>홈페이지</span>
		</div>
		<div class="company-detail-content">
			<span>${companyVO.companyUrl}</span>
		</div>
		<div class="company-detail-label">
			<span>업계</span>
		</div>
		<div class="company-detail-content">
			<span>${companyVO.companyIndustry}</span>
		</div>
		<div class="company-detail-label">
			<span>본사</span>
		</div>
		<div class="company-detail-content">
			<span>${companyVO.companyAddr}</span>
		</div>
		<div class="company-detail-label">
			<span>설립일</span>
		</div>
		<div class="company-detail-content">
			<span>${companyVO.companyEstablishment}</span>
		</div>

		<div id="company-introduce">
			<span>${companyVO.companyIntroduce}</span>
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>