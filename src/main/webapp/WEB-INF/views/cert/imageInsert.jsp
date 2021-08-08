<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

	<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

    <!-- 제이쿼리를 가져온다 -->
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <!-- UI제이쿼리를  가져온다 -->
    <script  src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"  integrity="sha256-T0Vest3yCU7pafRw9r+settMBX6JkKN06dqBnpQ8d30="   crossorigin="anonymous"></script>
    <!-- 폰트어썸 아이콘을 가져온다-->
    <script src="https://kit.fontawesome.com/77858aaef8.js" crossorigin="anonymous"></script>
  	

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap_reboot.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap_grid.css">
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
    #image-title{
    font-size: 1.8em;
    }
    #preview-image{
	width : 90%;
    }
    .cert-progress-msg-ing{
    font-size: 1.2em;
    color: rgb(255, 140, 0);
    }
    .cert-progress-msg-positive{
    font-size: 1.2em;
    color: rgb(16, 45, 141);
    }
    
    .cert-progress-msg-error{
    font-size: 1.2em;
    color: rgb(220, 70, 70);
    }
    
    .cert-progress-msg-error-message{
    font-size: 1.0em;
    color: rgb(220, 70, 70);
    }
    
	.font-color-khblind-gold {
	color: #eee8aa;
	}
	
	.primary-background-color {
	background-color: #1e3932;
	}
	
	.bbxb{
	box-sizing: border-box;
	}  
	.z{
	font-family: 'Raleway', Arial, sans-serif;
    position: absolute;
    top: 10px;
    left: -65px;
    overflow: hidden;
    margin: 0px;
    width: 132%;
    height:650px;
    background: bisque;
    color: #1e3932;
    /* text-align: center; */
    box-shadow: 0 0 5px rgb(0 0 0 / 15%);
    font-size: 16px;
    border-radius: 1em;
	}
	
	.kk-color-1{
	background-color : rgb(237, 245, 128);
	}
	
	.kk-color-2{
	background-color : #29bb55;
	}
	
	.empty-div{
	height: 50px;
	}
	
	#wrap{
    height: 1300px !important;
	}
	
	#modiBox {
    height: 75% !important;
    }
    
    body{
    height: 1400px !important;
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
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/style4.css">

<section id="modiBox">
	<div class="modiBack" id="modiBack">
		<div id="modititle">
			<h3>ID-CARD VERIFICATION</h3>
		</div>
		<figure class="snip1200">
			<div id="a">
				<img src="http://localhost:8080/khblind/img/img3.png"
				alt="backgroung-img" />
				<figcaption>
					<p>
					사원증 인증 후 정회원으로 등업하실 수 있습니다! <br> 만약 사내 메일이 있는 경우,<br><span><button id="veri-btn">
					이메일 인증</button></span>에서 진행하실 수 있습니다
					</p>
					<div class="heading">
						<h3>'사원증'으로 회사인증</h3>
					</div>
				</figcaption>
			</div>
		</figure>
		
		<div class="input-modiBox">
			<div id="group-back">
				<c:if test="${imageCertProgress == 'didnt'}">
					<div class="form-area" class="mb-5">
						<form action="imageInsert"  id="file-upload" method="post" enctype="multipart/form-data">
							<div class="custom-file">
								<input id="upload-idcard" type="file" name="imageCertFile" class="custom-file-input mb-3" required accept=".jpg, .png">
								<label class="custom-file-label" for="inputGroupFile04">파일을 선택해주세요</label>
								<div id="btn-zone" >
								<div class="login-btn-box mt-3">
              						<input type="submit" value="보내기" class="login-btn">
            					</div>
								</div>
							</div>
						</form>
					</div>
					<div class="empty-div"></div>
				</c:if>
				
				<c:if test="${imageCertProgress == 'ing'}">
					<p class="cert-progress-msg-ing col-12"><b>현재 심사중 입니다.</b></p>
					<p class="cert-progress-msg-ing col-12"><b>조금만 더 기다려주세요</b></p>
				</c:if>
				
				<c:if test="${imageCertProgress == 'end'}">		
					<p class="cert-progress-msg-positive col-12"><b>인증이 완료 되었습니다!</b></p>
					<p class="cert-progress-msg-positive col-12"><b>감사합니다.</b></p>
				</c:if>
				<c:if test="${imageCertProgress == 'reject'}">
					<p class="cert-progress-msg-error col-12"><b>인증이 거절 되었습니다.</b></p>
					<p class="cert-progress-msg-error-message"><b>사유: </b>
						<c:if test="${imageCertMessage != ''}"><b>${imageCertMessage}</b></c:if>
					</p>
					
					<div class="form-area" class="mb-5">
						<form action="imageInsertAgain"  id="file-upload" method="post" enctype="multipart/form-data">
							<div class="custom-file">
								<input id="upload-idcard" type="file" name="imageCertFile" class="custom-file-input bbxb" required accept=".jpg, .png">
								<label class="custom-file-label" for="inputGroupFile04">파일을 선택해주세요</label>
								<div id="btn-zone" >
								<div class="login-btn-box mt-3">
              						<input type="submit" value="보내기" class="login-btn">
            					</div>
								</div>
							</div>
						</form>
					</div>
				</c:if>

			<!-- 사진 -->
				<c:if test="${imageCertProgress == 'didnt' || imageCertProgress == 'ing'}">
					<img src="${root}/img/image-cert-before.png" id="preview-image">
				</c:if>
				<c:if test="${imageCertProgress == 'reject'}">
					<img src="${root}/img/image-cert-reject.png" id="preview-image">
				</c:if>
				<c:if test="${imageCertProgress == 'end'}">
					<img src="${root}/img/image-cert-end.png" id="preview-image">					
				</c:if>
			<!-- 사진 끝 -->			
			


						


			</div>
		</div>
	</div>
</section>

        
		<div>


		</div>
</html>
	<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
</html>
