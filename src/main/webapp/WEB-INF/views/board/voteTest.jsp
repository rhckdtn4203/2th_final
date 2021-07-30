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
				되라되라
            </p>

            
            
            
            <br><br><br><br></div>
        <div><br><br><br>업로드된사진<br><br><br><br></div>
        
        <div id="view-vote-sector" class="mt-2">
            <div id="vote-top">
                    <div class="vote-topic-div mt-1 mb-1 row">
                    	<div class="empty-div col-1"></div>
                    	<div id = "vote-topic-contents-div" class="col-8">
	                        <div id="topic-id" data-topic-no="${VoteTopicInfo.voteTopicNo}">투표주제=</div>
	                        <div>${VoteTopicInfo.voteTopicTitle}</div>
                    	</div>
                    	<div class=col-2>
                    	<div class="empty-div col-1"></div>
                    		<div>
                    			<button id=realTimeVoteOn class="btn btn-primary">실시간투표 켜기</button>
                    			<button id=realTimeVoteOff class="btn btn-secondary">실시간투표 끄기</button>
                    		</div>
                        </div>
                    </div>
               </div>
                <div class="empty-div mb-3"></div>
                <div id="vote-middle">
					<div id="vote-option-divS" class="offset-1 col-10">
						<c:forEach var="VoteOptionInfo" items="${VoteOptionInfo}">
							<div class="vote-option-div row mt-1 mb-1">
								<div class="col-3 align-middle">
									<div>
										<div id ="option-${VoteOptionInfo.voteOptionNo}-name-div">
											<p id ="option-${VoteOptionInfo.voteOptionNo}-name">${VoteOptionInfo.voteOptionName}</p>								
										</div>
									</div>
								</div>
								<div class="col-7">
									<div class="progress" style="height: 20px;">
										<div 
											id ="option-${VoteOptionInfo.voteOptionNo}-gauge"
											class="progress-bar vote-progress-bg-4" 
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
									<c:if test="${didYouVote eq 'voted'}">
										<button class="vote-btn dummy-btn btn btn-secondary" disabled>투표</button>
									</c:if>
									<c:if test="${didYouVote eq 'didntVote'}">
										<button data-option-no="${VoteOptionInfo.voteOptionNo}" class="vote-btn active-btn btn btn-success">투표</button>
									</c:if>
								</div>
							</div>
						</c:forEach>
						<c:if test="${didYouVote eq 'notLogin'}">
								<p>투표하시려면 로그인해주세요</p>				
						</c:if>
					</div>
				</div>
			</div>
<!-- 이미 투표한 항목 표시하기 -->
	<script>
		$(function(){
			var selectedVoteName = $("#option-" + ${selectedVoteOptionNo} + "-name");
			selectedVoteName.css("color", "red");
			selectedVoteName.css("font-size", "1.5em");
		});
	</script>

<!-- 실시간 투표-->
	<script>
		$(function(){
			$("#realTimeVoteOff").hide();
				$("#realTimeVoteOn").click(function(){
					$("#realTimeVoteOff").show();
					$("#realTimeVoteOn").hide();
					$(".vote-btn").removeClass("active-btn");
					$(".vote-btn").addClass("realtime-vote-btn");
					
					
					$(".progress-bar").addClass("progress-bar-striped");
					$(".progress-bar").removeClass("vote-progress-bg-4");
					$(".progress-bar").addClass("vote-progress-bg-2");
					$("#realTimeVoteOff").show();
					
					//소켓에 연결한다.
					var uri = "ws://localhost:8080/khblind/realtimeVote";
					window.socket = new WebSocket(uri);
					
					var topicNo = ${VoteTopicInfo.voteTopicNo};
					window.socket.onopen = function(){
						//연결이 되면 바로 서버에게 채널 접속 메세지를 전송해야 한다.
						//{"type":1 , "channel": "hello"} 형태로 전송

						
						var message = {receivePayloadType:1, voteTopicNo: topicNo};
						var json = JSON.stringify(message);
						window.socket.send(json);
					};
					window.socket.onclose = function(){
						//console.log(arguments);
					};
					window.socket.onerror = function(){
						//console.log(arguments);
					};
					window.socket.onmessage = function(message){
						
						var messageObject = JSON.parse(message.data);//String --> JSON Object
						
						$.ajax({//2-1. onmessage 중 다른 사람 투표 반영 당하기!
							url: "${pagecontext.request.contextpath}/khblind/board/getOthersVotingInfo",
							data:{
								voteOptionNo: messageObject.voteOptionNo
								},
								type: "GET",
								success:function(resp){
								
// 										console.log("얘구조부터알아보자" + resp.voteOptionNo); //66
// 										console.log("얘구조부터알아보자" + resp.voteOptionCount); //22
										var target = $("#option-"+ resp.voteOptionNo +"-gauge");
										
										target.removeClass("vote-progress-bg-2");
										target.addClass("vote-progress-bg-4", {duration:500}).removeClass("vote-progress-bg-4", {duration:500});
										
// 										target.animate( {'background-color':'MediumSeaGreen'}, 2000, 'swing');


								},
								
								complete:function(){

								}

						})//ajax끝
						
						
						$.ajax({//2-2. onmessage 중 최신 정보 받기
							url: "${pagecontext.request.contextpath}/khblind/board/realtimeGetVoteTest",
							data:{
								voteTopicNo: topicNo//음 이거 정해야할듯
								},
								type: "GET",
								success:function(resp){
									for(var i=0; i<resp.length; i++){
										console.log(resp[i])
										var target = $("#option-"+ resp[i].voteOptionNo +"-gauge");
										
										target.css("width", resp[i].voteOptionPercent +"%");
										target.attr("aria-valuenow", resp[i].voteOptionPercent);
										target.text(resp[i].voteOptionPercent +"% "+"("+ resp[i].voteOptionCount +"표)");
									
									}
								},
								
								complete:function(){

								}

						})//ajax끝
						
					};
					
					//실시간 중 투표하기
					$(".realtime-vote-btn").click(function(){
						$(".realtime-vote-btn").attr("disabled", "disabled");
						if(!window.socket) return;

						var topicNo = $("#topic-id").data("topic-no");
						var optionNo = $(this).data("option-no");
						//var memberNo는 세션에서
						
						//1.서버에 정보 보내기
						
						//보낼 때 서버에서 이해할 수 있는 양식으로 보내야 한다
						var message = {receivePayloadType:2, voteTopicNo: topicNo, voteOptionNo: optionNo};
						var json = JSON.stringify(message);
						window.socket.send(json);
						
						console.log("이런!" + json)
						
						//2. 갱신보여주기
						$.ajax({
							url: "${pagecontext.request.contextpath}/khblind/board/voting",
							data:{
								voteTopicNo: topicNo,
								voteOptionNo : optionNo
								},
								type: "GET",
								success:function(resp){
									console.log("에이젝스 간다으");
									for(var i=0; i<resp.length; i++){
										console.log(resp[i])
										var target = $("#option-"+ resp[i].voteOptionNo +"-gauge");
										
										target.css("width", resp[i].voteOptionPercent +"%");
										target.attr("aria-valuenow", resp[i].voteOptionPercent);
										target.text(resp[i].voteOptionPercent +"% "+"("+ resp[i].voteOptionCount +"표)");
										

									}
								},
								
								complete:function(){

								}
								
								
						})//ajax끝

					});

				})
				$("#realTimeVoteOff").click(function(){
					$("#realTimeVoteOff").hide();
					$(".progress-bar").removeClass("progress-bar-striped");
					$(".progress-bar").removeClass("vote-progress-bg-2");
					$(".progress-bar").addClass("vote-progress-bg-4");
					$("#realTimeVoteOn").show();
					
					//소켓 끊기
					if(!window.socket) return;
					var topicNo = $("#topic-id").data("topic-no");
					var message = {receivePayloadType:3, voteTopicNo: topicNo};
					var json = JSON.stringify(message);
					window.socket.send(json);
				})
			
		})
	</script>

<!-- 투표반영 ajax -->
	<script>
		$(function(){
			$(".active-btn").click(function(e){
				if(window.socket) {
					console.log("실시간 중");
					return;} //소켓 연결동안 실행되지 않을...
					
				$(".active-btn").attr("disabled", "disabled");
					
				var topicNo = $("#topic-id").data("topic-no");
				var optionNo = $(this).data("option-no");
				//memberNo는 세션에서
// 				console.log("topicNo = " + topicNo  + "||" + "optionNo = " + optionNo) ;
				$.ajax({
					url: "${pagecontext.request.contextpath}/khblind/board/voting",
					data:{
						voteTopicNo: topicNo,
						voteOptionNo : optionNo
						},
						type: "GET",
						success:function(resp){
							
							for(var i=0; i<resp.length; i++){
								console.log(resp[i])
								var target = $("#option-"+ resp[i].voteOptionNo +"-gauge");
								
								target.css("width", resp[i].voteOptionPercent +"%");
								target.attr("aria-valuenow", resp[i].voteOptionPercent);
								target.text(resp[i].voteOptionPercent +"% "+"("+ resp[i].voteOptionCount +"표)");
								
							}
							
						}					
				})//ajax끝

			})
			
			$(window).on("beforeunload", function(){
				if(!window.socket) return;
				
				var message = {receivePayloadType:3, voteTopicNo: topicNo};
				var json = JSON.stringify(message);
				window.socket.send(json);
			})
						
		});
	
	</script>

        </div>

        <div><br><br>해시태그부분<br><br><br></div>
    </div>



</body>
</html>