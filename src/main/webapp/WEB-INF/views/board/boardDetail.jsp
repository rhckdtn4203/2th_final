<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

        <!-- 부트스트랩을 가져온다 -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
        <!-- 제이쿼리를 가져온다 -->
        <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
        <!-- UI제이쿼리를  가져온다 -->
        <script  src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"  integrity="sha256-T0Vest3yCU7pafRw9r+settMBX6JkKN06dqBnpQ8d30="   crossorigin="anonymous"></script>
        <!-- Popper를 가져온다 -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.9.2/umd/popper.min.js" integrity="sha512-2rNj2KJ+D8s1ceNasTIex6z4HWyOnEYLVC3FigGOmyQCZc2eBXKgOxQmo3oKLHyfcj53uz4QMsRCWNbLd32Q1g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <!-- 폰트어썸 아이콘을 가져온다-->
         <script src="https://kit.fontawesome.com/77858aaef8.js" crossorigin="anonymous"></script>
        <!-- 부트와치를 가져온다.-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.5.2/dist/flatly/bootstrap.min.css" integrity="sha384-qF/QmIAj5ZaYFAeQcrQ6bfVMAh4zZlrGwTPY7T/M+iTTLJqJBJjwwnsE5Y0mV7QK" crossorigin="anonymous">
<script>
 $(function(){ 
 $(".deleteLike").click(function(){ 
	  $(".boardLikeInsertForm").submit(); 
	   }); 
	   });
 </script> 
 <script>
 $(function(){ 
 $(".board_unlike_btn").click(function(){ 
	  $(".boardLikeDeleteForm").submit(); 
	   }); 
	   });
 </script> 

<!-- 이미 투표한 항목 표시하기 -->
	<script>
		$(function(){
			var selectedVoteName = $("#option-" + ${selectedVoteOptionNo} + "-name");
			selectedVoteName.css("color", "red");
// 			selectedVoteName.css("font-size", "1.5em");
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


 <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<script>
$(function(){

   $(".notLogin").click(function(e){
      e.preventDefault()
      window.alert("로그인이 필요한 기능입니다")
      });
   });

</script>

        <style>
            div{
             border: 1px white none;
            }
        
            #board-content-viewer{
            word-wrap: break-word;
            font-size: 14px;
            font-family: "Roboto","Noto Sans KR",AppleSDGothicNeo-Regular,"Malgun Gothic","맑은 고딕",dotum,"돋움",sans-serif;
            margin-block-start: 0.2em;
            margin-block-end: 0.2em;
            }

            #insert-comments-textarea {
            min-height: 6rem;
            overflow-y: visible;
            resize: none;
            border-radius: 1em;
            border-bottom-right-radius: 0;
            padding-top: 0.75em;
            padding-left: 1.5em;
            }

            .comments-content{
            min-height: 6em;
            }
        
            .preview-frame{
            width: 100%;
            }
            
            .comments-1-div{
                
            border-bottom: 1px #1e3932 solid;
            padding-left: 0.5em;
            }

            .comments-2-div{
            background-color: #b6d8cf;
            padding-left: 0.5em;
            }

            .image-file{

            }

        
            .font-color-white{
            color: white;
            }
        
            .font-color-khblind-gold{
            color: #eee8aa;
            }
        
            .bold{
            font-weight: bold;
            }
        
            .font-size-15{
            font-size: 1.5rem;
            }
        
            .primary-background-color{
            background-color: #1e3932;
            }    

            .image-frame{
            background-color: sandybrown;
            }
            
            .primary-hr{
            border-color:#1e3932;;
            }

            .semi-hr{
            border-style: dotted;
            }
            
            /*투표 꺼*/
		    .vote-progress-bg-1{background-color: Tomato; }
		    .vote-progress-bg-2{background-color: RoyalBlue;}
		    .vote-progress-bg-3{background-color: MediumSeaGreen;}
		    .vote-progress-bg-4{background-color: GoldenRod;}
		    .vote-progress-bg-5{background-color: FireBrick;}
		    .vote-progress-bg-6{background-color: MediumBlue;}
		    .vote-progress-bg-7{background-color: saddlebrown;}
		    .vote-progress-bg-8{background-color: mediumturquoise;}
            
        
        </style>

        <!--반응형 웹 테스트-->
        <style>
            @media screen and (min-width:1200px){
                .test{
                    color: royalblue;
                }
            }

            @media screen and (max-width:1199px){
                .test{
                    color: red;   
                }
            }

            @media screen and (max-width:991px){
                .test{
                    color: orange;
                }
                #board-type > small{
                    font-size: 1.2rem;
                }
                #board-title > span{
                    font-weight: 500 !important;
                    font-size: 2.2rem;
                }

            }

            @media screen and (max-width:767px){
                .test{
                    color: green;
                }

            }
            @media screen and (max-width:575px){
                .test{
                    color: rgb(255, 0, 242);
                }
            }
    </style>

<script>
//대댓글 입력창 클릭시 대댓글 입력창 추가 스크립트
$(function(){
	$(".nestedComment-area").hide();
	$(".nestedComment-btn").click(function(){
   var originCmtNo= $(this).attr("id");
   console.log(originCmtNo);

	$("#comment-id-"+originCmtNo).show();
   
   
// 				$("#comment-id-"+originCmtNo).submit(function(){
// 				   $("#comment-id-"+originCmtNo).hide();
// 				});
   });

});
   </script>


<div class="container-fluid">
	<div id="board-detail-zone" class="offset-2 col-8 row mt-4">
		<div id="left-area" class="col-xl-8 col-lg-9 col-md-12">
			<div id="board-sector" class="row">
				
				<!--top 시작-->
				
				<div class="top col-12">
                        <div id = "board-type" class="col-12 mt-2">
                        <!-- 토픽인 경우 -->
                            <small><b>${boardType} &gt ${boardCaregoryName}</b></small>
                        </div>

                        <div id = "board-title" class="col-12 mt-3">
                            <span class="h4 font-weight-bold test">${boardDto.boardTitle}</span>
                        </div>

                        <div id = "board-write-info" class="col-12 mt-2">
                            <small><b>${companyName}</b></small>
                            <small>&nbsp;&nbsp;|&nbsp;&nbsp;</small>
                            <small>${boardMemberVO.memberNick}</small>
                        </div>

                        <div id = "board-simple-info" class="col-12 mt-2 row">
                            <div class="col-xl-2 col-sm-3 col-3">
                                <small><i class="far fa-clock">&nbsp;망할!</i></small>
                            </div>
                            <div class="col-xl-2 col-sm-3 col-3">
                                <small><i class="fas fa-mouse">&nbsp; ${boardDto.boardCount}</i></small>
                            </div>
                            <div class="col-xl-2 col-sm-3 col-3">
                            	<!-- 좋아요를 안 한 상태 -->
								<c:if test="${isLiked == 1}">
									<a class="board_unlike_btn" href="${root}/board/boardLikeInsert?boardNo=${boardDto.boardNo}">
									<small><i class="far fa-thumbs-up fa-1x">&nbsp;${boardCountDto.likeCount}</i></small></a>
								</c:if>
								
								<!-- 좋아요를 한 상태 -->
								<c:if test="${isLiked == 2}">
									<a class="deleteLike" href="${root}/board/boardUnLikeInsert?boardNo=${boardDto.boardNo}">
									<small><i class="fas fa-thumbs-up fa-1x">&nbsp;${boardCountDto.likeCount}</i></small></a>
								</c:if>
								<c:if test="${empty dtoss}">
									<div class="notLogin">
										<i class="far fa-thumbs-up fa-1x">&nbsp;${boardCountDto.likeCount}</i>
									</div>
								</c:if>
                                
                            </div>
                            <div class="col-xl-4 col-sm-0 col-xs-0"></div>
                            <div class="col-xl-2 col-sm-3 col-3">
                            
                            	<!-- 비어있는 책갈피를 누르면  bookmarkInsert를 실행하게하기 -->
								<c:if test="${isMarked == 1}">
									<a href="${root}/board/bookmarkInsert?boardNo=${boardDto.boardNo}"><small><i class="far fa-bookmark fa-1x"></i></small></a>
								</c:if>
								
								<!-- 차있는 책갈피를 누르면 bookmarkDelete를 실행하게 하기 -->
								<c:if test="${isMarked == 2}">
									<a href="${root}/board/bookmarkDelete?boardNo=${boardDto.boardNo}"><small><i class="fas fa-bookmark fa-1x"></i></small></a>
								</c:if>
								<c:if test="${empty dtoss}">
									<div class="notLogin">
										<i class="fas fa-bookmark fa-1x"></i>
									</div>
								</c:if>
                            </div>
                        </div>
                        
						<div class="col-12 mt-5">
                        <div id = "board-content" class="col-12 mt-5">
                            <p id = "board-content-viewer" class="col-12">
    							해시에 a태그, 꺽쇠 정리
    							${boardDto.boardContent}
                            </p>
                        </div>
                    </div>
				</div>
				<!-- top 끝 -->
				
				<div class="col-12 mt-2"><hr class="semi-hr"></div>
				
				<!-- middle 시작 -->
				<div id="middle" class="col-12">
	                 <div id= "image-area" class="row mt-2">
	                 <!-- 이미지 반복시작 -->
	                    <div class="image-frame offset-1 col-10 mt-3">123
	                        <img class="image-file col-12" src=""/>
	                    </div>
	                 <!-- 이미지 반복 끝 -->
	                </div>
					
					<c:if test="${VoteTopicInfo ne null}">
				       <div id="view-vote-sector" class="mt-2">
				            <div id="vote-top">
				                    <div class="vote-topic-div mt-1 mb-1 row">
				                    	<div class="empty-div col-1"></div>
				                    	<div id = "vote-topic-contents-div" class="col-8 row">
					                        <div id="topic-name" class="col-12" data-topic-no="${VoteTopicInfo.voteTopicNo}"><i class="fas fa-poll-h fa-2x"></i>&nbsp;&nbsp;${VoteTopicInfo.voteTopicTitle}</div>
				                    	</div>
				                    	<div class=col-2>
				                    	<div class="empty-div col-1"></div>
				                    		<div>
				                    			<button id=realTimeVoteOn class="btn btn-primary"><i class="fas fa-sync"></i></button>
				                    			<button id=realTimeVoteOff class="btn btn-secondary"><i class="fas fa-ban" style="color:Tomato"></i></button>
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
														<button class="vote-btn dummy-btn btn btn-secondary" disabled><small><i class="fas fa-vote-yea"></i></small></button>
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
						</c:if>
						 
						<div id="option-area" class="row mt-2"> 
							<div id="like" class="col-2">
								<a href="좋아요"><i class="far fa-thumbs-up fa-1x">&nbsp;${boardCountDto.likeCount}</i></a>
							</div>
						
	    					<div id="comment" class="col-2">
	      						<a href="댓글"><i class="far fa-comment-dots fa-1x">&nbsp;${boardCountDto.commentsCount}</i></a>
	   						</div>
	   						<div class="empty" class="col-8"></div>
						</div>              
				</div>
				<!-- middle 끝 -->
				
				<!-- bottom 시작 -->
      			<div id="botton">
					<div id="comments-area" class="row">
                
	                <div id="comments-sign" class="col-12 row">
	                    <span class="font-weight-bold col-2">댓글</span><span class="font-weight-bold col-">44</span>
	                </div>
	                <div class="col-12"><hr class="semi-hr"></div>
					
					<!-- 원댓글 작성부분 -->
	                <div id="insert-comments" class="col-12">
	                    <form action="commentInsert" method="post">
							<input type="hidden" name="boardNo" value="${boardDto.boardNo}">
	                        <textarea class="col-12" id="insert-comments-textarea" class="form-control form-control-md" name="commentsContent" placeholder="댓글을 입력해주세요"></textarea>
	                        <div class="text-right">
	                        	<input class="btn btn-secondary" type=submit" value="댓글달기">
	                        </div>
	                    </form>
	                </div>

	                <div id="comments-list" class="col-12 mt-4">
							<c:forEach var="commentsVO" items="${commentsList}">
								<c:if test="${empty commentsVO.commentsSuperNo}">
			                    <div id="comments+numbering" class="comments-1-div col-12 pb-1">
			                        <div class="top col-12 pt-2">
			                            <small><b>회사이름은 엄청~~~길수도 있다</b></small>
			                            <small>&nbsp;&nbsp;|&nbsp;&nbsp;</small>
			                            <small>아이디는숨***s**</small>
			                        </div>
			                        <div class="middle col-12">
			                            <p class="comments-content p-2">
			                                {{내용}}
			                            </p>
			                        </div>
			                        <div class="bottom col-12 row mb-3">
			                            <div class="col-2">
			                                <small><i class="far fa-clock">&nbsp;1시간</i></small>
			                            </div>
			                            <div class="col-2">
			                                <small><a href="좋아요"><i class="far fa-thumbs-up fa-1x">&nbsp;4444</i></a></small>
			                            </div>
			                            <div class="col-5"></div>
			                            <div class="col-3 text-right">
			                                <small><a href="대댓글"><i class="far fa-comment-dots fa-1x">&nbsp;대댓글달기</i></a></small>
			                            </div>
			                        </div> 
			                    </div>
								</c:if>
	                       </c:forEach>
	                    <div id="comments+numbering" class="comments-1-div col-12 pb-1">
	                        <div class="top col-12 pt-2">
	                            <small><b>회사이름은 엄청~~~길수도 있다</b></small>
	                            <small>&nbsp;&nbsp;|&nbsp;&nbsp;</small>
	                            <small>아이디는숨***s**</small>
	                        </div>
	                        <div class="middle col-12">
	                            <p class="comments-content p-2">
	                                {{내용}}
	                            </p>
	                        </div>
	                        <div class="bottom col-12 row mb-3">
	                            <div class="col-2">
	                                <small><i class="far fa-clock">&nbsp;1시간</i></small>
	                            </div>
	                            <div class="col-2">
	                                <small><a href="좋아요"><i class="far fa-thumbs-up fa-1x">&nbsp;4444</i></a></small>
	                            </div>
	                            <div class="col-5"></div>
	                            <div class="col-3 text-right">
	                                <small><a href="대댓글"><i class="far fa-comment-dots fa-1x">&nbsp;대댓글달기</i></a></small>
	                            </div>
	                        </div> 
	                    </div>
	
	                    <div id="comments+numbering" class="comments-1-div col-12 pb-1">
	                        <div class="top col-12 pt-2">
	                            <small><b>회사이름은 엄청~~~길수도 있다</b></small>
	                            <small>&nbsp;&nbsp;|&nbsp;&nbsp;</small>
	                            <small>아이디는숨***s**</small>
	                        </div>
	                        <div class="middle col-12">
	                            <p class="comments-content p-2">
	                                {{내용}}
	                            </p>
	                        </div>
	                        <div class="bottom col-12 row mb-3">
	                            <div class="col-2">
	                                <small><i class="far fa-clock">&nbsp;1시간</i></small>
	                            </div>
	                            <div class="col-2">
	                                <small><a href="좋아요"><i class="far fa-thumbs-up fa-1x">&nbsp;4444</i></a></small>
	                            </div>
	                            <div class="col-5"></div>
	                            <div class="col-3 text-right">
	                                <small><a href="대댓글"><i class="far fa-comment-dots fa-1x">&nbsp;대댓글달기</i></a></small>
	                            </div>
	                        </div> 
	                    </div>
					</div>
      			</div>
			</div>


<style>
div{
border: 1px red dotted;
}
</style>

<div>
	<div>
		<p>글번호 : ${boardDto.boardNo}</p>
	</div>
	<div>
		<p>${boardDto.memberNo}</p>
		<!-- memberNo가 아니라 닉네임 or 아이디를 띄어 줘야 함 --> 
		<p>${boardMemberVO.memberNick}</p>
	</div>
	<div>
		<p>${boardDto.boardTitle}</p>
	</div>
	<div>	
		<p>${boardDto.boardContent}</p>
	</div>
		<p>${boardDto.boardCount}</p>
		<p>${boardDto.boardDate}</p>
</div>
<!-- 글쓰기 탭은 header에 있음 -->          <!-- 현재 글번호 전달하여, 현재글의 수정페이지 이동 -->
<a href="${root}/board/boardEdit?boardNo=${boardDto.boardNo}">수정</a>
<a href="${root}/board/boardDelete?boardNo=${boardDto.boardNo}">삭제</a> 
<a href="#">목록</a>   

<!-- 좋아요를 클릭한상태 -->

<c:if test="${isLiked == 1}">
<a class="board_unlike_btn" href="${root}/board/boardLikeInsert?boardNo=${boardDto.boardNo}">
<i class="far fa-thumbs-up fa-3x"></i></a>
</c:if>
<c:if test="${isLiked == 2}">
<a class="deleteLike" href="${root}/board/boardUnLikeInsert?boardNo=${boardDto.boardNo}"><i class="fas fa-thumbs-up fa-3x"></i></a>
</c:if>
<c:if test="${empty dtoss}">
<div class="notLogin">
<i class="far fa-thumbs-up fa-3x"></i>
</div>
</c:if>

<!-- <form class="boardLikeDeleteForm" action="boardLike" -->


<!-- <form class="boardLikeInsertForm" action="boardLikeInsert"> -->
<!-- <input type="hidden" name ="board_no"> -->
<!-- </form>  -->


<!-- 비어있는 하트를 누르면  bookmarkInsert를 실행하게하기 -->
<c:if test="${isMarked == 1}">
<a href="${root}/board/bookmarkInsert?boardNo=${boardDto.boardNo}"><i class="far fa-heart"></i></a>
</c:if>

<c:if test="${isMarked == 2}">
<!-- 차있는 하트를 누르면 bookmarkDelete를 실행하게 하기 -->
<a href="${root}/board/bookmarkDelete?boardNo=${boardDto.boardNo}"><i class="fas fa-heart"></i></a>
</c:if>
<c:if test="${empty dtoss}">
<div class="notLogin">
<i class="far fa-heart"></i>
</div>
</c:if>


<!-- 댓글영역 -->

<!-- 댓글 전체영역을 감싸는  div-->
<div>
<!-- 원댓글 작성부분 -->
<form action="commentInsert" method="post">
<input type="hidden" name="boardNo" value="${boardDto.boardNo}">
<textarea name="commentsContent"></textarea>
<input type="submit">
</form>

<!-- 원댓글 출력부분 -->
   <c:forEach var="commentsVO" items="${commentsList}">
<div>
   <p>${commentsVO.commentsContent}</p>
   <p>${commentsVO.commentsMemberName}</p>
   <p>${commentsVO.commentsDate}</p>
   <button id="${commentsVO.commentsNo}" class= "nestedComment-btn">댓글달기</button>
</div>
<!-- 대댓글 입력부분 -->
<div class="nestedComment-area" id="comment-id-${commentsVO.commentsNo}">
<form action="nestedCommentInsert">
   <input type="hidden" name="superNo" value="${commentsVO.commentsNo}">
   <input type="hidden" name="boardNo" value="${boardDto.boardNo}">
   <textarea name="commentContent"></textarea>
   <input type="submit">
</form>
</div>
</c:forEach>

</div>
<!-- 대댓글 출력부분 -->
   <c:forEach var="commentsVO" items="${commentsList}">
<div>
   <p>${commentsVO.commentsContent}</p>
   <p>${commentsVO.commentsMemberName}</p>`
   <p>${commentsVO.commentsDate}</p>
   
</div>
</c:forEach>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>