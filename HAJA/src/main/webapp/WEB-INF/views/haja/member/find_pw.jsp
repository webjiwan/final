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
<title>아이디 찾기</title>
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
<script>
	$(function(){
		$("#loginBtn").click(function(){
			location.href="${path}/member/login.do";
		});
	});
</script>
<link href="../resources/assets/dist/css/signin.css" rel="stylesheet">
</head>
<body class="text-center" style="align-content: center">
	<main class="form-signin" style="width: 430px; align-content: center;">
		<a href="${path}/member/home.do">
			<img alt="상단배너" src="../resources/assets/brand/haja-logo.jpg" width="72px" height="72">
		</a> 
		<p>
		<h1 class="h3 mb-3 fw-normal">비밀번호 찾기</h1> <br> <br>
		
		
		<div style="background-color: white; border-radius: 15px; border: 1px solid #43bc9c;">
			<br>
			<h6 style="color: #7c7c7c;">비밀번호 찾기 검색결과</h6><br>
			<div>
				<h4>
				
				당신의 PW는 <span style="font-weight: bold; color: #43bc9c;">&nbsp;${ passwd }&nbsp;</span>입니다.
				</h4> <br>
			</div>
		</div>
		
		
		<div class="checkbox mb-3"><label> </label></div>
		<button class="btn btn-lg btn-primary" type="button" id="loginBtn"
				style="background-color: #43bc9c; border-color: #43bc9c; display: inline-block; width: 49%">로그인</button>
		<div style="height:7px;"></div>
		
		<br><p class="mt-5 mb-3 text-muted">
		<span><img src="../resources/assets/brand/haja-banner.jpg" width="50px"></span>
		<span style="color: gray;">Copyright</span> &copy; HAJA</p>
	</main>
</body>
</html>