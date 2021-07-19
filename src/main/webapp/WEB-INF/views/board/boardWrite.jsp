<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<!DOCTYPE html>
<html>
<head>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
	$(function(){
    $("#select2").hide();
    
    $("#select1").change(function(){

        if($(this).val()=="토픽")
        {
            $("#select2").show();

            $("#that").attr("name", "");
            $("#that").attr("value", "");

            $("#that").attr("name", "categoryNo");
            
            $("#select2").change(function(){
                $("#that").attr("value", $(this).val());
            });
            
        }
        else if($(this).val()=="업종")
        {
            $("#select2").hide();

            $("#that").attr("name", "");
            $("#that").attr("value", "");

            $("#that").attr("name", "jobCategoryNo");
            $("#that").attr("value", "${dtoss.jobCategoryNo}");
        }
        else if($(this).val()=="기업")
        {
            $("#select2").hide();

            $("#that").attr("name", "");
            $("#that").attr("value", "");

            $("#that").attr("name", "companyNo");
            $("#that").attr("value", "${dtoss.companyNo}");
        }

    });
});
</script>
	
</head>	
<body>

	<form action="boardWrite" method="post">
		

        <select id="select1">
            <option id="0">(선택해주세요)</option>
            <option id="a">토픽</option>
            <option id="b">업종</option>
            <option id="c">기업</option>
        </select>

        <select id="select2">
            <option class="subOption" value="">(선택해주세요)</option>
            <!-- 밑에 꺼 반복문화 -->
           	<c:forEach var="categoryDto" items="${categoryList}" >
           		<option class="subOption" value="${categoryDto.boardCategoryNo}">${categoryDto.boardCategoryName}</option>           
            </c:forEach>
        </select>

        <input id="that" type="text" name="" value=""> <!-- 나중에 hidden으로 바꾸기 -->

        	<br><br>
        	제목 : <input type="text" name="boardTitle" required>
        	<br><br>
			내용 : <textarea name="boardContent" required></textarea>
			<br><br>
			<input type="submit" value="등록">
		</form>
	
	</body>
</html>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>