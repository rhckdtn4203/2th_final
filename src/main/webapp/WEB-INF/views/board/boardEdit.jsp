<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!-- 
	수정페이지도 일단 입력, 상세보기 페이지랑 동일하게 진행됨 
	번호를 받아서 사용자를 조회한다음에 사용자에게 먼저 보여주고(상세보기)
	사용자가 보여진정보에서 고칠만한 것을 고치고 전송을 누름(입력)
-->

<h2>게시글 수정</h2>
<!-- 보내야 할 항목(번호, 제목, 내용) 사용자가 고칠수 있는 항목(제목, 내용) 1개hidden -->
<form action="boardEdit" method="post"> 
	<input type="hidden" name="boardNo" value="${boardDto.boardNo}">
	<br><br>
	제목 : <input type="text" name="boardTitle" value="${boardDto.boardTitle}">
	<br><br>
	내용 : 
	<textarea name="boardContent">${boardDto.boardContent}</textarea>
	<br><br>
	<input type="submit" value="수정">
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>