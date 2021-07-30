<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>파일 여러개 업로드</h3>
<form action="imageUploadTest" method="post" enctype="multipart/form-data">
	<input type="file" name="images" multiple>
	<br><br>
	<input type="submit" value="업로드">
</form>
</body>
</html>