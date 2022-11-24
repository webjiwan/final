<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.slim.js"></script>
<script>
	$(function() {
		$("#btnUpdate").click(function() {
			if (confirm("수정 완료 하시겠습니까?")) {
				document.form1.action = "${path}/member/update.do";
				document.form1.submit();
			}
		});
		$("#btnDelete").click(function() {
			if (confirm("삭제하시겠습니까?")) {
				document.form1.action = "${path}/member/delete.do";
				document.form1.submit();
			}
		});
	});
</script>
<style type="text/css">
.table_tr {
	height: 40px;
	font-weight: bold;
}
.td_1 {
	text-align: center;
	font-size: 17px;
}
.tb_input:hover {
	color: black;
}
.tb_input {
	height: 40px;
	width: 83%;
	border-radius: 7px;
	border-color: #43bc9c;
	background-color: #white;
	text-align: center;
	font-size: 20px;
	color: #838383;
}
.table_blank {
	height: 10px;
}
.table_button {
	width: 250px;
	height: 60px;
	border-radius: 15px;
	border-color: #43bc9c;
	font-size: 30px;
	font-weight: bold;
	background-color: #43bc9c;
	color: white;
}
</style>
</head>
<body style="background-color: #f5f5f5; align-content: center; text-align: center;">
	<div align="center">
	<main class="form-signin" style="align-content: center; text-align: center; width: 700px">
		<div>
			<a href="${path}/member/home.do">
				<img alt="상단배너" src="../resources/assets/brand/haja-banner.jpg" width="100px">
			</a>
		</div>
		<h2>
			<span style="font-weight: bold; color: #43bc9c;">| </span>
			회원정보 수정<span style="font-weight: bold; color: #43bc9c;"> |</span>
		</h2>



			<div style="border: 2px #43bc9c solid; border-radius: 20px;" align="center">
				<form name="form1" method="post" style="margin: 30px;">
					<table style="width: 600px;">
						<tr class="table_tr">
							<td class="td_1">아이디</td>
							<td>&nbsp;<input style="background-color: #cfcfcf;" class="tb_input" name="userid" value="${dto.userid}" readonly>
							</td>
						</tr>
						<tr class="table_blank"></tr>
						<tr class="table_tr">
							<td class="td_1">비밀번호</td>
							<td>&nbsp;<input class="tb_input" type="password" name="passwd"></td>
						</tr>
						<tr class="table_blank"></tr>
						<tr class="table_tr">
							<td class="td_1">이름</td>
							<td>&nbsp;<input class="tb_input" name="name" value="${dto.name}"></td>
						</tr>
						<tr class="table_blank"></tr>
						<tr class="table_tr">
							<td class="td_1">이메일</td>
							<td>&nbsp;<input class="tb_input" name="email" value="${dto.email}"></td>
						</tr>
						<tr class="table_blank"></tr>
						<tr class="table_tr">
							<td class="td_1">전화번호</td>
							<td>&nbsp;<input class="tb_input" name="tel" value="${dto.tel}"></td>
						</tr>
						<tr class="table_blank"></tr>
						<tr class="table_tr">
							<td class="td_1">팀이름</td>
							<td>&nbsp;<input class="tb_input" name="teamid" value="${dto.teamid}"></td>
						</tr>
					</table>
					<br><br> 
					<input class="table_button" type="button" value="수  정" id="btnUpdate"> &nbsp;
					<input class="table_button" type="button" value="삭  제" id="btnDelete">
					<div style="color: red;">${message}</div>
				</form>
			</div>
			<br>
			<br>
			<p class="mt-5 mb-3 text-muted">
			<span><img src="../resources/assets/brand/haja-banner.jpg" width="50px"></span>
			<span style="color: gray;">Copyright</span> &copy; HAJA</p>
		</main>
	</div>
</body>
</html>
