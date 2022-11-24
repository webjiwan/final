<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../include/header.jsp"%>
<script type="text/javascript">
function list(page) {
	location.href = "${path}/message/messageList.do?curPage="+page;
}

function deleteEvent(mno) {
	Swal.fire({
		title: '삭제하시겠습니까?',
		icon: 'warning',
		showCancelButton: true,
		confirmButtonColor: '#3085d6',
		cancelButtonColor: '#d33',
		confirmButtonText: '삭제',
		cancelButtonText: '아니오'
	}).then( (result) => {
		if (result.isConfirmed) {
			$.ajax({
				type: 'get',
				url: "${path}/message/delete.do?mno="+mno,
				success : function() {
					successMessage('메세지을 삭제하셨습니다');
				},
				error : function() {
					errorMessage('이미 메세지을 삭제하였거나 본인이 받은 메세지가 아닙니다');
				}
			});
		}
	})
}
</script>
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
										<th style="width: 10%;">보낸아이디</th>
										<th style="width: 70%; text-align: center;">내용</th>
										<th style="width: 15%;">날짜</th>
										<th style="width: 5%"></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="row" items="${list}">
										<tr class="tr-shadow">
											<td><c:if test="${row.send != sessionScope.userid}">
													<span class="has-sub user-sub"> <a
														class="js-arrow text-danger" href="#">${row.send}</a>
														<ul
															class="list-unstyled navbar__sub-list js-sub-list user-nav"
															style="display: none;">
															<li>
																<button type="button" class="btn btn-secondary mb-1"
																	data-toggle="modal" data-target="#scrollmodal"
																	onclick="messageEventBtn('${row.send}')">
																	<i class="fa fa-envelope" style="padding-right: 5px;"></i>메세지
																	보내기
																</button>
															</li>
															<li>
																<button type="button" class="btn btn-secondary mb-1"
																	data-toggle="modal" data-target="#scrollmodal">
																	<i class="fa fa-thumbs-down" style="padding-right: 5px;"></i>
																	신고하기
																</button>
															</li>
														</ul>
													</span>
												</c:if> <c:if test="${row.send == sessionScope.userid}">
													<span class="text-danger">${row.send}</span>
												</c:if></td>
											<td>${row.text}</td>
											<td><fmt:formatDate value="${row.regdate}"
													pattern="yyyy-MM-dd HH:mm" /></td>
											<td><div class="table-data-feature">
													<button class="item" data-toggle="tooltip"
														data-placement="top" title="" data-original-title="Delete"
														onClick="deleteEvent('${row.mno}')">
														<i class="zmdi zmdi-delete"></i>
													</button>
											</div></td>
										</tr>
										<tr class="spacer"></tr>
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
					</div>
				</div>
			</div>
			
		</div>

		<!-- modal -->
		<%@ include file="../include/message_modal.jsp" %>
		<%@ include file="../include/report_modal.jsp" %>

	</div>
	<%@ include file="../include/body_js.jsp"%>
</body>
</html>