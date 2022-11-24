<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../include/header.jsp"%>
<style type="text/css">
.tac {
	text-align: center;
}

.tac th {
	padding: 20px 20px !important;
	padding-right: 20px !important;
}
</style>
</head>
<body>
	<div class="page-wrapper">

		<%@ include file="../include/body_header.jsp"%>

		<div class="main-content">
			<div class="section__content section__content--p30">
				<div class="container-fluid">
					<div class="col-md-12">
						<div id="alarm-table"
							class="table-responsive table-responsive-data2">
							<table class="table table-data2">
								<thead>
									<tr>
										<th style="width: 10%;">신고한 사람</th>
										<th style="width: 20%; text-align: center;">신고 유형</th>
										<th style="width: 60%; text-align: center;">상세 내용</th>
										<th style="width: 10%;">신고 날짜</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="row" items="${list}">
										<tr class="tr-shadow">
											<td>${row.send}</td>
											<td>${row.category}</td>
											<td>${row.text}</td>
											<td><fmt:formatDate value="${row.regdate}"
													pattern="yyyy-MM-dd HH:mm" /></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<nav aria-label="Page navigation">
								<ul
									class="pagination pagination-circle pg-blue justify-content-center">
									<c:if test="${pager.curBlock > 1}">
										<li class="page-item"><a class="page-link"
											onclick="list('1')">First</a></li>
									</c:if>
									<c:if test="${pager.curBlock > 1}">
										<li class="page-item"><a class="page-link"
											onclick="list('${pager.prevPage}')" aria-label="Previous">
												<span aria-hidden="true">&laquo;</span> <span
												class="sr-only">Previous</span>
										</a></li>
									</c:if>
									<c:forEach var="num" begin="${pager.blockBegin}"
										end="${pager.blockEnd}">
										<c:choose>
											<c:when test="${num == pager.curPage}">
												<li class="page-item active"><a class="page-link">${num}</a></li>
											</c:when>
											<c:otherwise>
												<li class="page-item"><a class="page-link"
													onclick="list('${num}')">${num}</a></li>
											</c:otherwise>
										</c:choose>
									</c:forEach>
									<c:if test="${pager.curBlock < pager.totBlock}">
										<li class="page-item"><a class="page-link"
											onclick="list('${pager.nextPage}')" aria-label="Next">
												<span aria-hidden="true">&raquo;</span> <span
												class="sr-only">Next</span>
										</a></li>
									</c:if>
									<c:if test="${pager.curPage < pager.totPage}">
										<li class="page-item"><a class="page-link"
											onclick="list('${pager.totPage}')">Last</a></li>
									</c:if>
								</ul>
							</nav>
						</div>
						<div id="alarm-table"
							class="table-responsive table-responsive-data2">
							<table class="table table-data2">
								<thead>
									<tr class="tac">
										<th>욕설</th>
										<th>비매너 행위</th>
										<th>무단지각</th>
										<th>무단불참, 무단탈주</th>
										<th>총 신고수</th>
									</tr>
								</thead>
								<tbody>
									<tr class="tr-shadow tac">
										<th>${map.c1}</th>
										<th>${map.c2}</th>
										<th>${map.c3}</th>
										<th>${map.c4}</th>
										<th>${count}</th>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>

			</div>
			<%@ include file="../include/body_js.jsp"%>
</body>
</html>