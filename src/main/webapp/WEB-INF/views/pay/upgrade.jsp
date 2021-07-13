<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<h1>결제 정보 입력</h1>
<form action="upgrade" method="post">

	<div class="row text-left">
		<label>partner_order_id</label>
		<input type= "text" name="partner_order_id" required>
	</div>
	<div class="row text-left">
		<label>partner_user_id</label>
		<input type= "text" name="partner_user_id" required>
	</div>
	<div class="row text-left">
		<label>item_name</label>
		<input type= "text" name="item_name" required>
	</div>
	<div class="row text-left">
		<label>quantity</label>
		<input type= "text" name="quantity" required>
	</div>
	<div class="row text-left">
		<label>total_amount</label>
		<input type= "text" name="total_amount" required>
	</div>
	
	<div class="row">
			<input type="submit" value="결제" class="form-btn form-btn-positive">
	</div>
	
	
</form>