<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

    	<!-- 부트스트랩이 의존하는 css를 가져온다 -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
        <!-- 제이쿼리를 가져온다 -->
        <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
        <!-- UI제이쿼리를  가져온다 -->
        <script  src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"  integrity="sha256-T0Vest3yCU7pafRw9r+settMBX6JkKN06dqBnpQ8d30="   crossorigin="anonymous"></script>
        <!-- Popper를 가져온다 -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.9.2/umd/popper.min.js" integrity="sha512-2rNj2KJ+D8s1ceNasTIex6z4HWyOnEYLVC3FigGOmyQCZc2eBXKgOxQmo3oKLHyfcj53uz4QMsRCWNbLd32Q1g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <!-- 부트스트랩을 가져온다 -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js" integrity="sha384-+YQ4JLhjyBLPDQt//I+STsc9iw4uQqACwlvpslubQzn4u2UU2UFM80nGisd026JF" crossorigin="anonymous"></script>

<style>
    div {
        border: red 1px dotted;
    }

    .write-zone{
        width: 800px;
        margin-left: auto;
        margin-right: auto;
    }

    #input-vote-sector{
        width: 80%;
        margin-left: auto;
        margin-right: auto;
    }

    .display-7{
        font-size: 2rem;
        font-weight: 200;
        line-height: 1.2;
    }

    .mr-a{
        margin-right: auto;
        margin-left: auto;
    }

    .vote-progress-bg-1{background-color: Tomato; }
    .vote-progress-bg-2{background-color: RoyalBlue;}
    .vote-progress-bg-3{background-color: MediumSeaGreen;}
    .vote-progress-bg-4{background-color: GoldenRod;}
    .vote-progress-bg-5{background-color: FireBrick;}
    .vote-progress-bg-6{background-color: MediumBlue;}
    .vote-progress-bg-7{background-color: saddlebrown;}
    .vote-progress-bg-8{background-color: mediumturquoise;}
    

</style>

</head>
<body>
<h1>투표 테스트</h1>
<h2>현재글은 2번 (임의로 넣음)</h2>
<br><br><hr><br><br>
    <div class="write-zone">
        <div><br><br><br>

            <p>
                <a href=/kr/tag/#소개>#소개</a> <a href=/kr/tag/#일상>#일상</a> 
안녕하세요! 이건 테스트입니다.

<a href=/kr/tag/#삼성>#삼성</a> # LG <a href=/kr/tag/#프로젟트>#프로젟트</a> # 석현
            </p>

            
            
            
            <br><br><br><br></div>
        <div><br><br><br>업로드된사진<br><br><br><br></div>
        
        <div id="view-vote-sector" class="mt-2">
            <div id="vote-top">
                    <div class="vote-topic-div mt-1 mb-1 offset-1 col-10">
                        <div id="topic-id" data-topic-no="${VoteTopicInfo.voteTopicNo}" class="offset2 col-8">투표주제=</div>
                        <div class="col-8 mt-2">${VoteTopicInfo.voteTopicTitle}</div>
                    </div>
               </div>
                <div class="empty-div mb-3"></div>
                <div id="vote-middle">
					<div id="vote-option-divS" class="offset-1 col-10">
						<c:forEach var="VoteOptionInfo" items="${VoteOptionInfo}">
							<div class="vote-option-div row mt-1 mb-1">
								<div class="col-3 align-middle">
									<p>${VoteOptionInfo.voteOptionName}</p>
								</div>
								<div class="col-7">
									<div class="progress" style="height: 20px;">
										<div 
											id ="option-${VoteOptionInfo.voteOptionNo}-gauge"
											class="progress-bar vote-progress-bg-1" 
											role="progressbar" 
											style="width: ${VoteOptionInfo.voteOptionPercent}%;" 
											aria-valuenow="${VoteOptionInfo.voteOptionPercent}" 
											aria-valuemin="0" 
											aria-valuemax="100">
											${VoteOptionInfo.voteOptionPercent}% (${VoteOptionInfo.voteOptionCount}표)
										</div>
									</div>
								</div>
								<div class="col-2">
									<button data-option-no="${VoteOptionInfo.voteOptionNo}" class="vote-btn">투표</button>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>

<!-- 투표반영 ajax -->
	<script>
		$(function(){
			$(".vote-btn").click(function(e){
				var topicNo = $("#topic-id").data("topic-no");
				var optionNo = $(this).data("option-no");
				console.log("topicNo = " + topicNo) 
				console.log("optionNo = " + optionNo) 
				//memberNo는 세션에서
				
				$.ajax({
					url: "${pagecontext.request.contextpath}/khblind/board/voting",
					data:{
						topicNo: topicNo,
						optionNo : optionNo,
						type: "GET",
						success:function(resp){
							
							
							
						}
					},
					
				})
			})
			
		})
	
	</script>

        </div>

        <div><br><br>해시태그부분<br><br><br></div>
    </div>
<h4><span>투표 제목</span></h4>



</body>
</html>