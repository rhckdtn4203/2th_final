<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script  src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"  integrity="sha256-T0Vest3yCU7pafRw9r+settMBX6JkKN06dqBnpQ8d30="   crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/77858aaef8.js" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap_reboot.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap_grid.css">

<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
    <style>
		#image-frame{
		width : 450px;
		height : 450px;
		}

        .primary-background-color {
	    background-color: #1e3932;
        }   
        .frame{
        height: auto;
        }

        .font-color-khblind-gold {
	        color: #eee8aa;
        }

        .font-size-1p2 {
	        font-size: 1.2rem;
        }
        
       .font-size-1p0 {
	        font-size: 1.0rem;
        }

		.modiBack {
		    width: 70% !important;
		    height: 720px !important;
		}
		
		body{
    	height: 134% !important;
		}
		
		#a{
		    width: 100% !important;
    		height: 75px !important;
    		left: 0 !important;
		}
		
		.image-crop{
		overflow: hidden;
		}
		
        .bbxb{
		box-sizing: border-box;
		}
	
		.bgcolor-bq{
		background-color: bisque;
		}
		
		.color-stbgr{
		color: #1e3932;
		}
		
		
    </style>

    <script>
        $(document).ready(function(){
            $("#member-list").change(function(){

                var memberNo = $(this).val();
                var jobCategoryNo = $(this).find("option:selected").data("jobcategoryno");

                console.log (memberNo);

                console.log(memberNo);
                console.log(jobCategoryNo);

                $(".memberNo").val(memberNo);
                $("#inputJobCategoryNo").val(jobCategoryNo);
                
                
                

                $.ajax({
					type: "GET",
                	url: "${pageContext.request.contextPath}/admin/getJobCategoryName",
                	dataType: "text",
                	data : {
                			jobCategoryNo : jobCategoryNo
            				},
                	
				    success:function(text) {
				    	$("#jobCategoryName").text(text);
				    },
				    error: function(err){
				    	console.log(err)
				    }
				    	
                }) //ajax끝
               
                console.log("1" + memberNo);
                
                
                $.ajax({
                	type: "GET",
                	url: "${pageContext.request.contextPath}/admin/getImageCertUrl",
                	datatype: "text",
                	
                	data : {	 	
                		memberNo : memberNo
                		},
                		
                		success:function(text) {
    				    	console.log(text);
    				    	var lengthFull = text.length;
							var lengthExceptFileName=lengthFull-9;
    				    	var fileName = "certImage";
    				    	var url = "${pagecontext.request.contextpath}/admin/getImageToImageCertJsp?memberNo="+ memberNo;
    				    	var finalUrl = "/khblind"+url;
    				    	$("#image-frame").attr("src", finalUrl);
    				    },
    				    error: function(err){
    				    	console.log(err)
    				    }
                })

            });
        });

    </script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/style4.css">
<section id="modiBox">
	<div class="modiBack" id="modiBack">
		<div id="modititle">
			<h3>ID-CART VERIFICATION</h3>
			<div id="title-area" class="col-12 row">
                <div id="board-write-title" class="col-12 text-center bgcolor-bq bbxb">
                    <h5 class="mt-3 mb-3 fcolor-stbgr font-size-15 bold">인증사진으로 등업관리</h5>
                </div>
                <div id="cert-area" class="col-12 row">
	                <div id="select-sector" class="col-3 frame form-group ">
	                	 <select id="member-list" class="form-control"size="20">
	                        <option value="0">(대기 회원을 선택)</option>
		                        <c:forEach var="imageCertDto" items="${approveImageCertReadyList}">
		                        	<option value="${imageCertDto.memberNo}" data-jobcategoryno="${imageCertDto.jobCategoryNo}">${imageCertDto.memberNick}(${imageCertDto.memberName})</option>
		                        </c:forEach>
	                    </select>
	                </div>
	                <div id="member-id-card" class="col-8 bbxb">
	                	<img id="image-frame" class="col-12 img-fluid bbxb" src="${root}/img/default-id-card.png">
	                </div>
	                
                 <div id="option-area" class="col-12 row bbxb">
                <div id="success-sector" class="col-12 text-center bbxb">
                    <form action="approveImageCert" class="form-group row bbxb" method="post">
                        <div id="hidden-sector" class="col-12 row bbxb">
                            <input id="inputMemberNo" class="col-6 memberNo bbxb" type="text" name="memberNo" value=""  hidden>
<!--                             <input id="inputJobCategoryNo"  class="col-6" type="text" name="jobCategoryNo" value="" > -->
                        </div>
                        
<!--                         <div id="job-info-sector" class="col-12 row"> -->
<!-- 							<div class="col-6 text-right"> -->
<!-- 	                            <span>회원이 요청한 업종 이름 : </span> -->
<!-- 	                        </div> -->
<!-- 	                        <div class="col-6 text-left"> -->
<!-- 	                        	<span id="jobCategoryName">아무거나</span> -->
<!-- 	                        </div> -->
<!--                         </div> -->
                        <div class="col-12 mt-3 bbxb">
                            <button class="btn btn-block btn-success bbxb">승인</button>
                        </div>

                    </form> 
                </div>

				<hr>
			
                <div id="fail-sector" class="col-12 text-center bbxb">
                    <form action="rejectImageCert" class="form-group row bbxb" method="post" >
                        <div class="col-12 mt-2 bbxb">
							<input id="inputMemberNo" class="memberNo col-6" type="text" name="memberNo" value=""  hidden>
                            <input type="text" name="imageCertMessage" class="form-control" placeholder="거절 사유를 입력해주세요">
                        </div>
                        <div class="col-12 mt-3 bbxb">
                            <button class="btn btn-block btn-warning bbxb">거절</button>
                        </div>
                    </form>
                </div>
            </div>
	                
                </div>
            </div>
		
		</div>
	</div>
</section>
 
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>