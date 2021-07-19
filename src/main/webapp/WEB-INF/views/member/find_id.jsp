<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container-600">
	<div class="row">
		<h2>아이디 찾기</h2>
	</div>
<form method="post" class="form-signin" action="${pageContext.request.contextPath}find_id" name="findform">
		<div class="row-left">
			<input type="text" id="name" name="name" class="form-input form-input-underline"/>
			<label for="name">이름</label>
		</div>
		
		<div class="row-left">
			<input type="text" id="phone" name="phone" class="form-input form-input-underline"/>
			<label for="phone">전화번호</label>
		</div>

		<div class="row-left">
			<input class="form-btn form-btn-positive"
				type="submit" value="check">
		</div>

		<%-- <!-- 이름과 전화번호가 일치하지 않을 때-->
		<c:if test="${check == 1}">
			<script>
				opener.document.findform.name.value = "";
				opener.document.findform.phone.value = "";
			</script>
			<label>일치하는 정보가 존재하지 않습니다.</label>
		</c:if>

		<!-- 이름과 비밀번호가 일치하지 않을 때 -->
		<c:if test="${check == 0 }">
		<label>찾으시는 아이디는' ${memberId}' 입니다.</label>
		<div class="form-label-group">
				<input class="btn btn-lg btn-secondary btn-block text-uppercase"
					type="button" value="OK" onclick="closethewindow()">
			</div>
		</c:if> --%>

	</form>
	
<!-- 	<script type="text/javascript">
		function closethewindow(){
			self.close();
		}
	</script> -->
	
	</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>