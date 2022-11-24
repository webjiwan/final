<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.slim.js"></script>
<%@ include file="include/header.jsp" %>
<script type="text/javascript">
$(function() {
	$("#btnLogin").click(function(){
		document.form1.action="${path}/member/login_check.do";
		document.form1.submit();
	});
});
</script>
</head>
<body>
<form name="form1" method="post">
<table border="1" style="width: 100%;">
   <tr>
      <td>아이디</td>
      <td><input name="userid" id="userid"></td>
   </tr>
   <tr>
      <td>비밀번호</td>
      <td><input type="password" name="passwd" id="passwd"></td>
   </tr>
    <tr>
      <td colspan="2" align="center">
         <input type="button" id="btnLogin" value="로그인">
         <c:if test="${param.message == 'nologin' }">
            <div style="color:red;">
               로그인 하신 후 사용하세요.
            </div>            
         </c:if>
         <c:if test="${message == 'error' }">
            <div style="color:red;">
               아이디 또는 비밀번호가 일치하지 않습니다.
            </div>
         </c:if>
         <c:if test="${message == 'logout' }">
            <div style="color:blue;">
               로그아웃 처리되었습니다.
            </div>
         </c:if>
         
      </td>
   </tr>
   <tr>
      <td colspan="2" align="center">
         <input type="button" id="btnJoin" value="회원가입">
         <input type="button" id="btnFind" value="ID/PW찾기">
      </td>
   </tr>
   
</table>
</form>
<%@ include file="include/body_js.jsp" %>
</body>
</html>