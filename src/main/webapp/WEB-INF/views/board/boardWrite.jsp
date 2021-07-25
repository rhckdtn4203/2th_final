<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<!DOCTYPE html>
<html>
<head>

<!-- 부트스트랩을 가져온다 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"
	integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l"
	crossorigin="anonymous">
<!-- 제이쿼리를 가져온다 -->
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<!-- UI제이쿼리를  가져온다 -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"
	integrity="sha256-T0Vest3yCU7pafRw9r+settMBX6JkKN06dqBnpQ8d30="
	crossorigin="anonymous"></script>
<!-- Popper를 가져온다 -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.9.2/umd/popper.min.js"
	integrity="sha512-2rNj2KJ+D8s1ceNasTIex6z4HWyOnEYLVC3FigGOmyQCZc2eBXKgOxQmo3oKLHyfcj53uz4QMsRCWNbLd32Q1g=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- 폰트어썸 아이콘을 가져온다-->
<link rel="stylesheet"
	href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"
	integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p"
	crossorigin="anonymous" />
<!-- 부트와치를 가져온다.-->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootswatch@4.5.2/dist/flatly/bootstrap.min.css"
	integrity="sha384-qF/QmIAj5ZaYFAeQcrQ6bfVMAh4zZlrGwTPY7T/M+iTTLJqJBJjwwnsE5Y0mV7QK"
	crossorigin="anonymous">

<!--로드 후 관련 js-->
<script>
	$(function() {
		$("#image-input-zone").hide();
		$("#vote-input-zone").hide();
	});
</script>

<!--게시판 관련 js-->
<script>
	$(function() {
		$("#select2").hide();
		$("#select1").change(function() {
			if ($(this).val() == "토픽") {
				$("#select2").show();

				$("#type-no").attr("name", "");
				$("#type-no").attr("value", "");

				$("#type-no").attr("name", "boardCategoryNo");

				$("#select2").change(function() {
					$("#type-no").attr("value", $("#select2").val());
				});

			} else if ($(this).val() == "업종") {
				$("#select2").hide();

				$("#type-no").attr("name", "");
				$("#type-no").attr("value", "");

				$("#type-no").attr("name", "jobCategoryNo");
				$("#type-no").attr("value", "${dtoss.jobCategoryNo}");
				
				var no = $("#type-no").attr("value");
					if(no == 0){
						alert("회사인증을 하지 않으셨습니다.");
						$("#type-no").attr("name", "");
						$("#type-no").attr("value", "");
					}
		
			} else if ($(this).val() == "기업") {
				$("#select2").hide();

				$("#type-no").attr("name", "");
				$("#type-no").attr("value", "");

				$("#type-no").attr("name", "companyNo");
				$("#type-no").attr("value", "${dtoss.companyNo}");
				
				var no = $("#type-no").attr("value");
					if(no == 0){
						alert("회사인증을 하지 않으셨습니다.");
						$("#type-no").attr("name", "");
						$("#type-no").attr("value", "");
					}
				}
			})
	});
	
</script>

<!--옵션버튼 관련 js-->
<script>
	$(function() {
		$("#image-btn").click(function() {
			if ($(this).hasClass("option-on") === false) {
				$(this).css("color", "tomato");
				$(this).addClass("option-on")
				$("#image-input-zone").show();
			} else {
				$(this).css("color", "black");
				$(this).removeClass("option-on")
				$("#image-input-zone").hide();
				$("#image-files").val();
			}
		})

		$("#vote-btn").click(function() {
			if ($(this).hasClass("option-on") === false) {
				$(this).css("color", "tomato");
				$(this).addClass("option-on");
				$("#vote-input-zone").show();
			} else {
				$(this).css("color", "black");
				$(this).removeClass("option-on");
				
				$("#vote-topic").val("");
				$(".option-name").val("")
				
				$("#vote-input-zone").hide();
			}
		})
		$("#hashtag-btn").click(function() {
			$(this).fadeOut(150).fadeIn(150);

			var content = $("#board-content-textarea").val();
			var addSharpContent = content + " # ";
			$("#board-content-textarea").val(addSharpContent);
		})
	})
</script>

<!--이미지 관련 js-->
<script>
	$(function() {
		$("#image-files").change(function() {
			var filelist = this.files;
			console.log(filelist);

			if (filelist.length > 4) {
				alert("파일은 4개가 최대입니다!")
				$("#image-files").val('');
			} else {//업로드 가능!
				for (var i = 0; i < filelist.length; i++) {
					var image = new FileReader();
					console.log(image)
					//미리보기 구현할 것
				}
			}
		})
	})
</script>

<!--투표 관련 js-->
<script>
	$(function() {
		$("#plus-option-btn").on("click", function(e) {
			e.preventDefault();
			console.log("현재는" + $('.vote-option-div').length);
			console.log("항목추가");

			var count = $('.vote-option-div').length;
			if (count <= 7) {
				var template = $("#vote-option-div-template").html();

				template = template.replace("{{count}}", count + 1);
				template = template.replace("{{count2}}", count + 1);
				$("#vote-option-divS").append(template);
				count = $('.vote-option-div').length;
				count2 = $('.vote-option-div').length;
				if (count > 7) {
					$("#plus-option-btn").hide();
				}
			}

		})

	})
</script>

<!-- 전송 관련 js -->
<script>
	$(function(){
		$("#submit-btn").click(function(e){
			e.preventDefault;
			
			var typeNo = $("#type-no").attr("value");
			if(typeNo==""){alert("주제를 선택해주세요"); return false;}
			
			var boardTitle = $("#board-title").val();
			if(boardTitle==""){alert("제목을 입력해주세요"); return false;}
			
			var content = $("#board-content-textarea").val();
			console.log("content " + content);
// 			if(content==""){alert("내용을 입력해주세요"); return false;}
			
			var voteTitle = $("#vote-topic").val();
			var voteOptionCount=0;
			var optionNames = $(".vote-option-name");

			for(var i =0; i<optionNames.length; i++){
				var optionNamesVal = $(".vote-option-name").eq(i).val();
				console.log("optionNamesVal = " + optionNamesVal)
				
				if(optionNamesVal!=""){
					console.log("값 있는 항목 발견!");
					voteOptionCount++;
				}
			}
			console.log("최종 개수  = " + voteOptionCount)
			
			return false;
		})
		
	})
</script>

<style>
div {
	border: brown 1px dotted;
}

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
</style>
</head>

<body>
	<div id="board-write" class="row">
		<div id="board-write-zone" class="col-6 offset-3">
			<div id="board-write-title" class="text-center primary-background-color">
				<h5 class="mt-3 mb-3 font-color-khblind-gold font-size-15 bold">글 작성</h5>
			</div>

			<form action="boardWrite" method="post" enctype="multipart/form-data">
				<div id="select-type-zone" class="mt-3">
					<select id="select1" class="form-control mt-2 mb-2 form-control-lg">
						<option id="0">(주제를 선택해주세요)</option>
						<option id="topic">토픽</option>
						<option id="job">업종</option>
						<option id="company">기업</option>
					</select>
					
					<select id="select2" class="form-control mt-2 mb-2 form-control-lg">
						<option class="subOption" value="">(토픽을 선택해주세요)</option>
						<c:forEach var="categoryDto" items="${categoryList}">
							<option class="subOption" value="${categoryDto.boardCategoryNo}">${categoryDto.boardCategoryName}</option>
						</c:forEach>
					</select> <input id="type-no" type="hidden" name="" value="">
					<!-- 나중에 hidden으로 바꾸기 -->
				</div>

				<div id="board-input-zone" class="form-group col-10 offset-1 mt-3">
					<div id="board-title-input" class="">
						<input id="board-title" class="form-control p-4" type="text" name="boardTitle" placeholder="제목을 입력하세요" >
					</div>
					<div id="board-content-input">
						<textarea id="board-content-textarea" class="form-control mt-3 p-4" name="boardContent" placeholder="욕쓰지마라"></textarea>
					</div>
				</div>

				<div id="option-zone" class="row text-center">
					<div class="col-1">
						<i id="image-btn" class="show-form-icon far fa-images fa-2x"></i>
					</div>
					<div class="col-1">
						<i id="vote-btn" class="show-form-icon fas fa-poll fa-2x"></i>
					</div>
					<div class="col-1">
						<i id="hashtag-btn" class="fas fa-hashtag fa-2x"></i>
					</div>
					<div class="col-9"></div>
				</div>

				<div id="image-input-zone" class="mt-1">
					<div class="row">
						<div class="input-group">
							<div class="custom-file">
								<input id="image-files" type="file" name="images"	class="custom-file-input form-control-lg" accept=".jpg, .png" multiple>
								<label class="custom-file-label display-">파일을 선택해주세요</label>
							</div>
							<input id="upload-reset-btn" class="btn btn-warning" type="reset"
								value="Reset">
						</div>
					</div>

					<div id="preview-zone" class="row text-center">
						<div class="col-3">
							<img id="preview-1" src="#">
						</div>
						<div class="col-3">
							<img id="preview-1" src="#">
						</div>
						<div class="col-3">
							<img id="preview-1" src="#">
						</div>
						<div class="col-3">
							<img id="preview-1" src="#">
						</div>
					</div>
				</div>

            <div id="vote-input-zone"  class="mt-2">
                    <div id="vote-top">
                        <div class="vote-topic-div mt-1 mb-1">
                            <label for="vote-topic" class="display-6">투표제목</label>
                                <span><input id="vote-topic" class="form-control" type="text" name="voteTopicTitle"></span>
                        </div>
                   </div>
                    <div class="empty-div mb-3"></div>
    
                    <div id="vote-middle">
                            <div id="vote-option-divS" class="offset-1 col-10">
                                <div class="vote-option-div row mt-1 mb-1">
                                    <div class="col-3 align-middle">
                                        <p>항목 1</p>
                                    </div>
                                    <div class="col-9">
                                        <input type="text" id="vote-option-name-input-1" name="voteTopicOption" class="vote-option-name form-control">
                                    </div>
                                </div>
                                
                                <div class="vote-option-div row mt-1 mb-1">
                                    <div class="col-3 align-middle">
                                        <p>항목 2</p>
                                    </div>
                                    <div class="col-9">
                                        <input type="text" id="vote-option-name-input-2" name="voteTopicOption" class="vote-option-name form-control">
                                    </div>
                                </div>
                
                                <div class="vote-option-div row mt-1 mb-1">
                                    <div class="col-3 align-middle">
                                        <p>항목 3</p>
                                    </div>
                                    <div class="col-9">
                                        <input type="text"  id="vote-option-name-input-3" name="voteTopicOption" class="vote-option-name form-control">
                                    </div>
                                </div>
                            </div>
    
                            <div id="vote-setting-div-zone" class="offset-1 col-10">
                                <div class="plus-option-div mt-1 mb-1">
                                    <button id="plus-option-btn" class="btn btn-warning">항목 추가하기</button>
                                </div>
                            </div>
                        </div>
                    </div>   
				
				<div id="submit-zone" class="row text-center">
					<div class="col-8"></div>
					<div class="col-2">
						<input id="reset-btn" class="btn btn-primary" type="reset" value="초기화">
					</div>
					<div class="col-2">
					<button id="submit-btn" class="btn btn-warning" >전송!	</button>
					</div>
				</div>
			</form>
		</div>
	</div>





	<script id="vote-option-div-template" type="text/template">
        <div class="vote-option-div row mt-1 mb-1">
            <div class="col-3 align-middle">
                <p>항목 {{count}}</p>
            </div>
            <div class="col-9">
                <input type="text" id="vote-option-name-input-{{count2}}" name="voteTopicOption" class="vote-option-name form-control">
            </div>
        </div>
    </script>
</body>
</html>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>