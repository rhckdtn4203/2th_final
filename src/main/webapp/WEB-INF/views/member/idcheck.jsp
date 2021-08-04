<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div id="div1">
<% 
if( cnt == 0){
	out.print("사용가능한 아이디입니다");
%>
<script>
opner.document.frm.chk.value ="1";
</script>
<% }else{
	out.print("이미 사용중인 아이디입니다");
%>
<script>
opner.document.frm.chk.value ="0";
</script>

<%} %>
<button type="button" onclick="self.close()">닫기</button>

</div>

</body>
</html>