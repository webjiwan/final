<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../include/header.jsp" %>
<script type="text/javascript">
	function gobackFun() {
	 	history.go(-1);
	}
	
	function insert() {
		var receive = $("#receive").val(); 
		var text = $("#text").val();
		var param = {
				"receive" : receive,
				"text" : text
		};
		
		if(receive == null || receive == '' || receive == undefined){
			errorMessage('상대 아이디를 입력해주세요');
			$('#receive').focus();
			return;
		}
		if(text == null || text == '' || text == undefined){
			errorMessage('내용을 입력해주세요');
			$('#text').focus();
			return;
		}
		
		$.ajax({
			method: "post",
			url: "${path}/message/create.do",
			data: param,
			success : function() {
				successMessage('메세지를 보냈습니다');
			},
			error : function() {
				errorMessage('로그인을 하지 않았거나 없거나 잘못된 상대방에게 보냈습니다');
			}
		});	
	}
	
</script>
</head>
<body>
	<div class="page-wrapper">
	
		<%@ include file="../include/body_header.jsp"%>
		
		<div class="main-content">
		<div class="col-lg-6" style="margin: 0 auto;">
			<div class="card">
				<div class="card-header">
					<strong>메세지 보내기</strong>
				</div>
				<div class="card-body card-block">
					<form action="${path}/message/create.do" method="post" class="form-horizontal" name="sendForm" id="sendForm">
						<div class="row form-group">
							<div class="col col-md-3">
								<label for="receive" class=" form-control-label">상대 아이디</label>
							</div>
							<div class="col-12 col-md-9">
								<input type="text" id="receive" name="receive" placeholder="상대 아이디를 입력하세요" class="form-control">
							</div>
						</div>
						<div class="row form-group">
							<div class="col col-md-3">
								<label for="text" class=" form-control-label">내용</label>
							</div>
							<div class="col-12 col-md-9">
								<textarea name="text" id="text" rows="20" style="resize: none;" placeholder="내용을 입력해 주세요." class="form-control"></textarea>
							</div>
						</div>
					</form>
				<div class="card-footer">
					<button type="submit" class="btn btn-primary btn-sm" id="insertBtn" onclick="insert()">
						<i class="fa fa-dot-circle-o"></i> 보내기
					</button>
					<button type="reset" class="btn btn-danger btn-sm" id="backBtn" onclick="gobackFun()">
						<i class="fa fa-ban"></i> 취소
					</button>
				</div>
				</div>
			</div>
		</div>
		</div>
	</div>
	<%@ include file="../include/body_js.jsp"%>
	</body>
</html>