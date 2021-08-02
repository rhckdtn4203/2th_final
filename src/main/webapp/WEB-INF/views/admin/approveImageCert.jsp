<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!-- 제이쿼리를 가져온다 -->
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <!-- UI제이쿼리를  가져온다 -->
    <script  src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"  integrity="sha256-T0Vest3yCU7pafRw9r+settMBX6JkKN06dqBnpQ8d30="   crossorigin="anonymous"></script>
    <!-- 폰트어썸 아이콘을 가져온다-->
    <script src="https://kit.fontawesome.com/77858aaef8.js" crossorigin="anonymous"></script>

  
    <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap_reboot.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap_grid.css">

<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
    <style>
		#image-frame{
		width : 500px;
		height : 500px;
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

/*         .w-auto{ */
/*         width: auto; */
/*         } */

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
               
                console.log("하나 끝 둘 시작");
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
    				    	console.log("파일 유알엘" +url);
    				    	console.log("파이널 유알엘" +finalUrl);
    				    	$("#image-frame").attr("src", finalUrl);
    				    },
    				    error: function(err){
    				    	console.log(err)
    				    }
                })
                console.log("끝?!")

            });
        });

    </script>
    <div class="row mt-5 container">
        <div class="offset-2 col-8 row">

            <div id="title-area" class="col-12 row">
                <div id="board-write-title" class="col-12 text-center primary-background-color">
                    <h5 class="mt-3 mb-3 font-color-khblind-gold font-size-15 bold">인증사진으로 등업관리</h5>
                </div>
            </div>

            <div id="info-area" class="col-12 row mt-3">
                <div id="select-sector" class="col-3 frame form-group">
<%--                     ${approveImageCertReadyList} --%>
                    <select id="member-list" class="form-control"size="20">
                        <option value="0">(대기 회원을 선택)</option>
                        <c:forEach var="imageCertDto" items="${approveImageCertReadyList}">
         
                        	<option value="${imageCertDto.memberNo}" data-jobcategoryno="${imageCertDto.jobCategoryNo}">${imageCertDto.memberNick}(${imageCertDto.memberName})</option>
                        </c:forEach>
                    </select>
                </div>


                <div id="image-sector" class="col-9 row">

                    <img id="image-frame" class="col-12 img-fluid" src="${root}/img/default-id-card.png">
                </div>
            </div>

            <div id="option-area" class="col-12 row">
                <div id="success-sector" class="col-12 text-center">
                    <form action="approveImageCert" class="form-group row" method="post">
                        <div id="hidden-sector" class="col-12 row">
                            <input id="inputMemberNo" class="col-6 memberNo" type="text" name="memberNo" value=""  hidden>
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
                        <div class="col-12 mt-3">
                            <button class="btn btn-block btn-success">승인</button>
                        </div>

                    </form> 
                </div>

				<hr>
			
                <div id="fail-sector" class="col-12 text-center">
                    <form action="rejectImageCert" class="form-group row" method="post" >
                        <div class="col-12 mt-2">
							<input id="inputMemberNo" class="memberNo col-6" type="text" name="memberNo" value=""  hidden>
                            <input type="text" name="imageCertMessage" class="form-control" placeholder="거절 사유를 입력해주세요">
                        </div>
                        <div class="col-12 mt-3">
                            <button class="btn btn-block btn-warning ">거절</button>
                        </div>
                    </form>
                </div>
                
                
                
                
            </div>
        </div>
    </div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>