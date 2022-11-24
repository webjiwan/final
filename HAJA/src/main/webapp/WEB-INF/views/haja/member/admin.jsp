<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>title</title>
<script src="https://code.jquery.com/jquery-3.6.0.slim.js"></script>
<script>
$(function() {
	$(".au-btn--submit").click(function(){
		document.searchForm.action="${path}/member/admin.do";
		document.searchForm.submit();
	});
});
function list(page) {
	location.href = "${path}/member/admin.do?curPage="+page;
}
</script>
<style type="text/css">
.tb_th {
	background-color: #43bc9c;
	color: white;
}

</style>
<%@ include file = "../include/header.jsp" %>
</head>
<body class="animsition" style="animation-duration: 900ms; opacity: 1;">
	<%@ include file="../include/body_search_header.jsp"%>
	<div class="main-content" style="background-color: #f5f5f5; align-content: center;">
		<div align="center">
			<div>
				<a href="${path}/member/home.do"> 
					<img alt="상단배너" src="../resources/assets/brand/haja-logo.jpg" width="72px" height="72">
				</a><br>
				<span style="font-weight: bold; font-size: 15px;">관리자 모드</span>
			</div><div style="height: 50px;"></div>
			
			<a href="${path}/member/admin.do">
				<span style="font-size: 30px; font-weight: bold; color: #43bc9c;">[ 회원정보 리스트 ]</span>
			</a>
			<table border="1" style="width: 80%; text-align: center;">
				<tr>
					<th class="tb_th">ID</th>
					<th class="tb_th">NAME</th>
					<th class="tb_th">TEAM</th>
					<th class="tb_th">E-mail</th>
					<th class="tb_th">HP</th>
					<th class="tb_th">가입일</th>
					<th class="tb_th">신고현황</th>
					<th class="tb_th">회원삭제</th>
				</tr>
				<c:forEach var="row" items="${map.list}">
					<tr>
						<td>${row.userid}</td>
						<td>${row.name}</td>
						<td>${row.teamid}</td>
						<td>${row.email}</td>
						<td>${row.tel}</td>
						<td><fmt:formatDate value="${row.join_date}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
						<td><a href="${path}/report/list.do?receive=${row.userid}" style="color: #43bc9c;">[조회]</a></td>
						<td>
							<a href="${path}/member/admin_delete.do?userid=${row.userid}" onclick="return confirm('삭제하시겠습니까?');" style="color: red">
								[삭제]
							</a>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<br>
		<nav aria-label="Page navigation">
			<ul class="pagination pagination-circle pg-blue justify-content-center">
				<c:if test="${map.pager.curBlock > 1}">
					<li class="page-item"><a class="page-link" onclick="list('1')">First</a></li>
				</c:if>
				<c:if test="${map.pager.curBlock > 1}">
					<li class="page-item">
						<a class="page-link" onclick="list('${map.pager.prevPage}')" aria-label="Previous">
							<span aria-hidden="true">&laquo;</span> <span class="sr-only">Previous</span>
						</a>
					</li>
				</c:if>
				<c:forEach var="num" begin="${map.pager.blockBegin}" end="${map.pager.blockEnd}">
					<c:choose>
						<c:when test="${num == map.pager.curPage}">
							<li class="page-item active"><a class="page-link">${num}</a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a class="page-link" onclick="list('${num}')">${num}</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${map.pager.curBlock < map.pager.totBlock}">
					<li class="page-item">
						<a class="page-link" onclick="list('${map.pager.nextPage}')" aria-label="Next"> 
							<span aria-hidden="true">&raquo;</span> <span class="sr-only">Next</span>
						</a>
					</li>
				</c:if>
				<c:if test="${map.pager.curPage < map.pager.totPage}">
					<li class="page-item"><a class="page-link" onclick="list('${map.pager.totPage}')">Last</a></li>
				</c:if>
			</ul>
		</nav>
		<div style="height: 100px;"></div>
		<div  style="background-color: #f5f5f5;" align="center">
			<span><img src="../resources/assets/brand/haja-banner.jpg" width="50px"></span>
			<span style="color: gray;">Copyright</span> &copy; HAJA <br><br>
		</div>
	</div>
<%@ include file="../include/body_js.jsp"%>
</body>
</html>