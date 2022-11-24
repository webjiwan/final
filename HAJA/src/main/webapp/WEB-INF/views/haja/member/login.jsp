<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Hugo 0.84.0">
<title>Signin Template · Bootstrap v5.0</title>
<script src="https://code.jquery.com/jquery-3.6.0.slim.js"></script>
<script>

$(document).ready(function(){
    var userInputId = getCookie("userInputId");//저장된 쿠기값 가져오기
    $("input[name='userid']").val(userInputId); 
     
    if($("input[name='userid']").val() != ""){ // 그 전에 ID를 저장해서 처음 페이지 로딩
                                           // 아이디 저장하기 체크되어있을 시,
        $("#idSaveCheck").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
    }
     
    $("#idSaveCheck").change(function(){ // 체크박스에 변화가 발생시
        if($("#idSaveCheck").is(":checked")){ // ID 저장하기 체크했을 때,
            var userInputId = $("input[name='userid']").val();
            setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
        }else{ // ID 저장하기 체크 해제 시,
            deleteCookie("userInputId");
        }
    });
     
    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
    $("input[name='userid']").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
        if($("#idSaveCheck").is(":checked")){ // ID 저장하기를 체크한 상태라면,
            var userInputId = $("input[name='userid']").val();
            setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
        }
    });
});
 
function setCookie(cookieName, value, exdays){
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
    document.cookie = cookieName + "=" + cookieValue;
}
 
function deleteCookie(cookieName){
    var expireDate = new Date();
    expireDate.setDate(expireDate.getDate() - 1);
    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
}
 
function getCookie(cookieName) {
    cookieName = cookieName + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cookieName);
    var cookieValue = '';
    if(start != -1){
        start += cookieName.length;
        var end = cookieData.indexOf(';', start);
        if(end == -1)end = cookieData.length;
        cookieValue = cookieData.substring(start, end);
    }
    return unescape(cookieValue);
}

$(function(){
	$("#btnLogin").click(function(){
		var userid=$("#userid").val(); //태그의 value 속성값
		var passwd=$("#passwd").val();
		if(userid==""){
			alert("아이디를 입력하세요.");
			$("#userid").focus(); //입력 포커스 이동
			return; //함수 종료
		}
		if(passwd==""){
			alert("비밀번호를 입력하세요.");
			$("#passwd").focus();
			return;
		}
		//폼 데이터를 서버로 제출
		document.form1.action="${path}/member/login_check.do";
		document.form1.submit();
	});
	$("#btnJoin").click(function() {
		document.form1.action="${path}/member/join.do";
		document.form1.submit();
	});
	$("#btnIdFind").click(function() {
	      location.href="${path}/member/find_id_form.do";
	});
	 $("#btnPwFind").click(function() {
	location.href="${path}/member/find_pw_form.do";
	});
});
</script>
<link rel="canonical"
	href="https://getbootstrap.com/docs/5.0/examples/sign-in/">



<!-- Bootstrap core CSS -->
<link href="../resources/assets/dist/css/bootstrap.min.css"
	rel="stylesheet">

<style>
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

/* 이 부분이 체크 해제 했을경우 보이는? 빈 박스 */
input[type="checkbox"] {
	-webkit-appearance: none;
	position: relative;
	width: 14px;
	height: 14px;
	cursor: pointer;
	outline: none !important;
	border: 1px solid #43bc9c;
	border-radius: 2px;
	background: #fbfbfb;
}

input[type="checkbox"]::before {
	content: "\2713";
	position: absolute;
	top: 50%;
	left: 50%;
	overflow: hidden;
	transform: scale(0) translate(-50%, -50%);
	line-height: 1;
}

input[type="checkbox"]:hover {
	border-color: rgba(170, 170, 170, 0.5);
}

input[type="checkbox"]:checked {
	background-color: #43bc9c;
	border-color: rgba(255, 255, 255, 0.3);
	color: white;
}

input[type="checkbox"]:checked::before {
	border-radius: 2px;
	transform: scale(1) translate(-50%, -50%)
}
</style>


<!-- Custom styles for this template -->
<link href="../resources/assets/dist/css/signin.css" rel="stylesheet">
</head>
<body class="text-center" style="align-content: center">

	<main class="form-signin" style="width: 430px; align-content: center;">
		<form name="form1" method="post" style="width: 400px">
			<!-- 여기 이부분에 이미지 넣으면 될것같아염 -->
			<a href="${path}/member/home.do"> <img alt="상단배너"
				src="../resources/assets/brand/haja-logo.jpg" width="72px"
				height="72">
			</a>
			<h1 class="h3 mb-3 fw-normal">로그인</h1>


			<div style="width: 400px;" align="center">
				<div class="form-floating" align="center">
					<input class="form-control" id="userid" name="userid"
						placeholder="아이디를 입력하세요" style="align-content: center"> <label
						for="floatingInput">아이디를 입력하세요</label>
				</div>
				<div class="form-floating" align="center">
					<input type="password" class="form-control" id="passwd"
						name="passwd" placeholder="비밀번호를 입력하세요"
						style="align-content: center"> <label
						for="floatingPassword">비밀번호를 입력하세요</label>
				</div>
			</div>
			<div class="checkbox mb-3" style="text-align: left;">
				<span class="input-wrap"
					style="margin-top: 5px; background-color: #f5f5f5; color: #99a19f; border-color: #f5f5f5;">
					<input type="checkbox" id="idSaveCheck" name="checkId"> <label
					for="checkId"><span style="font-size: 15px;">아이디 저장</span></label>

				</span>
			</div>

			<button class="w-100 btn btn-lg btn-primary" type="button"
				id="btnLogin"
				style="background-color: #43bc9c; border-color: #43bc9c;">로그인</button>

			<c:if test="${param.message == 'nologin' }">
				<div style="color: red; font-size: 14px; margin-top: 6px;">
					로그인 하신 후 사용하세요.</div>
			</c:if>
			<c:if test="${message == 'error' }">
				<div style="color: red; font-size: 14px; margin-top: 6px;">
					아이디 또는 비밀번호가 일치하지 않습니다.</div>
			</c:if>
			<c:if test="${message == 'logout' }">
				<div style="color: blue; font-size: 14px; margin-top: 6px;">
					로그아웃 처리되었습니다.</div>
			</c:if>

			<input type="button" class="w-49 btn btn-success" id="btnJoin"
				value="회원가입"
				style="display: inline; margin-top: 5px; background-color: #f5f5f5; color: #99a19f; border-color: #f5f5f5;">
			<span style="color: #99a19f;"> | </span> <input type="button"
				class="w-49 btn btn-warning" id="btnIdFind" value="ID찾기"
				style="margin-top: 5px; background-color: #f5f5f5; color: #99a19f; border-color: #f5f5f5;">
			<span style="color: #99a19f;"> | </span> <input type="button"
				class="w-49 btn btn-warning" id="btnPwFind" value="PW찾기"
				style="margin-top: 5px; background-color: #f5f5f5; color: #99a19f; border-color: #f5f5f5;">

			<p class="mt-5 mb-3 text-muted">
				<span><img src="../resources/assets/brand/haja-banner.jpg"
					width="50px"></span> <span style="color: gray;">Copyright</span>
				&copy; HAJA
			</p>
		</form>
	</main>



</body>
</html>
