<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../include/header.jsp"%>
<script type="text/javascript">
$(function() {
	$(".au-btn--submit").click(function(){
		document.searchForm.action="${path}/board/list.do?category=${map.category}";
		document.searchForm.submit();
	});
	
	$("#board-write").click(function() {
		location.href = "${path}/board/write.do";
	})
});

function list(page) {
	location.href = "${path}/board/list.do?category=${map.category}&curPage="+page;
}

function deleteEvent(bno) {
	var path = '${path}/board/delete.do?bno='+bno;
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
				url: path,
				success : function() {
					successMessage('글을 삭제하셨습니다');
				},
				error : function() {
					errorMessage('이미 글을 삭제하였거나 본인 글이 아닙니다');
				}
			});
		}
	})
}

function updateEvent(bno) {
	location.href = "${path}/board/update.do?bno="+bno;
}
</script>

<c:if test="${param.message != null}">
	<script type="text/javascript">
		$(function() {
			errorMessage("${param.message}");
		});
	</script>
</c:if>
</head>
<body>
	<div class="page-wrapper">
		<%@ include file="../include/body_search_header.jsp"%>
		
		<div class="main-content">
			<div class="section__content section__content--p30">
				<div class="container-fluid">
					<div class="col-md-12">
						<div class="table-data__tool">
							<div class="table-data__tool-left"></div>
							<div class="table-data__tool-right" style="text-align: right;">
								<button id="board-write" class="au-btn au-btn-icon au-btn--green au-btn--small" 
								style="background-color: #43bc9c; font-size: 18px; font-weight: bold;">
									<i class="zmdi zmdi-plus"></i>글쓰기
								</button>
							</div>
						</div>
						<div class="table-responsive table-responsive-data2">
							<table class="table table-data2">
								<thead style="text-align: center; align-content: center;">
									<tr style="align-content: center;">
										<th style="font-size: 18px; font-weight: bold;  padding: 15px 10px 15px 10px; width: 100px;">글번호</th>
										<th style="font-size: 18px; font-weight: bold;  padding: 15px 10px 15px 10px; width: 100px;">카테고리</th>
										<th style="font-size: 18px; font-weight: bold;  padding: 15px 10px 15px 10px; width: 400px;">장소</th>
										<th colspan="2" style="font-size: 18px; font-weight: bold;  padding: 15px 10px 15px 10px; min-width: 200px;">제목</th>
										<th style="font-size: 18px; font-weight: bold;  padding: 15px 10px 15px 10px; width: 100px;">팀이름</th>
										<th style="font-size: 18px; font-weight: bold;  padding: 15px 10px 15px 10px; min-width: 100px; max-width: 170px;">일정</th>
										<th style="font-size: 18px; font-weight: bold;  padding: 15px 10px 15px 10px; width: 100px;">모집여부</th>
										<th style="padding: 15px 10px 15px 10px; width: 141px;"></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="row" items="${map.list}">
										<tr class="tr-shadow">
											<td style="padding: 15px 10px 15px 10px; text-align: center; vertical-align: middle;">${row.bno}</td>
											<td style="padding: 15px 10px 15px 10px; text-align: center;">
												<c:if test="${row.category == 'soccer'}"><img src="../resources/assets/brand/football.png" width="50" height="50"></c:if> 
												<c:if test="${row.category == 'basketball'}"><img src="../resources/assets/brand/basket.png" width="50" height="50"></c:if> 
												<c:if test="${row.category == 'baseball'}"><img src="../resources/assets/brand/baseball.png" width="50" height="50"></c:if> 
												<c:if test="${row.category == 'etc'}"><img src="../resources/assets/brand/etc.png" width="50" height="50"></c:if>
											</td>
											<td class="desc" style="padding: 15px 10px 15px 10px; text-align: center; color: black; font-size: 16px;">${row.place}</td>
											
											<td style="text-align: center; padding: 15px 10px 15px 70px; font-size: 18px; font-weight: bold;">
												<a href="${path}/board/view.do?bno=${row.bno}" style="color: #38997f;">
													${row.title}
												</a>
											</td>
											<td style="width: 60px; padding: 15px 20px 15px 0px; text-align: center;">
												<a href="${path}/board/view.do?bno=${row.bno}">
													<img src="../resources/assets/brand/enter_icon.png" width="50" height="50">
												</a>
											</td>
												
											<td style="font-size: 16px; color: #43bc9c; text-align: center; align-content: center; padding: 15px 10px 15px 10px;"><c:if test="${row.writer != sessionScope.userid}">
													<span class="has-sub user-sub"> 
														<a class="js-arrow" href="#" style="color: #43bc9c;">
															${row.teamid}
														</a>
														<ul class="list-unstyled navbar__sub-list js-sub-list user-nav ml80" style="display: none; background-color: transparent;">
															<li>
																<button type="button" class="btn btn-secondary mb-1"
																	data-toggle="modal" data-target="#largeModal"
																	onclick="messageEventBtn('${row.writer}')">
																	<i class="fa fa-envelope" style="padding-right: 5px;"></i>메세지 보내기
																</button>
															</li>
															<li>
																<button type="button" class="btn btn-secondary mb-1"
																	data-toggle="modal" data-target="#scrollmodal"
																	onclick="reportEventBtn('${row.writer}')">
																	<i class="fa fa-thumbs-down" style="padding-right: 5px;"></i>
																	신고하기
																</button>
															</li>
														</ul>
													</span>
												</c:if> <c:if test="${row.writer == sessionScope.userid}">
													<span class="text-danger">${row.teamid}</span>
												</c:if>
											</td>
											<td class="desc" style="padding: 15px 10px 15px 10px; text-align: center; color: black; font-size: 16px;">
												<fmt:formatDate value="${row.calendar}" pattern="yyyy-MM-dd HH:mm" />
											</td>
											<td style="padding: 15px 10px 15px 10px; align-content: center; text-align: center;"><c:if test="${row.isrec == 'y'}">
													<div class="badge badge-danger text-wrap"
														style="width: 4rem; font-size: 14px;">모집중</div>
												</c:if> <c:if test="${row.isrec == 'n'}">
													<div class="badge badge-success text-wrap"
														style="width: 4rem; font-size: 14px;">모집완료</div>
												</c:if>
											</td>
											<td>
												<div class="table-data-feature">
													<button class="item" data-toggle="tooltip"
														data-placement="top" title="" data-original-title="Edit"
														onClick="updateEvent('${row.bno}')">
														<i class="zmdi zmdi-edit"></i>
													</button>
													<button class="item" data-toggle="tooltip"
														data-placement="top" title="" data-original-title="Delete"
														onClick="deleteEvent('${row.bno}')">
														<i class="zmdi zmdi-delete"></i>
													</button>
												</div>
											</td>
										</tr>
										<tr class="spacer"></tr>
									</c:forEach>
								</tbody>
							</table>
							<br>
							<nav aria-label="Page navigation">
								<ul
									class="pagination pagination-circle pg-blue justify-content-center">
									<c:if test="${map.pager.curBlock > 1}">
										<li class="page-item"><a class="page-link"
											onclick="list('1')">First</a></li>
									</c:if>
									<c:if test="${map.pager.curBlock > 1}">
										<li class="page-item"><a class="page-link"
											onclick="list('${map.pager.prevPage}')" aria-label="Previous">
												<span aria-hidden="true">&laquo;</span> <span
												class="sr-only">Previous</span>
										</a></li>
									</c:if>
									<c:forEach var="num" begin="${map.pager.blockBegin}"
										end="${map.pager.blockEnd}">
										<c:choose>
											<c:when test="${num == map.pager.curPage}">
												<li class="page-item active"><a class="page-link">${num}</a></li>
											</c:when>
											<c:otherwise>
												<li class="page-item"><a class="page-link"
													onclick="list('${num}')">${num}</a></li>
											</c:otherwise>
										</c:choose>
									</c:forEach>
									<c:if test="${map.pager.curBlock < map.pager.totBlock}">
										<li class="page-item"><a class="page-link"
											onclick="list('${map.pager.nextPage}')" aria-label="Next">
												<span aria-hidden="true">&raquo;</span> <span
												class="sr-only">Next</span>
										</a></li>
									</c:if>
									<c:if test="${map.pager.curPage < map.pager.totPage}">
										<li class="page-item"><a class="page-link"
											onclick="list('${map.pager.totPage}')">Last</a></li>
									</c:if>
								</ul>
							</nav>
						</div>
					</div>
					<div class="copyright">
						<p class="mt-5 mb-3 text-muted">
							<span><img src="../resources/assets/brand/haja-banner.jpg" width="50px"></span> 
							<span style="color: gray;">Copyright</span>&copy; HAJA
						</p>
					</div>
				</div>
				<!-- container-fluid -->
			</div>
			<!-- section__content section__content--p30 -->
		</div>
		<!-- main-content -->

		<!-- modal -->
		<%@ include file="../include/message_modal.jsp"%>
		<%@ include file="../include/report_modal.jsp" %>

	</div>

	<%@ include file="../include/body_js.jsp"%>
</body>
</html>