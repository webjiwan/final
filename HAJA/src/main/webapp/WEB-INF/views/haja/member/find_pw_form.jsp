<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Hugo 0.84.0">
<title>비밀번호 찾기</title>
<script src="https://code.jquery.com/jquery-3.6.0.slim.js"></script>
<link rel="canonical" href="https://getbootstrap.com/docs/5.0/examples/sign-in/">
<!-- Bootstrap core CSS -->
<link href="../resources/assets/dist/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">
/* Style태그 */
.bd-placeholder-img {
	font-size: 1.125rem;
	text-anchor: middle;
	-webkit-user-select: none;
	-moz-user-select: none;
	user-select: none;
}

@media ( min-width : 768px) {
	.bd-placeholder-img-lg {
		font-size: 3.5rem;
	}
}
</style>
<link href="../resources/assets/dist/css/signin.css" rel="stylesheet">
</head>
<body class="text-center" style="align-content: center">
	<main class="form-signin" style="width: 430px; align-content: center;">
		<form name="form1" method="post" style="width: 400px" action="${path}/member/find_pw.do">
			<a href="${path}/member/home.do">
				<img alt="상단배너" src="../resources/assets/brand/haja-logo.jpg" width="72px" height="72">
			</a> 
			<p>
			<h1 class="h3 mb-3 fw-normal">비밀번호 찾기</h1> <br>


			<div style="width: 400px;" align="left">
				<!-- <span style="color: #989898; font-size: 12px; align-content: left;">회원가입시 작성한 이메일을 입력하세요.</span> -->
				<div class="form-floating" align="center">
					<input class="form-control" id="userid" name="userid" style="align-content: center" required>
						<label for="floatingInput">ID</label>
				</div>
				<div style="height: 5px"></div>
				<div class="form-floating" style="display: inline-block;">
				<input type="text" class="form-control" id="ssn1" name="ssn1" style="display: inline-block; width: 43.5%">
				<span style="font-size: 2rem; vertical-align: top;">&nbsp;-&nbsp;</span>
				<input type="password" class="form-control" id="ssn2" name="ssn2" style="display: inline-block; width: 44.5%">
				<label for="ssn1">주민번호</label>
			</div>
			</div>
			<div class="checkbox mb-3">
				<label> </label>
			</div>


			<button class="btn btn-lg btn-primary" type="submit" id="findBtn"
				style="background-color: #43bc9c; border-color: #43bc9c; display: inline-block; width: 49%">PW 조회</button> 
			<button class="btn btn-lg btn-primary" type="button" onclick="history.go(-1);"
				style="background-color: #43bc9c; border-color: #43bc9c; display: inline-block; width: 49%;">취 소</button>
			<div style="height:7px;"></div>
			
			
			<br> <br> <br>
			<p class="mt-5 mb-3 text-muted">
			<span><img src="../resources/assets/brand/haja-banner.jpg" width="50px"></span>
			<span style="color: gray;">Copyright</span> &copy; HAJA</p>
		</form>
	</main>
</body>
</html>