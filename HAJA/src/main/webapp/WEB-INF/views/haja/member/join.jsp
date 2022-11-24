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
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script type="text/javascript">
	//아이디 정규식
	function isAlphaNumeric(str) {
	  var code, i, len;

	  for (i = 0, len = str.length; i < len; i++) {
	    code = str.charCodeAt(i);
	    if (!(code > 47 && code < 58) && // numeric (0-9)
	        !(code > 64 && code < 91) && // upper alpha (A-Z)
	        !(code > 96 && code < 123)) { // lower alpha (a-z)
	      return false;
	    }
	  }
	  return true;
	};
	//이메일 정규식
	function fn_emailChk(email){
		  var regExp = /\w+([-+.]\w+)*@\w+([-.]\w+)*\.[a-zA-Z]{2,4}$/;
		  if(!regExp.test(email)){
		    return false;
		  }
		  return true;
		}
	
function fn_emailCheck() {
	$.ajax({
		url:"/member/emailCheck",
		type:"POST",
		dataType:"JSON",
		data:{"email" : $("#email").val()},
		success: function(data){
			//이메일 체크
			var email = $("#email").val();
			if (email==""){
				alert("이메일을 입력하세요.");
				$("#email").focus();
				return;
			}
			if (fn_emailChk(form1.email.value) == false ) {
				alert("이메일 형식을 맞춰주세요.");
				$("#email").focus();
				return false;
			} 
			if(data == 1){
				alert("중복된 이메일입니다.");
				$("#emailCheckBtn").attr("src", "../resources/assets/brand/check_n.png");
			}else if(data == 0){
				$("#emailCheck").attr("value","Y");
				alert("사용 가능한 이메일입니다.");
				$("#emailCheckBtn").attr("src", "../resources/assets/brand/check_y.png");
			}
		}
	})
}

function fn_idCheck() {
	$.ajax({
		url:"/member/idCheck",
		type:"POST",
		dataType:"JSON",
		data:{"userid" : $("#userid").val()},
		success: function(data){
			//아이디 체크
	         var userid = $("#userid").val();
	         if (userid==""){
	            alert("아이디는 필수 입력입니다.");
	            $("#userid").focus();
	            return;
	         }
	         //아이디가 짧아요
	         if (form1.userid.value.length < 4) {
	            alert("아이디가 너무 짧습니다.");
	            $("#userid").focus();
	            return false;
	         }
	         //아이디 형식을 맞춰줘요
	         if (isAlphaNumeric(form1.userid.value) == false ) {
	            alert("아이디 형식을 맞춰주세요.");
	            $("#userid").focus();
	            return false;
	         } 
	         //아이디가 대문자이면 소문자로 바꿔요
	         form1.userid.value = form1.userid.value.toLowerCase();

			if(data ==1){
				alert("중복된 아이디입니다.");
				$("#idCheckBtn").attr("src", "../resources/assets/brand/check_n.png");
			}else if(data == 0){
				$("#idCheck").attr("value","Y");
				alert("사용 가능한 아이디입니다.");
				$("#idCheckBtn").attr("src", "../resources/assets/brand/check_y.png");
			}
		}
	})
}


$(function(){
	$("#btnJoin").click(function(){
		//아이디 체크
		var userid = $("#userid").val();
		if (userid==""){
			alert("아이디는 필수 입력입니다.");
			$("#userid").focus();
			return;
		}
		//아이디가 짧아요
		if (form1.userid.value.length < 4) {
			alert("아이디가 너무 짧습니다.");
			$("#userid").focus();
			return false;
		}
		//아이디 형식을 맞춰줘요
		if (isAlphaNumeric(form1.userid.value) == false ) {
			alert("아이디 형식을 맞춰주세요.");
			$("#userid").focus();
			return false;
		} 
		
		//아이디가 대문자이면 소문자로 바꿔요
		form1.userid.value = form1.userid.value.toLowerCase();
		
		//비밀번호 체크
		var passwd=$("#passwd").val();
		if (passwd==""){
			alert("비밀번호는 필수 입력입니다.");
			$("#passwd").focus();
			return;
		}
		//이름 체크
		var name = $("#name").val();
		if (name==""){
			alert("이름을 입력하세요.");
			$("#name").focus();
			return;
		}
		
		//이름이 너무 짧아요
		if (form1.name.value.length < 2) {
			alert("이름을 2자 이상 입력해주세요.");
			$("#name").focus();
			return false;
		}
		
		//주민번호 앞자리가 짧아요 || 길어요
		var ssn1 = $("#ssn1").val();
		if(form1.ssn1.value.length < 6 || form1.ssn1.value.length > 6) {
			alert("주민등록번호 앞자리 6자리 형식으로 작성하세요 ex)970131");
			$("#ssn1").focus();
			return false;
		}
		
	
		//뒷자리가 짧아요 || 길어요
		var ssn2 = $("#ssn2").val();
		if(form1.ssn2.value.length < 7 || form1.ssn2.value.length > 7) {
			alert("주민등록번호 뒷자리 7자리 형식으로 작성하세요 ex)1234567");
			$("#ssn2").focus();
			return false;
		}
		
		var teamid = $("#teamid").val();
		if (teamid==""){
			alert("팀이름을 입력하세요.");
			$("#teamid").focus();
			return;
		}
		//이메일 체크
		var email = $("#email").val();
		if (email==""){
			alert("이메일을 입력하세요.");
			$("#email").focus();
			return;
		}
		if (fn_emailChk(form1.email.value) == false ) {
			alert("이메일 형식을 맞춰주세요.");
			$("#email").focus();
			return false;
		} 
		document.form1.submit();
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
</style>


<!-- Custom styles for this template -->
<link href="../resources/assets/dist/css/signin.css" rel="stylesheet">
</head>

<body>
	<main class="form-signin" style="align-content: center;">
		<form name="form1" method="post" action="${path}/member/insert.do"
			style="align-content: center; text-align: center;">
			<a href="${path}/member/home.do"> <img alt="상단배너"
				src="../resources/assets/brand/haja-logo.jpg" width="72px"
				height="72">
			</a>
			<h1 class="h3 mb-3 fw-normal" style="font-weight: bold;">회원 가입</h1>
			<br>

			<div class="form-floating">
				<input type="text" class="form-control" id="userid" name="userid" style="display: inline-block; width: 83%"> 
				<img id="idCheckBtn" alt="중복체크" src="../resources/assets/brand/check_n.png" width="15%" height="58px" onclick="fn_idCheck();" style="vertical-align: top;" id="btnid"> 
				<span id="idChk"></span>
				</p>
				<label for="userid">아이디</label>

			</div>
			<div class="form-floating">
				<input type="password" class="form-control" id="passwd"
					name="passwd"> <label for="passwd">비밀번호</label>
			</div>
			<div class="form-floating">
				<input type="text" class="form-control" id="name" name="name">
				<label for="name">이름</label>
			</div>
			<div class="form-floating" style="display: inline-block;">
				<input type="text" class="form-control" id="ssn1" name="ssn1"
					style="display: inline-block; width: 43.5%"> <span
					style="font-size: 2rem; vertical-align: top;">&nbsp;-&nbsp;</span>
				<input type="password" class="form-control" id="ssn2" name="ssn2"
					style="display: inline-block; width: 43.5%"> <label
					for="ssn1">주민번호</label>
			</div>
			<div class="form-floating">
				<input type="text" class="form-control" id="tel" name="tel">
				<label for="tel">전화번호</label>
			</div>
			<div class="form-floating">
				<input type="email" class="form-control" id="email" name="email"
					style="display: inline-block; width: 83%">
				<sapn class="mail_input_box_warn"></sapn>
				<img id="emailCheckBtn" alt="중복체크" src="../resources/assets/brand/check_n.png" width="15%" height="58px" onclick="fn_emailCheck();" style="vertical-align: top;"> 
				<label for="email">이메일</label>
			</div>
			<div class="form-floating">
				<input type="text" class="form-control" id="teamid" name="teamid">
				<label for="teamid">팀이름</label>
			</div>

			<div class="checkbox mb-3"></div>

			<button class="w-100 btn btn-lg btn-primary" type="button"
				style="background-color: #43bc9c; border-color: #43bc9c;"
				id="btnJoin">가입하기</button>
			<p class="mt-5 mb-3 text-muted">
				<span><img src="../resources/assets/brand/haja-banner.jpg"
					width="50px"></span> <span style="color: gray;">Copyright</span>
				&copy; HAJA
			</p>
		</form>
	</main>

</body>
</html>