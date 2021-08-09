<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"	integrity="sha256-T0Vest3yCU7pafRw9r+settMBX6JkKN06dqBnpQ8d30="	crossorigin="anonymous"></script>
<link rel="stylesheet"	href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"	integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p"	crossorigin="anonymous" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap_reboot.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap_grid.css">

<style>

textarea {
	min-height: 20rem;
	overflow-y: visible;
	resize: none;
}

.font-color-white {
	color: white;
}

.font-color-khblind-gold {
	color: #eee8aa;
}

.bold {
	font-weight: bold;
}

.font-size-15 {
	font-size: 1.5rem;
}

.primary-background-color {
	background-color: #1e3932;
}

.bbxb{
	box-sizing: border-box;
}
</style>

<body>
	<div id="board-edit" class="row">
		<div id="board-edit-zone" class="col-6 offset-3">
			<div id="board-write-title" class="text-center primary-background-color">
				<h5 class="mt-3 mb-3 font-color-khblind-gold font-size-15 bold">글 수정</h5>
			</div>
			<form action="boardEdit" method="post" enctype="multipart/form-data">
			
				<input type="hidden" name="boardNo" value="${boardEditGetInfoVO.boardNo}">
				
				<div id="select-type-zone" class="mt-3 bbxb">
	
					<c:if test="${boardEditGetInfoVO.boardTypeName eq 'boardCategory'}">
						<!-- 토픽인 경우 -->
						<select id="select1" class="form-control mt-2 mb-2 form-control-lg bbxb" disabled>
							<option>토픽</option>
						</select>
						<select id="select2" class="form-control mt-2 mb-2 form-control-lg bbxb" disabled>
							<option>${boardEditGetInfoVO.typeName}</option>
						</select>
					</c:if>
					
					<c:if test="${boardEditGetInfoVO.boardTypeName eq 'jobCategory'}">
						<!-- 업종인경우 -->		
						<select id="select2" class="form-control mt-2 mb-2 form-control-lg bbxb" disabled>
							<option>${boardEditGetInfoVO.typeName}</option>
						</select>
					</c:if>		
					
					<c:if test="${boardEditGetInfoVO.boardTypeName eq 'company'}">
						<!-- 기업인경우 -->		
						<select id="select2" class="form-control mt-2 mb-2 form-control-lg bbxb" disabled>
							<option>${boardEditGetInfoVO.typeName}</option>
						</select>
					</c:if>		
				</div>
				
				<div id="board-input-zone" class="form-group col-10 offset-1 mt-3 bbxb">
					<div id="board-title-input" class="bbxb">
						<input id="board-title" class="form-control p-4 bbxb" type="text" name="boardTitle" placeholder="제목을 입력하세요" value="${boardEditGetInfoVO.boardTitle}">
					</div>
					<div id="board-content-input">
						<textarea id="board-content-textarea" class="form-control mt-3 p-4 bbxb" name="boardContent" placeholder="욕쓰지마라">${boardEditGetInfoVO.boardContent}</textarea>
					</div>
				</div>
				
				<div id="option-zone" class="row text-center bbxb">
					<div class="col-1 ">
						<span class="fa-stack fa-1x">
							<i id="image-btn" class="show-form-icon far fa-images fa-2x"></i>
							<i class="fas fa-ban fa-stack-2x" style="color:Tomato"></i>
						</span>
					</div>
					<div class="col-1">
						<span class="fa-stack fa-1x">
							<i id="vote-btn" class="show-form-icon fas fa-poll fa-2x"></i>
							<i class="fas fa-ban fa-stack-2x" style="color:Tomato"></i>
						</span>
					</div>
					<div class="col-1">
						<span class="fa-stack fa-1x">
							<i id="hashtag-btn" class="fas fa-hashtag fa-2x"></i>
						</span>
					</div>
					<div class="col-9"></div>
				</div>
				
				<div id="submit-zone" class="row text-center bbxb">
					<div class="col-6"></div>
					<div class="col-2">
						<input id="reset-btn" class="btn btn-primary bbxb" type="reset" value="초기화">
					</div>
					<div class="col-2">
					<button id="submit-btn" class="btn btn-warning bbxb" >전송!</button>
					</div>
				</div>
			</form>
		</div>	
	</div>
</body>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>