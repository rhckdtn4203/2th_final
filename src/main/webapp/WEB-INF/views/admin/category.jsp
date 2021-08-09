<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
   
    <style>

    </style>

    <!-- bootstrap 이용을 위한 JS 의존성 등록 (jQuery/popper/BS) -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap_reboot.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap_grid.css">



<!-- <script id="iTag-start" type="text/template"> -->
<%-- <i class=" --%>
<!-- </script> -->
<!-- <script id="iTag-end" type="text/template"> -->
<!-- "></i> -->
<!-- </script> -->
<script src="https://kit.fontawesome.com/77858aaef8.js" crossorigin="anonymous"></script>
<script>
$(function() {
	
	$(".selectCategory").change(function(){
		console.log($(this).val());
		
		
		var CategoryNo = $(this).val();	
		var CategoryName = $(".selectCategory option:checked").text();
 		var CategoryIcon = $(".selectCategory option:checked").attr("data-icon");
 		var before = $(".selectCategory option:checked").attr("data-icon");
 		
 		if($(this).val()=="게시판 선택해주세요"){
			$(".categoryNo").val("");
			$(".categoryName").val("");
			$(".categoryIcon").val("");
			return;
		}
		$(".categoryNo").val(CategoryNo);
		$(".categoryName").val(CategoryName);
 		
		CategoryIcon = CategoryIcon.replace("&quot", '\"');
		var after = before.replace("&quot", '\"');
 		
		$(".categoryIcon").val(after);
//  		$(".categoryIcon").val(CategoryIcon);
	});
});
function checkNameSuper(){
	var inputName = document.querySelector("#categoryInput");
	var inputNameValue = inputName.value;
	var regex = /^[a-zA-Z\d가-힣+#/\-\(\)\*@!]{1,10}$/;
	
	if(!regex.test(inputNameValue)){
		alert("올바른 형식이 아닙니다. 게시판 이름을 10글자 이내로 적어주세요");
		event.preventDefault();
	}
}
function checkDelete(){
	msg = "삭제하시겠습니까?";
		if (confirm(msg)!=0) {
			     
		} else {
			event.preventDefault();	
		}
	}
function checkName(){
	msg = "수정 하시겠습니까?";
		if (confirm(msg)!=0) {
			     
		} else {
			event.preventDefault();	
		}
	}
		


</script>
<script>
$(function(){
    $("#submit-btn").click(function(){
    	

       
       var categoryName = $("#categoryInputName").val();
       if(categoryName==""){alert("카테고리 이름을 입력해주세요."); return false;}
       if(categoryName.length > 10){alert("카테고리 이름은은 10글자 입력 가능합니다.")};
       
       var categoryIcon = $("#categoryInputIcon").val();
       if(categoryIcon==""){alert("내용을 입력해주세요."); return false;}
       if(categoryIcon.length > 50){alert("카테고리 아이콘은 50글자 입력 가능합니다."); return false;}
            
       
    });
       
       
    });


</script>
<style>
.font-green{
color:#008248;
}
.container-border{
border: 1px solid black !important;
color:#008248 !important;
margin-top : 100px;
 

}
.container-header{
height:100px;
padding:35px ;
}

.category-insert,  .categoryEdit{
height:300px;
padding-top:130px;
padding-left:30px;
border:none;
}
.categoryDelete{
height:130%;
padding-top:30px;
padding-bottom:30px;
border:none;
}
.underline{
BORDER-BOTTOM: teal 1px solid;
BORDER-LEFT: medium none;
BORDER-RIGHT: medium none;
BORDER-TOP: medium none;
}
  .my-border{  
               border: none;
               border-bottom: 1px solid #008248;
           }
   .scrollno{
   overflow : auto;
width      : 100%;
height      : 100%;
   } 
  .selectCategory{
  border-left:30px;
  }     
  .text-right{
  text-align:right;
  }  
</style>

<div class="container-800 col container-border">
<div class="container-header">
<h2 class="text-center font-green">카테고리 관리</h2>
</div>

<div class="text-center category-insert">
<form action="categoryInsert" method="post">
<label class="font-green">카테고리이름:<input class="underline" type="text" name="boardCategoryName" id="categoryInputName"></label>
<label class="font-green">카테고리아이콘:<input class="underline" type="text" name="boardCategoryIcon" id="categoryInputIcon"></label>
<!-- <input id="submit-btn" class="btn btn-outline-success my-border" type="submit" value="등록"> -->
<button id="submit-btn" class="btn btn-outline-success my-border">등록</button>
</form>
</div>

<div class="categoryDelete text-right">
	<form action="categoryDelete" method="get"onsubmit="checkDelete()">
			<select size="${categoryCount}"  class="selectCategory scrollno form-control" name="boardCategoryNo">
				<option id="choice" selected>게시판 선택해주세요</option>
				<c:forEach var="categoryDto" items="${categoryList}">
					<option value="${categoryDto.boardCategoryNo}" data-icon="${categoryDto.boardCategoryIcon}" label="${categoryDto.boardCategoryName}">${categoryDto.boardCategoryName}</option>
				</c:forEach>
			</select>
		<input class="btn btn-outline-success my-border text-right" type="submit" value="삭제" >
	</form>
</div>	
	<!-- 
	수정: 위에서 선택된 값을 아래 value로 넣기
	 -->
	 <div class="row categoryEdit">
	<form action="categoryEdit" method="get"  onsubmit="checkName();">
	<input type="hidden" class="categoryNo " name = "boardCategoryNo">
	<label class="font-green">카테고리이름:<input type="text" class="categoryName underline" name = "boardCategoryName" id="categoryInputName"></label>
	<label class="font-green">카테고리아이콘:<input type="text" class="categoryIcon underline" name="boardCategoryIcon" id="categoryInputIcon"></label>
	<input id="submit-btn" class="btn btn-outline-success my-border" type="submit" value="수정">
</form>

</div>
</div>

		


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>