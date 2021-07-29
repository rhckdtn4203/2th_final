<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>

<script>
	$(function(){
		//이미지 불러오기 테스트
		$("#test").click(function(){
			console.log("누름!")
			$.ajax({
				url: "${pagecontext.request.contextpath}/khblind/board/getImageInfo",
				data:{
					boardNo:151
				},
				type: "GET",
				success:function(resp){
					console.log("성공");
					console.log(resp);
					
					for(var i=0; i < resp.length; i++){
						var template = $("#template").html();
						var fileUrlInLocal = resp[i].boardImageUrl;
						
						var url = "${pagecontext.request.contextpath}/khblind/board/getImageFlie?boardNo=151&fileName=KKKKK";
						template = template.replace("{{url}}", url);
						
						$("#here").append(template);
					}
				}
				
			})
			
		})
	})
</script>

</head>
<body>
    <div>
        <button id="test">TEST다!!!</button>

    </div>
<hr>

<div>
    <div id="here">
        <p>여기</p>
        <div class="test">
            <img src="">
        </div>
    </div>
</div>
    

<script id="template" type="text/template">
        <div class="test">
            <img src="{{url}}">
        </div>
</script>

</body>
</html>