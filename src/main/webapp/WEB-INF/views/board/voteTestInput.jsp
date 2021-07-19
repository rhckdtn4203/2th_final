<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
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

</style>

<script>
    $(function(){
        $("#plus-option-btn").on("click", function(e){
            e.preventDefault();
            console.log("현재는" + $('.vote-option-div').length);
            console.log("항목추가");

            var count = $('.vote-option-div').length;
            if(count <= 7){
                var template = $("#vote-option-div-template").html();

                template = template.replace("{{count}}", count+1);
                $("#vote-option-divS").append(template);
                count = $('.vote-option-div').length;
                if(count  > 7){
                    $("#plus-option-btn").hide();
                }
            }

        })

    })
</script>

<script id="vote-option-div-template" type="text/template">
    <div class="vote-option-div row mt-1 mb-1">
        <div class="col-3 align-middle">
            <p>항목 {{count}}</p>
        </div>
        <div class="col-9">
            <input type="text" name="voteTopicOption" class="form-control">
        </div>
    </div>
</script>

</head>
<body>
    <div class="write-zone">
        <div><br><br><br>
            
            <textarea>


            </textarea>
            <br><br><br><br></div>
        <div><br><br><br>사진업로드부분<br><br><br><br></div>
        
        <div id="input-vote-sector"  class="mt-2">
            <form action="inputVote" method="post">
                           <div id="vote-top">
                    <div class="vote-topic-div mt-1 mb-1">
                        <label for="vote-topic" class="display-6">투표제목</label>
                            <span><input id="vote-topic" class="form-control" type="text" name="voteTopicTitle"></span>
                    </div>
               </div>
                <div class="empty-div mb-3"></div>

                <div id="vote-middle">
                        <div id="vote-option-divS" class="offset-1 col-8">
                            <div class="vote-option-div row mt-1 mb-1">
                                <div class="col-3 align-middle">
                                    <p>항목 1</p>
                                </div>
                                <div class="col-9">
                                    <input type="text" name="voteTopicOption" class="form-control">
                                </div>
                            </div>
                            
                            <div class="vote-option-div row mt-1 mb-1">
                                <div class="col-3 align-middle">
                                    <p>항목 2</p>
                                </div>
                                <div class="col-9">
                                    <input type="text" name="voteTopicOption" class="form-control">
                                </div>
                            </div>
            
                            <div class="vote-option-div row mt-1 mb-1">
                                <div class="col-3 align-middle">
                                    <p>항목 3</p>
                                </div>
                                <div class="col-9">
                                    <input type="text" name="voteTopicOption" class="form-control">
                                </div>
                            </div>
                        </div>

                        <div id="vote-setting-div-zone" class="offset-1 col-8">
                            <div class="plus-option-div mt-1 mb-1">
                                <button id="plus-option-btn" class="btn btn-warning">+</button>
                            </div>
                        </div>
                    </div>

                    <div id="vote-bottom" class="offset-1 col-8">
                        <div class="submit-div mt-1 mb-1 text-right">
                            <input type="submit" class="btn btn-success" value="등록">
                        </div>
                    </div>
	            </form>
			</div>   


        </div>

        <div><br><br>해시태그부분<br><br><br></div>
    </div>

</body>
</html>