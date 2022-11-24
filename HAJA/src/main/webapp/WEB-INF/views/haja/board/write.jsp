<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<%@ include file="../include/header.jsp" %>
		<script type="text/javascript">
			function gobackFun() {
			 	history.go(-1);
			}
			
			function insert() {
				var temp = true;
				var category = $("#category").val(); 
				var title = $("#title").val();
				var place = $("#place").val();
				var calendar = $("#calendar").val();
				var content = $("#content").val(); 
				
				
				if(category == null || category == '' || category == undefined){
					alert('종목을 선택해주세요.');
					$('#category').focus();
					temp = false;
				}
				if(title == null || title == '' || title == undefined){
					alert('제목을 입력해주세요.');
					$('#title').focus();
					temp = false;
				}
				if(place == null || place == '' || place == undefined){
					alert('장소를 입력해주세요.');
					$('#place').focus();
					temp = false;
				}
				if(calendar == null || calendar == '' || calendar == undefined){
					alert('날짜를 입력해주세요.');
					$('#calendar').focus();
					temp = false;
				}
				if(content == null || content == '' || content == undefined){
					alert('내용을 입력해주세요.');
					$('#content').focus();
					temp = false;
				}
				if (temp) {document.writeForm.submit();} 
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
					<strong>글 쓰기</strong>
				</div>
				<div class="card-body card-block">
					<form action="${path}/board/insert.do" method="post" class="form-horizontal" name="writeForm" id="writeForm">
						<div class="row form-group">
							<div class="col col-md-3">
								<label for="select" class=" form-control-label">종목 선택</label>
							</div>
							<div class="col-12 col-md-9">
								<select name="category" id="category" class="form-control">
									<option value="0" disabled selected>종목을 선택해주세요.</option>
									<option value="soccer">축구</option>
									<option value="basketball">농구</option>
									<option value="baseball">야구</option>
									<option value="etc">기타</option>
								</select>
							</div>
						</div>
						<div class="row form-group">
							<div class="col col-md-3">
								<label for="title" class=" form-control-label">제목</label>
							</div>
							<div class="col-12 col-md-9">
								<input type="text" id="title" name="title" placeholder="제목을 입력해 주세요." class="form-control">
							</div>
						</div>
						<div class="row form-group">
							<div class="col col-md-3">
								<label for="place" class=" form-control-label">장소</label>
							</div>
							<div class="col-12 col-md-9">
								<input type="text" id="place" name="place" placeholder="장소를 입력해 주세요." class="form-control">
							</div>
						</div>
						<div class="row form-group">
							<div class="col col-md-3">
								<label for="calendar" class=" form-control-label">날짜</label>
							</div>
							<div class="col-12 col-md-9">
								<input type="datetime-local" id="calendar" name="calendar" class="form-control">
							</div>
						</div>
						<div class="row form-group">
							<div class="col col-md-3">
								<label for="content" class=" form-control-label">내용</label>
							</div>
							<div class="col-12 col-md-9">
								<textarea name="content" id="content" rows="9" placeholder="내용을 입력해 주세요." class="form-control"></textarea>
							</div>
						</div>
					</form>
				<div class="card-footer">
					<button type="submit" class="btn btn-primary btn-sm" id="insertBtn" onclick="insert()">
						<i class="fa fa-dot-circle-o"></i> 글 등록
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