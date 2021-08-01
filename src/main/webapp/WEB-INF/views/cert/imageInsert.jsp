<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

	<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<style>
    @media screen and (min-width:1200px){
        .test{
            color: royalblue;
        }
    }

    @media screen and (max-width:1199px){
        .test{
            color: red;   
        }
    }

    @media screen and (max-width:991px){
        .test{
            color: orange;
        }
        #board-type > small{
            font-size: 1.2rem;
        }
        #board-title > span{
            font-weight: 500 !important;
            font-size: 2.2rem;
        }

    }

    @media screen and (max-width:767px){
        .test{
            color: green;
        }

    }
    @media screen and (max-width:575px){
        .test{
            color: rgb(255, 0, 242);
        }
    }

    div{
    border: 1px red dotted;
    }

    #image-title{
    font-size: 2.5em;
    }

    #preview-image{
	width : 90%;
    }

    .cert-progress-msg-ing{
    font-size: 1.5em;
    color: rgb(255, 166, 0);
    }

    .cert-progress-msg-positive{
    font-size: 1.5em;
    color: rgb(16, 45, 141);
    }
    
    .cert-progress-msg-error{
    font-size: 1.5em;
    color: rgb(180, 45, 50);
    }

</style>

<script>
$(function(){
    $("#upload-idcard").change(function(){
        setImageFromFile(this, "#preview-image");
    });
    $("#upload-reset-btn").click(function(){
        $("#preview-image").attr("src", "${root}/img/image-cert-before.png" );
    })

function setImageFromFile(input, expression) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {

        	$(expression).attr("src", e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
    }
}
})
</script>
</head>

<body>

	<div id="image-cert-zone" class="row">
 		<div class="offset-3 col-6 row">
			<div class="col-12 image-title-area text-center">
				<div><p id="image-title" class="test">사원증 인증 페이지</p></div>
			</div>

  			<div class="offset-2 col-8">
				<div id="preview-div" class="mt-3 text-center">
					<c:if test="${imageCertProgress == 'didnt' || imageCertProgress == 'ing'}">
					<img src="${root}/img/image-cert-before.png" id="preview-image">
					</c:if>
					<c:if test="${imageCertProgress == 'reject'}">
						<img src="${root}/img/image-cert-reject.png" id="preview-image">
					</c:if>
				</div>

					<div class=""><br><br></div>
					
							<div class="text-center">
								<c:if test="${imageCertProgress == 'didnt'}">
									<form action="imageInsert"  id="file-upload" method="post" enctype="multipart/form-data">
										<div class="input-group">
											<div class="custom-file">
												<input id="upload-idcard" type="file" name="imageCertFile" class="custom-file-input" required accept=".jpg, .png">
												<label class="custom-file-label" for="inputGroupFile04">파일선택</label>
											</div>
<!-- 											<div class="job-category-no-select-div"> -->
<!-- 												<select name="jobCategoryNo" class="form-control" required> -->
<!-- 													<option>업종을 선택해주세요.</option> -->
<!-- 													<option value="1">고객서비스 전문가</option> -->
<!-- 													<option value="2">상품기획/HD 디자이너</option> -->
<!-- 													<option value="3">영업 전문가</option> -->
<!-- 													<option value="4">구매/물류/SCM 전문가</option> -->
<!-- 													<option value="5">마케팅/홍보 전문가</option> -->
<!-- 													<option value="6">경영지원/관리 전문가</option> -->
<!-- 													<option value="7">경영전략/사업기획/분석전문가</option> -->
<!-- 													<option value="8">해외영업/사업개발/마케팅</option> -->
<!-- 													<option value="9">IT 엔지니어</option> -->
<!-- 													<option value="10">IT 기획/매니지먼트 전문가</option> -->
<!-- 													<option value="11">품질관리/보증 전문가</option> -->
<!-- 													<option value="12">환경/안전/보건 전문가</option> -->
<!-- 													<option value="13">정보보안/IT 보안</option> -->
<!-- 													<option value="14">건축/공간 디자이너</option> -->
<!-- 													<option value="15">고객상담 전문가</option> -->
<!-- 													<option value="16">회계/세무/재무 전문가</option> -->
<!-- 													<option value="17">법무/지적재산권 전문가</option> -->
<!-- 												</select> -->
<!-- 											</div> -->
											<div class="input-group-append">
												<input id="upload-reset-btn" class="btn btn-warning" type="reset" value="초기화">
												<input id="upload-submit-btn" class="btn btn-primary" type="submit" value="보내기">
											</div>
										</div>
									</form>
												
									<p class="cert-progress-msg-positive col-12">사원증을 업로드 하시면</p>
									<p class="cert-progress-msg-positive col-12">빠른 시일 내에 인증을 도와 드립니다.</p>
								</c:if>
								<c:if test="${imageCertProgress == 'ing'}">
									<p class="cert-progress-msg-ing col-12">현재 심사중 입니다.</p>
									<p class="cert-progress-msg-ing col-12">조금만 더 기다려주세요</p>
								</c:if>
								<c:if test="${imageCertProgress == 'end'}">		
									<p class="cert-progress-msg-positive col-12">인증이 완료 되었습니다!</p>
									<p class="cert-progress-msg-positive col-12">감사합니다.</p>
								</c:if>
								<c:if test="${imageCertProgress == 'reject'}">
									<form action="imageInsertAgain"  id="file-upload" method="post" enctype="multipart/form-data">
										<div class="input-group">
											<div class="custom-file">
												<input id="upload-idcard" type="file" name="imageCertFile" class="custom-file-input" required accept=".jpg, .png">
												<label class="custom-file-label" for="inputGroupFile04">파일선택</label>
											</div>
<!-- 											<div class="job-category-no-select-div"> -->
<!-- 												<select name="jobCategoryNo" class="form-control" required> -->
<!-- 													<option>업종을 선택해주세요.</option> -->
<!-- 													<option value="1">고객서비스 전문가</option> -->
<!-- 													<option value="2">상품기획/HD 디자이너</option> -->
<!-- 													<option value="3">영업 전문가</option> -->
<!-- 													<option value="4">구매/물류/SCM 전문가</option> -->
<!-- 													<option value="5">마케팅/홍보 전문가</option> -->
<!-- 													<option value="6">경영지원/관리 전문가</option> -->
<!-- 													<option value="7">경영전략/사업기획/분석전문가</option> -->
<!-- 													<option value="8">해외영업/사업개발/마케팅</option> -->
<!-- 													<option value="9">IT 엔지니어</option> -->
<!-- 													<option value="10">IT 기획/매니지먼트 전문가</option> -->
<!-- 													<option value="11">품질관리/보증 전문가</option> -->
<!-- 													<option value="12">환경/안전/보건 전문가</option> -->
<!-- 													<option value="13">정보보안/IT 보안</option> -->
<!-- 													<option value="14">건축/공간 디자이너</option> -->
<!-- 													<option value="15">고객상담 전문가</option> -->
<!-- 													<option value="16">회계/세무/재무 전문가</option> -->
<!-- 													<option value="17">법무/지적재산권 전문가</option> -->
<!-- 												</select> -->
<!-- 											</div> -->
											<div class="input-group-append">
												<input id="upload-reset-btn" class="btn btn-warning" type="reset" value="초기화">
												<input id="upload-submit-btn" class="btn btn-primary" type="submit" value="보내기">
											</div>
										</div>
									</form>
									<span class="cert-progress-msg-error col-12">인증이 거절 되었습니다.</span><br>
									<span class="cert-progress-msg-error col-12">관리자에게 문의하시거나</span><br>
									<span class="cert-progress-msg-error col-12">정확한 사진을 보내주세요!</span><br>
									<c:if test="${imageCertMessage != ''}">
										사유: ${imageCertMessage}
									</c:if>
								</c:if>
							</div>
						

							
                    


			</div>
		</div>
        
		<div>


		</div>
		</div>
</html>