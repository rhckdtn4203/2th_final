<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


  <script>
  		$(function(){
  			$("#cancelduring").click(function(e){
  				
  				var approve = ${payDto.payTime};
  				var approveArr = approve.split('-');

  				var now = new Date();
  				var nowArr = now.split('-');
		
  				var approveCompare = new Date(approveArr[0],approveArr[1],approveArr[2]);
  				var nowCompare = new Date(nowArr[0],nowArr[1],nowArr[2]);
  				
  				
	  			if(approveCompare.getTime()< nowCompare.getTime()){
	  				window.alert("취소 가능기간이 지났습니다.(취소는 결제한 당일만 가능합니다.)");
	  				e.preventDefault();	
	  			}
  				
  			});
  		});
  
  </script>  

<h2>결제 상세 내역</h2>
<p>${payDto.payStatus} , ${payDto.payTime} </p>
<ul>
	<li>거래번호 : ${searchVO.tid}</li>
	<li>
		거래상태 : ${searchVO.status}
		(
		<c:choose>
			<c:when test="${searchVO.status == 'READY'}">결제 요청</c:when>
			<c:when test="${searchVO.status == 'SEND_TMS'}">결제 요청 메시지(TMS) 발송 완료</c:when>
			<c:when test="${searchVO.status == 'OPEN_PAYMENT'}">사용자가 카카오페이 결제 화면 진입</c:when>
			<c:when test="${searchVO.status == 'SELECT_METHOD'}">결제 수단 선택, 인증 완료</c:when>
			<c:when test="${searchVO.status == 'ARS_WAITING'}">ARS 인증 진행 중</c:when>
			<c:when test="${searchVO.status == 'AUTH_PASSWORD'}">비밀번호 인증 완료</c:when>
			<c:when test="${searchVO.status == 'ISSUED_SID'}">SID 발급 완료</c:when>
			<c:when test="${searchVO.status == 'SUCCESS_PAYMENT'}">결제 성공</c:when>
			<c:when test="${searchVO.status == 'CANCEL_PAYMENT'}">결제 취소</c:when>
			<c:when test="${searchVO.status == 'FAIL_AUTH_PASSWORD	'}">사용자 비밀번호 인증 실패</c:when>
			<c:when test="${searchVO.status == 'QUIT_PAYMENT'}">사용자 결제 중단</c:when>
			<c:when test="${searchVO.status == 'FAIL_PAYMENT'}">결제 승인 실패</c:when>
		</c:choose>
		)
	</li>
	<li>
		주문 번호 : ${searchVO.partner_order_id}
	</li>
	<li>
		지불 방식 : ${searchVO.payment_method_type}
		(
			<c:choose>
				<c:when test="${searchVO.payment_method_type == 'MONEY'}">현금</c:when>
				<c:when test="${searchVO.payment_method_type == 'CARD'}">카드</c:when>
			</c:choose>
		)
	</li>
	<li>
		승인 금액 : 
		총 ${searchVO.amount.total}원
		(
		비과세 ${searchVO.amount.tax_free}원, 
		부가세 ${searchVO.amount.vat}원
		)
	</li>
	<li>
		상품명 : ${searchVO.item_name}
		<c:if test="${searchVO.item_code != null}">(코드 : ${searchVO.item_code})</c:if>
	</li>
	<li>
		상품 수량 : ${searchVO.quantity}
	</li>
	<li>
		결제 시작 : ${searchVO.created_at}
	</li>
	<li>
		결제 완료 : ${searchVO.approved_at}
	</li>
	<c:if test="${searchVO.canceled_at != null}">
		결제 취소 : ${searchVO.canceled_at}
	</c:if>
	<li>
		결제 기록
		<ul>
			<c:forEach var="action" items="${searchVO.payment_action_details}">
				<li>
					상태 : ${action.payment_action_type}
					(
						<c:choose>
							<c:when test="${action.payment_action_type == 'PAYMENT'}">결제</c:when>
							<c:when test="${action.payment_action_type == 'CANCEL'}">결제취소</c:when>
							<c:when test="${action.payment_action_type == 'ISSUED_SID'}">SID발급</c:when>
						</c:choose>
					),
					일시 : ${action.approved_at},
					금액 : ${action.amount}원
				</li>
			</c:forEach>
		</ul>
	</li>
</ul>

<c:if test="${searchVO.status == 'SUCCESS_PAYMENT}">
	<a href="payCancel?payNo=${payDto.payNo}&cancel_amount=${searchVO.amount.total}" id="cancelduring">결제 취소 </a>
</c:if>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>