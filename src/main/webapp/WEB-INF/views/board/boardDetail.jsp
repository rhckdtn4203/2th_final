<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<!--			제이쿼리를 가져온다	 -->
        <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<!--         UI제이쿼리를  가져온다 -->
        <script  src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"  integrity="sha256-T0Vest3yCU7pafRw9r+settMBX6JkKN06dqBnpQ8d30="   crossorigin="anonymous"></script>
<!--         폰트어썸 아이콘을 가져온다 -->
         <script src="https://kit.fontawesome.com/77858aaef8.js" crossorigin="anonymous"></script>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap_reboot.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap_grid.css">

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
						console.log("누군가 투표함");
						var messageObject = JSON.parse(message.data);//String --> JSON Object
						
						$.ajax({//2-1. onmessage 중 다른 사람 투표 반영 당하기!
							url: "${pagecontext.request.contextpath}/khblind/board/getOthersVotingInfo",
							data:{voteOptionNo: messageObject.voteOptionNo},
							type: "GET",
								success:function(resp){

// 										console.log("얘구조부터알아보자" + resp.voteOptionNo); //66
// 										console.log("얘구조부터알아보자" + resp.voteOptionCount); //22
										var target = $("#option-"+ resp.voteOptionNo +"-gauge");
										console.log(target);
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

						var topicNo = ${VoteTopicInfo.voteTopicNo};
// 						var topicNo = $("#topic-id").data("topic-no");
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
					console.log("소켓 닫기");
					var topicNo = ${VoteTopicInfo.voteTopicNo};
					var message = {receivePayloadType:3, voteTopicNo: topicNo};
					console.log(message + "메시지")
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
				var topicNo = ${VoteTopicInfo.voteTopicNo};
// 				var topicNo = $("#topic-id").data("topic-no");
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
	
	<!-- 이미지 불러오기 -->
	<script>
	$(function(){
		//이미지 불러오기 테스트
		$("#image-load").click(function(){
			$(this).hide();
			console.log("이미지 로딩중! 버튼 삭제")
			var boardNo = ${boardDto.boardNo};
			$.ajax({
					url: "${pagecontext.request.contextpath}/khblind/board/getImageInfo",
					data:{
						boardNo: boardNo
					},
					type: "GET",
					success:function(resp){
						console.log("성공");
						console.log(resp);
						
						for(var i=0; i < resp.length; i++){
							var fileUrlInLocal = resp[i].boardImageUrl;
							
							console.log(typeof(fileUrlInLocal));
							console.log("full경로는 " + fileUrlInLocal);
							console.log("길이는 "+fileUrlInLocal.length)
							
							var lengthFull = fileUrlInLocal.length;
							var lengthExceptFileName=lengthFull-14;
							//파일이름 길이는 총 14개
							//fileUrlInLocal.length() 
							var fileName =fileUrlInLocal.substr(lengthExceptFileName, 14);
							var url = "${pagecontext.request.contextpath}/khblind/board/getImageFlie?boardNo="+ boardNo +"&" + "fileName="+fileName;
							
							console.log(url);
							
							var template = $("#image-template").html();
							template = template.replace("{{url}}", url);
							
							$("#image-list").append(template);
						}
					}
				
			})
			
		})
	})
	</script>
	
	<script>
	//대댓글 입력창 클릭시 대댓글 입력창 추가 스크립트
	$(function(){
		$(".nestedComment-btn").click(function(){
	   var originCmtNo= $(this).attr("id");
	   console.log(originCmtNo);
		
	   	$(".nestedComment-area").hide();
		$("#comment-id-"+originCmtNo).show();
	   
	// 				$("#comment-id-"+originCmtNo).submit(function(){
	// 				   $("#comment-id-"+originCmtNo).hide();
	// 				});
	   });
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

        
            #board-content-viewer{
            word-wrap: break-word;
            font-size: 14px;
            font-family: "Roboto","Noto Sans KR",AppleSDGothicNeo-Regular,"Malgun Gothic","맑은 고딕",dotum,"돋움",sans-serif;
            margin-block-start: 0.2em;
            margin-block-end: 0.2em;
            }

            #insert-comments1-textarea {
            min-height: 4.5rem;
            overflow-y: visible;
            resize: none;
            border-radius: 1em;
            border-bottom-right-radius: 0;
            padding-top: 0.75em;
            padding-left: 1.5em;
            }
            
          	#insert-comments2-textarea {
            min-height: 4.5rem;
            overflow-y: visible;
            resize: none;
            border-radius: 1em;
            border-bottom-right-radius: 0;
            padding-top: 0.75em;
            padding-left: 1.5em;
            }

            .comments-content{
            min-height: 4.5em;
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
			border-bottom: 1px #1e3932 solid;
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
            
            .primary-hr{
            border-color:#1e3932;;
            }

            .semi-hr{
            border-style: dotted;
            }
            
            .comments2{
			background-color: silver;
			}
			
			.image-frame{ /*반응형 필수*/
			margin-left : auto; 
			margin-right : auto;
			width : 550px;
			}
			
			.msg-3{
			font-size: 0.8em;
			color: blue;
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
	            
        .bbxb{
		box-sizing: border-box;
		}
		
		.vote-btn{
		margin-bottom: auto;
		}
		
		#wrap{
		text-align: left;
		}
}
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

<div class="container-fluid bbxb">
	<div id="board-detail-zone" class="offset-1 col-10 row mt-4 bbxb">
		<div id="left-area" class="col-9 bbxb">
			<div id="board-sector" class="row bbxb">
				
				<!--top 시작-->
				<div class="top col-12">
                        <div id = "board-type" class="col-12 mt-2 bbxb">
                        <!-- 토픽인 경우 -->
                            <small><b>${boardType} &gt ${boardCaregoryName}</b></small>
                        </div>

                        <div id = "board-title" class="col-12 mt-3">
                            <span class="h4 font-weight-bold test bbxb">${boardDto.boardTitle}</span>
                        </div>

                        <div id = "board-write-info" class="col-12 mt-2 bbxb">
                            <small><b>${companyName}</b></small>
                            <small>&nbsp;&nbsp;|&nbsp;&nbsp;</small>
                            <small>${boardMemberVO.memberNick}</small>
                        </div>

                        <div id = "board-simple-info" class="col-12 mt-2 row bbxb">
                            <div class="col-xl-2 col-sm-3 col-3 bbxb">
                                <small><i class="far fa-clock">&nbsp;망할!</i></small>
                            </div>
                            <div class="col-xl-2 col-sm-3 col-3 bbxb">
                                <small><i class="fas fa-mouse">&nbsp; ${boardDto.boardCount}</i></small>
                            </div>
                            <div class="col-xl-2 col-sm-3 col-3 bbxb">
                            
                            	<!-- 로그인을 안 한 상태 -->
								<c:if test="${empty dtoss}">
									<div class="notLogin bbxb">
										<small><i class="far fa-thumbs-up fa-1x">&nbsp;${boardCountDto.likeCount}</i></small>
									</div>
								</c:if>
								
								<!-- 로그인은 한 상태 -->
								<c:if test="${not empty dtoss}">
	                            	<!-- 좋아요를 안 한 상태 -->
									<c:if test="${isLiked == 1}">
										<a class="board_unlike_btn bbxb" href="${root}/board/boardLikeInsert?boardNo=${boardDto.boardNo}">
										<small><i class="far fa-thumbs-up fa-1x bbxb">&nbsp;${boardCountDto.likeCount}</i></small></a>
									</c:if>
									
									<!-- 좋아요를 한 상태 -->
									<c:if test="${isLiked == 2}">
										<a class="deleteLike bbxb" href="${root}/board/boardUnLikeInsert?boardNo=${boardDto.boardNo}">
										<small><i class="fas fa-thumbs-up fa-1x bbxb">&nbsp;${boardCountDto.likeCount}</i></small></a>
									</c:if>
								</c:if>
                                
                            </div>
                            <div class="col-xl-4 col-sm-0 col-xs-0 bbxb"></div>
                            <div class="col-xl-2 col-sm-3 col-3 bbxb">
                            
                            <!-- 로그인을 안 한 상태 -->
								<c:if test="${empty dtoss}">
									<div class="notLogin bbxb">
										<i class="far fa-bookmark fa-1x bbxb"></i>
									</div>
								</c:if>
								
								<c:if test="${not empty dtoss}">
	                            	<!-- 비어있는 책갈피를 누르면  bookmarkInsert를 실행하게하기 -->
									<c:if test="${isMarked == 1}">
										<a href="${root}/board/bookmarkInsert?boardNo=${boardDto.boardNo}"><small><i class="far fa-bookmark fa-1x bbxb" ></i></small></a>
									</c:if>
								
									<!-- 차있는 책갈피를 누르면 bookmarkDelete를 실행하게 하기 -->
									<c:if test="${isMarked == 2}">
										<a href="${root}/board/bookmarkDelete?boardNo=${boardDto.boardNo}"><small><i class="fas fa-bookmark fa-1x bbxb"></i></small></a>
									</c:if>
								</c:if>
                            </div>
                        </div>
                        
						<div class="col-12 mt-5">
                        <div id = "board-content" class="col-12 mt-5 bbxb">
                            <p id = "board-content-viewer" class="col-12 bbxb">
    							${boardDto.boardContent}
                            </p>
                        </div>
                    </div>
				</div>
				<!-- top 끝 -->
				
				<div class="col-12 mt-2 bbxb"><hr class="semi-hr bbxb"></div>
				
				<!-- middle 시작 -->
				<div id="middle" class="col-12 bbxb">
	                 <div id= "image-area" class="row text-center mt-2 bbxb">
	                 <!-- 이미지 반복시작 -->
	                 <button id="image-load" class="btn btn-primary btn-block bbxb">이미지 불러오기</button>
						<div>
		                    <div id="image-list" class="image-frame col-12 mt-3 row text-center bbxb">
		                         
		                    </div>
						</div>
	                 <!-- 이미지 반복 끝 -->
	                </div>
	                
					<c:if test="${VoteTopicInfo.voteTopicNo != 0}">
				       <div id="view-vote-sector" class="mt-2 bbxb">
				            <div id="vote-top">
				                    <div class="vote-topic-div mt-1 mb-1 row bbxb">
				                    	<div class="empty-div col-1 bbxb"></div>
				                    	<div id = "vote-topic-contents-div" class="col-8 row bbxb">
					                        <div id="topic-name" class="col-12" data-topic-no="${VoteTopicInfo.voteTopicNo}"><i class="fas fa-poll-h fa-2x bbxb"></i>&nbsp;&nbsp;${VoteTopicInfo.voteTopicTitle}</div>
				                    	</div>
				                    	<div class=col-2>
				                    	<div class="empty-div col-1 bbxb"></div>
				                    		<div class="text-right bbxb">
				                    			<button id=realTimeVoteOn class="btn btn-primary bbxb"><i class="fas fa-sync bbxb"></i></button>
				                    			<button id=realTimeVoteOff class="btn btn-secondary bbxb"><i class="fas fa-ban bbxb" style="color:Tomato"></i></button>
				                    		</div>
				                        </div>
				                    </div>
				               </div>
				                <div class="empty-div mb-3 bbxb"></div>
				                <div id="vote-middle">
									<div id="vote-option-divS" class="col-12 bbxb">
										<c:forEach var="VoteOptionInfo" items="${VoteOptionInfo}">
											<div class="vote-option-div row mt-1 mb-1 bbxb">
												<div class="col-3 align-middle bbxb">
													<div>
														<div id ="option-${VoteOptionInfo.voteOptionNo}-name-div">
															<span id ="option-${VoteOptionInfo.voteOptionNo}-name" class="mt-1 mb-1">${VoteOptionInfo.voteOptionName}</span>								
														</div>
													</div>
												</div>
												<div class="col-6">
													<div class="progress" style="height: 20px;">
														<div 
															id ="option-${VoteOptionInfo.voteOptionNo}-gauge"
															class="progress-bar vote-progress-bg-4 bbxb" 
															role="progressbar" 
															style="width: ${VoteOptionInfo.voteOptionPercent}%;" 
															aria-valuenow="${VoteOptionInfo.voteOptionPercent}" 
															aria-valuemin="0" 
															aria-valuemax="100">
															${VoteOptionInfo.voteOptionPercent}% (${VoteOptionInfo.voteOptionCount}표)
														</div>
													</div>
												</div>
												<div class="col-1">
<%-- 														<c:if test =${isLogin eq 'true'}> --%>
															<c:if test="${didYouVote eq 'voted'}">
																<button class="dummy-btn btn btn-secondary btn-light vote-btn" disabled><small><i class="fas fa-vote-yea bbxb" style="color:gray"></i></small></button>
															</c:if>
															<c:if test="${didYouVote eq 'didntVote'}">
																<button data-option-no="${VoteOptionInfo.voteOptionNo}" class="active-btn btn btn-disable bbxb vote-btn"><small><i class="fas fa-vote-yea"></i></small></button>
															</c:if>
<%-- 														</c:if> --%>
														<c:if test="${isLogin eq 'false'}">
															<button data-option-no="${VoteOptionInfo.voteOptionNo}" class="vote-btn active-btn btn btn-disable bbxb vote-btn"><small><i class="fas fa-vote-yea"></i></small></button>
														</c:if>
												</div>
											</div>
										</c:forEach>
										<c:if test="${isLogin eq 'false'}">
												<div class="m-5 text-center bbxb"><span class="msg-3">투표하시려면 로그인해주세요.</span></div>
										</c:if>
									</div>
								</div>
							</div>
						</c:if>

						<div id="option-area" class="row mt-2 bbxb"> 
							<div id="like" class="col-2 bbxb">
								<c:if test="${not empty dtoss}">
	                            	<!-- 좋아요를 안 한 상태 -->
									<c:if test="${isLiked == 1}">
										<a class="board_unlike_btn bbxb" href="${root}/board/boardLikeInsert?boardNo=${boardDto.boardNo}">
										<small><i class="far fa-thumbs-up fa-1x bbxb">&nbsp;${boardCountDto.likeCount}</i></small></a>
									</c:if>
									
									<!-- 좋아요를 한 상태 -->
									<c:if test="${isLiked == 2}">
										<a class="deleteLike bbxb" href="${root}/board/boardUnLikeInsert?boardNo=${boardDto.boardNo}">
										<small><i class="fas fa-thumbs-up fa-1x bbxb">&nbsp;${boardCountDto.likeCount}</i></small></a>
									</c:if>
								</c:if>
							</div>
						
	    					<div id="comment" class="col-2 bbxb">
	      						<i class="far fa-comment-dots fa-1x bbxb">&nbsp;${boardCountDto.commentsCount}</i>
	   						</div>
	   						<div class="col-4 bbxb"></div>
	   						<div class="col-2 bbxb">
	   							<a href="${root}/board/boardEdit?boardNo=${boardDto.boardNo}">수정</a>
	   						</div>	
	   						<div class="col-2 bbxb">
	   							<a href="${root}/board/boardDelete?boardNo=${boardDto.boardNo}">삭제</a> 
	   						</div>
						</div>
				</div>
				<!-- middle 끝 -->
				
				<!-- bottom 시작 -->
      			<div id="botton" class="row bbxb">
					<div id="comments-area" class="row col-12 bbxb">
                
<!-- 	                <div id="comments-sign" class="col-12 row bbxb"> -->
<!-- 	                    <span class="font-weight-bold col-2">댓글</span><span class="font-weight-bold  bbxb">44</span> -->
<!-- 	                </div> -->
	                <div class="col-12"><hr class="semi-hr"></div>
					
					<!-- 원댓글 작성부분 -->
	                <div id="insert-comments" class="col-12 bbxb">
	                    <form action="commentInsert" method="post">
							<input type="hidden" name="boardNo" value="${boardDto.boardNo}">
	                        <textarea class="col-12" id="insert-comments1-textarea" class="form-control form-control-md bbxb" name="commentsContent" placeholder="댓글을 입력해주세요"></textarea>
	                        <div class="text-right bbxb">
	                        	<button class="btn btn-secondary btn-sm" type="submit">댓글달기</button>
	                        </div>
	                    </form>
	                </div>
					
	                <div id="comments-list" class="col-12 mt-4 bbxb">
  						 <c:forEach var="commentsVO" items="${commentsList}">
							<c:if test="${commentsVO.commentsSuperNo == 0}">
			                    <div id="comments-${commentsVO.commentsNo}" class="comments-1-div col-12 pb-1 bbxb">
			                        <div class="top col-12 pt-2">
			                            <small><b>${commentsVO.companyName}</b></small>
			                            <small>&nbsp;&nbsp;|&nbsp;&nbsp;</small>
			                            <small>${commentsVO.memberNick}</small>
			                        </div>
			                        <div class="middle col-12 bbxb">
			                            <p class="comments-content p-2 bbxb">
			                                ${commentsVO.commentsContent}
    				                            <c:if test="${commentsVO.ownComments == 1}">
    				                            <!-- 여기 -->
    				                            <b>내 댓글입니다??!?!??</b>
				                                </c:if>
              				                    <c:if test="${commentsVO.ownComments == 0}">
              				                    <b>남의 댓글입니다!!</b>
				                                </c:if>
			                            </p>
			                        </div>
			                        <div class="bottom col-12 row mb-3 bbxb">
			                            <div class="col-3">
			                                <small><i class="far fa-clock">&nbsp;망할</i></small>
			                            </div>
<!-- 			                            <div class="col-2"></div> -->
			                            <div class="col-2 text-right bbxb">
											<a>
		                            			<small><i id="edit-${commentsVO.commentsNo}" class="far fa-edit bbxb"></i></small>
											</a>
			                            </div>
			                            <div class="col-2 text-right bbxb">
				                            <form action="commentsDelete" method="get">
											   <input type="hidden" name="boardNo" value="${boardDto.boardNo}">
											   <input type="hidden" name="commentsNo" value="${commentsVO.commentsNo}">
											   <input type="submit" value="삭제">
											</form>
			                            </div>
			                            <div class="col-5 text-right bbxb">
										<button id="write-comments2-to-${commentsVO.commentsNo}">대댓글</button>
<%-- 			                                <small><i id="write-comments2-to-${commentsVO.commentsNo}" class="far fa-comment-dots fa-1x nestedComment-btn">&nbsp;</i></small> --%>
			                            </div>
			                        </div> 
			                    </div>
			                    
			            	<!-- 대댓글 입력 -->
			                    <div class="nestedComment-area mt-2 mb-4 bbxb" id="comment-id-${commentsVO.commentsNo}">
			                            <form action="nestedCommentInsert" method="post">
			                            	   <input type="hidden" name="superNo" value="${commentsVO.commentsNo}">
											   <input type="hidden" name="boardNo" value="${boardDto.boardNo}">
											   <input type="hidden" name="commentsGroupNo" value="${commentsVO.commentsNo}">
											   <textarea id="insert-comments2-textarea" name="commentsContent" class="form-control form-control-md bbxb"></textarea>
				   								<div class="text-right bbxb">
	                        						<button class="btn btn-secondary btn-sm bbxb" type="submit">댓글달기</button>
	                        					</div>
			                            </form>
			                    </div>
								</c:if>
								
								
								<c:if test="${commentsVO.commentsSuperNo != 0}">
				                    <div id="comments-${commentsVO.commentsNo}" class="comments-2-div col-12 pb-1 bbxb">
				                        <div class="top col-12 pt-2">
				                            <small><b>${commentsVO.companyName}</b></small>
				                            <small>&nbsp;&nbsp;|&nbsp;&nbsp;</small>
				                            <small>${commentsVO.memberNick}</small>
				                        </div>
				                        <div class="middle col-12 bbxb">
				                            <p class="comments-content p-2 bbxb">
				                                ${commentsVO.commentsContent}
				                            </p>
				                        </div>
				                        <div class="bottom col-12 row mb-3 bbxb">
				                            <div class="col-4 bbxb">
				                                <small><i class="far fa-clock">&nbsp;망할</i></small>
				                            </div>
				                            <div class="col-5 bbxb"></div>
				                            <div class="col-3 text-right bbxb">
				                             
				                            </div>
				                        </div> 
				                    </div>
								</c:if>
	                       </c:forEach><!-- 댓글 끝 -->
						</div>
						
					</div>
   				</div>
   			</div>
   		</div>
		<div id="ad-area" class="col-3 aaaa bbxb">
		         	광고가 나온다
		</div>
   	</div>
</div>

<script id="image-template" type="text/template">
        <div class="offset-1 row">
            <img class="mx-auto image-frame" src="{{url}}">
        </div>
		<hr>
</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>