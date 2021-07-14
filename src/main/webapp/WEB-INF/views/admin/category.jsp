<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
$(function() {
	
	$(".selectCategory").change(function(){
		
		var CategoryNo = $(this).val();		
		var CategoryName = $(".selectCategory option:checked").text();
		
		if($(this).val()==null || $(this).val()==""){
			$(".categoryNo").val("");
			$(".categoryName").val("");
			return;
		}
		$(".categoryNo").val(CategoryNo);
		$(".categoryName").val(CategoryName);
			
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

<div class="board-manage">

<h2>카테고리 관리</h2>

<div class="category-insert">
<form action="categoryInsert" method="post">
<input type="text" name="boardCategoryName" id="categoryInput"required="required">

<input type="submit" value="등록">
</form>
</div>

<div class="category-delete-edit">
<p>게시판 수정/삭제<p>
<!--전체 카테고리 출력 및 삭제부분 -->


<!--카테고리 목록 보여주기 -->
<select name="boardCategoryNo">
<c:forEach var="categoryDto" items="${categoryList}">
<option value="${categoryDto.boardCategoryNo}"><c:out value="${categoryDto.boardCategoryName}"/></option>
</c:forEach>
</select>
</div>




</div>


	<form action="categoryDelete" method="get"onsubmit="checkDelete()">
<!-- 		<input type="hidden" name ="boardCategoryNo"> -->
			<select class="selectCategory" name="boardCategoryNo">
				<option value="" selected>게시판 선택해주세요</option>
				<c:forEach var="categoryDto" items="${categoryList}">
				<option value="${categoryDto.boardCategoryNo}" label="${categoryDto.boardCategoryName}">${categoryDto.boardCategoryName}</option>
				</c:forEach>
			</select>
		<input type="submit" value="삭제" >
	</form>
	
	<!-- 
	수정: 위에서 선택된 값을 아래 value로 넣기
	 -->
	<form action="categoryEdit" method="get"  onsubmit="checkName();">
	<input type="hidden" class="categoryNo" name = "boardCategoryNo">
	<input type="text" class="categoryName" name = "boardCategoryName" required >
	<input type="submit" value="수정">
</form>
    
    
    
    
    
    
    
    