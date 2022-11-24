<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<%@ include file="../include/header.jsp"%>
<style type="text/css">
.admin1 {
	margin-left: 20px;
	border: 1px solid black;
}

.admin2 {
	margin-top: 30px;
	margin-left: 20px;
	border: 1px solid black;
}

#join-table {
	margin: 30px 0px;
	width: 100%;
	height: 300px;
	overflow-y: auto;
	box-shadow: 2px 4px 10px 2px rgb(0 0 0/ 10%);
	border: 1px solid rgba(0, 0, 0, .150);
}

.warn {
	margin-top: 30px;
	width: 100%;
	height: 800px;
	overflow-y: auto;
}

@media all and (max-width: 1500px) {
	.admin1 {
		width: 150px;
	}
	.admin2 {
		width: 150px;
	}
}

@media all and (max-height: 1050px) {
	.admin1 {
		height: 300px;
	}
	.admin2 {
		height: 200px;
	}
}

@media all and (min-width: 1500px) {
	.admin1 {
		width: 250px;
	}
	.admin2 {
		width: 250px;
	}
}

@media all and (min-height: 1050px) {
	.admin1 {
		height: 700px;
	}
	.admin2 {
		height: 350px;
	}
}
</style>
<script>
	$(function() {
		listJoin(1);
		listReply(1);
		
		$("#reply-btn").click(function() {
			var replytext = $("#reply-text").val();
			var bno = "${map.dto.bno}";
			var param = {
					"replytext" : replytext,
					"bno" : bno
			};
			$.ajax({
				type : "post",
				url : "${path}/reply/insert.do",
				data : param,
				success : function() {
					successMessage('댓글이 등록되었습니다');
				},
				error : function() {
					errorMessage('로그인하지 않았습니다');
				}
			});
		});
		
		$("#join-create").click(function() {
			var bno = "${map.dto.bno}";
			var writer = "${map.dto.writer}";
			var param = {
					"bno" : bno,
					"writer" : writer
			};
			$.ajax({
				type : "post",
				url : "${path}/join/create.do",
				data : param,
				success : function() {
					successMessage('참여하였습니다');
				},
				error : function() {
					errorMessage('이미 참여하였거나 로그인하지 않았습니다');
				}
			});
		});
		
		$("#join-delete").click(function() {
			var bno = "${map.dto.bno}";
			var param = {
					"bno" : bno
			};
			$.ajax({
				type : "post",
				url : "${path}/join/delete.do",
				data : param,
				success : function() {
					successMessage('참여를 취소하셨습니다');
				},
				error : function() {
					errorMessage('이미 참여를 취소하였거나 로그인하지 않았습니다');
				}
			});
		});
	});
	
	function listJoin(page) {
		$.ajax({
			type : "get",
			url : "${path}/join/list.do?bno=${map.dto.bno}&curPage="+page,
			success : function(result) {
				var writer = "${map.dto.writer}";
				var userid = "${sessionScope.userid}";
				var output = "<div class='table-responsive table-responsive-data2'>";
				output += "<table class='table table-data2'>";
				output += "<thead><tr>";
				
				if (writer == userid) {
					output += "<th style='width: 20%;'>아이디</th><th style='width: 20%;'>팀이름</th><th style='width: 20%;'>전화번호</th><th style='width: 30%;'>이메일</th><th style='width: 10%;'></th>";
				} else {
					output += "<th style='width: 20%;'>아이디</th><th style='width: 20%;'>팀이름</th><th style='width: 25%;'>전화번호</th><th style='width: 35%;'>이메일</th>";
				}
				
				output += "</tr></thead><tbody>";
				
				for (var i in result.list) {
					output += "<tr class='tr-shadow'>";
					if (result.list[i].userid == "${sessionScope.userid}") {
						output += "<td><span class='text-danger'>"+result.list[i].userid+"</span></td>";
					} else {
						output += "<td><span class='has-sub user-sub'>"
						+"<a class='js-arrow text-danger' onclick='joinMenu("+result.list[i].jno+")'>"+result.list[i].userid+"</a>"
						+"<ul id='joinMenu"+result.list[i].jno+"' class='list-unstyled navbar__sub-list js-sub-list user-nav ml40 tal' style='display: none;'>"
						+"<li><button type='button' class='btn btn-secondary mb-1' data-toggle='modal' data-target='#largeModal' onclick='messageEventBtn(\""+result.list[i].userid+"\")'>"
						+"<i class='fa fa-envelope' style='padding-right: 5px;'></i>메세지 보내기</button></li>"
						+"<li><button type='button' class='btn btn-secondary mb-1' data-toggle='modal' data-target='#scrollmodal' onclick='reportEventBtn(\""+result.list[i].userid+"\")'>"
						+"<i class='fa fa-thumbs-down' style='padding-right: 5px;''></i>신고하기</button></li>"
						+"</ul></span></td>"
					}
					output += "<td>"+result.list[i].teamid+"</td>";
					output += "<td>"+result.list[i].tel+"</td>";
					output += "<td>"+result.list[i].email+"</td>";
					
					if (writer == userid) {
						output += "<td>";
						if (result.isMatch == 1) {
							if (result.list[i].ismatch == 'y') {
								output += "<button class='btn btn-danger' onclick='nMatchBtn("+result.list[i].jno+")'>취소</button>";
							}
						}
						
						if (result.isMatch == 0) {
							if (result.list[i].ismatch == 'n') {
								output += "<button class='btn btn-primary' onclick='yMatchBtn("+result.list[i].jno+")'>매칭</button>";
							}
						}
						output += "</td>";
					}
					
					output += "</tr><tr class='spacer'></tr>";
				}
				output += "</tbody></table>";
				output += "<nav aria-label='Page navigation'>";
				output += "<ul class='pagination pagination-circle pg-blue justify-content-center'>";
				
				if (result.joinPager.curBlock > 1) {
					output += "<li class='page-item'><a class='page-link' onclick='listJoin(1)'>First</a></li>"
					output += "<li class='page-item'><a class='page-link'"+
					"onclick='listJoin("+result.joinPager.prevPage+")' aria-label='Previous'>"+
					"<span aria-hidden='true'>&laquo;</span> <span class='sr-only'>Previous</span></a></li>";
				}
				
				for (var i=result.joinPager.blockBegin; i<=result.joinPager.blockEnd; i++) {
					if (i == result.joinPager.curPage) {
						output += "<li class='page-item active'><a class='page-link'>"+i+"</a></li>";
					} else {
						output += "<li class='page-item'><a class='page-link' onclick='listJoin("+i+")'>"+i+"</a></li>";
					}
				}
				
				if (result.joinPager.curBlock < result.joinPager.totBlock) {
					output += "<li class='page-item'><a class='page-link' onclick='listJoin("+result.joinPager.nextPage+")' aria-label='Next'>"+ 
					"<span aria-hidden='true'>&raquo;</span> <span class='sr-only'>Next</span></a></li>";
				}
				
				if (result.joinPager.curPage < result.joinPager.totPage) {
					output += "<li class='page-item'><a class='page-link' onclick='listJoin("+result.joinPager.totPage+")'>Last</a></li>";
				}
				
				output += "</ul></nav></div>";
				
				$("#join-table").html(output);
			}
		});
	}
	
	function listReply(page) {
		$.ajax({
			type: "get",
			url: "${path}/reply/list.do?bno=${map.dto.bno}&curPage="+page,
			success: function(result){
				var output = "<div class='table-responsive table-responsive-data2'>";
				output += "<table class='table table-data2'>";
				
				for (var i in result.list) {
					var repl=result.list[i].replytext;
					// /정규식/(규칙) => 정규표현식
					// 규칙 g: global 전역검색, i: 대소문자 무시
					// ex) /java/gi => JAVA 또는 java를 모두 찾음
					repl = repl.replace(/  /gi,"&nbsp;&nbsp;");//공백처리
					repl = repl.replace(/</gi,"&lt;"); //태그문자 처리
					repl = repl.replace(/>/gi,"&gt;");
					repl = repl.replace(/\n/gi,"<br>"); //줄바꿈 처리
					output += "<tr class='tr-shadow'>";
					if (result.list[i].replyer == "${sessionScope.userid}") {
						output += "<td style='width: 10%;'><span class='text-danger'>"+result.list[i].replyer+"</span></td>";
					} else {
						output += "<td style='width: 10%;'><span class='has-sub user-sub'>"
						+"<a class='js-arrow text-danger' onclick='replyMenu("+result.list[i].rno+")'>"+result.list[i].replyer+"</a>"
						+"<ul id='replyMenu"+result.list[i].rno+"' class='list-unstyled navbar__sub-list js-sub-list user-nav tal' style='display: none;'>"
						+"<li><button type='button' class='btn btn-secondary mb-1' data-toggle='modal' data-target='#largeModal' onclick='messageEventBtn(\""+result.list[i].replyer+"\")'>"
						+"<i class='fa fa-envelope' style='padding-right: 5px;'></i>메세지 보내기</button></li>"
						+"<li><button type='button' class='btn btn-secondary mb-1' data-toggle='modal' data-target='#scrollmodal' onclick='reportEventBtn(\""+result.list[i].replyer+"\")'>"
						+"<i class='fa fa-thumbs-down' style='padding-right: 5px;''></i>신고하기</button></li>"
						+"</ul></span></td>";
					}
					output += "<td style='width: 60%;'>"+repl+"</td>";
					output += "<td style='width: 30%;'><div class='table-data-feature'>"+changeDate(result.list[i].regdate)+"<button class='item' style='margin-left: 5px;' data-toggle='tooltip' data-placement='top' title='' data-original-title='Edit' onclick='editReplyForm("+result.list[i].rno+")'><i class='zmdi zmdi-edit'></i></button>"
				    +"<button class='item' data-toggle='tooltip' data-placement='top' title='' data-original-title='Delete' onclick='deleteReplyBtn("+result.list[i].rno+")'><i class='zmdi zmdi-delete'></i></button></div>";
					output += "</tr><tr class='tr-shadow' id='editReplyForm"+result.list[i].rno+"' style='display: none;'><td colspan='3'><div class='table-data-feature input-group'>"
					+"<input type='text' id='reply-edit-text"+result.list[i].rno+"' name='reply-edit-text"+result.list[i].rno+"' value='"+repl+"' class='form-control'>"
					+"<button class='btn btn-primary' onclick='editReplyBtn("+result.list[i].rno+")'>수정</button></div></td></tr>"
					+"<tr class='spacer'></tr>";
				}
				
				output += "</table>";
				output += "<nav aria-label='Page navigation'>";
				output += "<ul class='pagination pagination-circle pg-blue justify-content-center'>";
				
				if (result.pager.curBlock > 1) {
					output += "<li class='page-item'><a class='page-link' onclick='listReply(1)'>First</a></li>"
					output += "<li class='page-item'><a class='page-link'"+
					"onclick='listReply("+result.pager.prevPage+")' aria-label='Previous'>"+
					"<span aria-hidden='true'>&laquo;</span> <span class='sr-only'>Previous</span></a></li>";
				}
				
				for (var i=result.pager.blockBegin; i<=result.pager.blockEnd; i++) {
					if (i == result.pager.curPage) {
						output += "<li class='page-item active'><a class='page-link'>"+i+"</a></li>";
					} else {
						output += "<li class='page-item'><a class='page-link' onclick='listReply("+i+")'>"+i+"</a></li>";
					}
				}
				
				if (result.pager.curBlock < result.pager.totBlock) {
					output += "<li class='page-item'><a class='page-link' onclick='listReply("+result.pager.nextPage+")' aria-label='Next'>"+ 
					"<span aria-hidden='true'>&raquo;</span> <span class='sr-only'>Next</span></a></li>";
				}
				
				if (result.pager.curPage < result.pager.totPage) {
					output += "<li class='page-item'><a class='page-link' onclick='listReply("+result.pager.totPage+")'>Last</a></li>";
				}
				
				output += "</ul></nav>";
				$("#reply-table").html(output);
			}
		});
	}
	function joinMenu(jno) {
		$("#joinMenu"+jno).toggle();
	}
	
	function replyMenu(rno) {
		$("#replyMenu"+rno).toggle();
	}
	
	function editReplyForm(rno) {
		$("#editReplyForm"+rno).toggle();
	}
	
	function editReplyBtn(rno) {
		var replytext = $("#reply-edit-text"+rno).val();
		var bno = "${map.dto.bno}";
		var param = {
			"replytext" : replytext,
			"bno" : bno,
			"rno" : rno
		};
		
		Swal.fire({
			title: '수정하시겠습니까?',
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			confirmButtonText: '수정',
			cancelButtonText: '아니오'
		}).then( (result) => {
			if (result.isConfirmed) {
				$.ajax({
					type : "post",
					url : "${path}/reply/edit.do",
					data : param,
					success: function() {
						successMessage('수정하였습니다');
					},
					error: function() {
						errorMessage('아이디가 다릅니다');
					}
				});
			}
		})
	}
	
	function deleteReplyBtn(rno) {
		var path = '${path}/reply/delete.do?rno='+rno;
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
					success: function() {
						successMessage('삭제하였습니다');
					},
					error: function() {
						errorMessage('아이디가 다릅니다');
					}
				});
			}
		})
	}
	
	function nMatchBtn(jno) {
		var param = {
			"jno" : jno,
			"ismatch" : "n"
		};
		
		Swal.fire({
			title: '매칭을 취소 하시겠습니까?',
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			confirmButtonText: '취소',
			cancelButtonText: '아니오'
		}).then( (result) => {
			if (result.isConfirmed) {
				$.ajax({
					type : "post",
					url : "${path}/join/changeMatch.do",
					data : param,
					success: function() {
						successMessage('취소하였습니다');
					},
					error: function() {
						errorMessage('아이디가 다릅니다');
					}
				});
			}
		})
	}
	
	function yMatchBtn(jno) {
		var param = {
				"jno" : jno,
				"ismatch" : "y"
			};
			
			Swal.fire({
				title: '매칭을 하시겠습니까?',
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: '매칭',
				cancelButtonText: '아니오'
			}).then( (result) => {
				if (result.isConfirmed) {
					$.ajax({
						type : "post",
						url : "${path}/join/changeMatch.do",
						data : param,
						success: function() {
							successMessage('매칭하였습니다');
						},
						error: function() {
							errorMessage('아이디가 다릅니다');
						}
					});
				}
			})
	}
	
	//수정 버튼
	function updateEvent(bno) {
		location.href = "${path}/board/update.do?bno="+bno;
	}

	//삭제 버튼
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
</script>
</head>
<body class="animsition" style="animation-duration: 900ms; opacity: 1;">
	<div class="page-wrapper">
		<!-- MENU SIDEBAR-->
		<aside class="menu-sidebar d-none d-lg-block"
			style="overflow-y: hidden !important; overflow-x: hidden; top: 100px; background-color: #e5e5e5; padding-left: 30px;">
			<div style="height: 40px;"></div>
			<div class="admin1" align="center" style="line-height: 1.0; height: auto; padding: 10px; background-color: white; border-radius: 10px; border: white;">
				<a href="https://www.coupang.com/vp/products/6790570817?itemId=15997175950&vendorItemId=83202422283&q=%EC%95%84%EC%9D%B4%ED%8F%B0+14&itemsCount=36&searchId=9d0301d12e514948a97b31b562f2e427&rank=0&isAddedCart=" target="_blank"><img src="../resources/assets/brand/ad1.jpg" width="80%"></a><br>
				<div align="left">
					<span style="color:#ae0000; font-size: 10px;">추가할인 쿠폰</span><br>
					<a href="https://www.coupang.com/vp/products/6790570817?itemId=15997175950&vendorItemId=83202422283&q=%EC%95%84%EC%9D%B4%ED%8F%B0+14&itemsCount=36&searchId=9d0301d12e514948a97b31b562f2e427&rank=0&isAddedCart=" target="_blank"><span style="font-size: 12px;">Apple 정품 아이폰 14 자급제, 블루, 128GB</span></a><div class="div_blank"></div>
					<span style="font-size: 9px;">9%</span><span style="color: #888888;font-size: 9px; text-decoration: line-through;">1,250,000</span><div class="div_blank"></div>
					<span style="font-size: 14px; color:#ae0000; font-weight: bold;">1,130,300</span><span style="font-size: 13px; color:#ae0000;">원</span><div class="div_blank"></div>
					<span style="font-size: 12px; color:#008c00;">2일내로 도착 보장</span><div class="div_blank"></div>
					<span style="color: #ff9600;">★★★★★</span><div class="div_blank"></div> 
				</div>
				<div align="left">
					<div style="display: inline-block; border: 1px solid #cccccc; border-radius: 8px; width: auto; height: auto;">
						<span style="font-size: 10px;">&nbsp;최대 12%카드 즉시할인&nbsp;</span>
					</div><div class="div_blank"></div>
					<div style="display: inline-block; border: 1px solid #cccccc; border-radius: 8px; width: auto; height: auto;">
						<span style="font-size: 10px;">&nbsp;최대 10,000원 적립&nbsp;</span>
					</div>
				</div>
			</div>
			<div class="admin2"  align="center" style="line-height: 1.1; height: auto; padding: 10px; background-color: white; border-radius: 10px; border: white;">
				<a href="https://www.chelseamegastore.com/en/chelsea-home-stadium-shirt-2022-23/p-3492251103801776+z-941-4247439145?_ref=p-GALP:m-GRID:i-r0c0:po-0" target="_blank"><img src="../resources/assets/brand/ad2.jpg" width="90%"></a><br>
				<div align="left">
					<span style="color:#ae0000; font-size: 11px;">친황경 소재</span><div class="div_blank"></div>
					<a href="https://www.chelseamegastore.com/en/chelsea-home-stadium-shirt-2022-23/p-3492251103801776+z-941-4247439145?_ref=p-GALP:m-GRID:i-r0c0:po-0" target="_blank"><span style="font-size: 12px;">첼시FC 22/23 스타디움 홈 킷</span></a><br>
					<span style="color: #888888;font-size: 9px;">남성 나이키 드라이 핏 축구 저지</span>
					<span style="color: #888888;font-size: 9px;">1개 색상</span><br>
					<span style="font-size: 12px; font-weight: bold;">119,000원</span>
				</div>
			</div>
		</aside>
		<!-- END MENU SIDEBAR-->

		<!-- PAGE CONTAINER-->
		<div class="page-container">
			<!-- HEADER DESKTOP-->
			<%@ include file="../include/body_header.jsp"%>

			<!-- MAIN CONTENT-->
			<div class="main-content">
				<div class="section__content section__content--p30">
					<div class="container-fluid">
						<div class="row">
							<div class="col-md-12">
								<div class="copyright">
									<div class="row">
										<div class="col-lg-9">
											<div class="card" style="background-color: #e5e5e5; border: #e5e5e5;">
												<!-- 게시글 영역 -->
												<div class="card-header" style="background-color: #43bc9c;">
													<span style="color: white; font-size: 32px; font-weight: bold;">게시글</span> <br>
													<span style="color: white; font-size: 16px;">[상세 정보]</span>
												</div>
												<div class="card-body card-block" style="background-color: white;">
													<div class="col col-md-12" style="display: flex;">
														<div class="col col-md-6">
															<div class="row form-group">
																<div class="col col-md-3" style="width: 25%;">
																	<label for="text-input" class=" form-control-label">카테고리</label>
																</div>
																<div class="col col-md-9" style="width: 75%;">
																	<p class="form-control-static">
																		<c:if test="${map.dto.category == 'soccer'}">축구</c:if>
																		<c:if test="${map.dto.category == 'basketball'}">농구</c:if>
																		<c:if test="${map.dto.category == 'baseball'}">야구</c:if>
																		<c:if test="${map.dto.category == 'etc'}">기타</c:if>
																	</p>
																</div>
															</div>
														</div>
														<div class="col col-md-6">
															<div class="row form-group">
																<div class="col col-md-3" style="width: 25%;">
																	<label for="text-input" class=" form-control-label">조회수</label>
																</div>
																<div class="col col-md-9" style="width: 75%;">
																	<p class="form-control-static">${map.dto.viewcnt}</p>
																</div>
															</div>
														</div>
													</div>
													<div class="col col-md-12" style="display: flex;">
														<div class="col col-md-6">
															<div class="row form-group">
																<div class="col col-md-3" style="width: 25%;">
																	<label for="text-input" class=" form-control-label">글제목</label>
																</div>
																<div class="col col-md-9" style="width: 75%;">
																	<p class="form-control-static">${map.dto.title}</p>
																</div>
															</div>
														</div>
														<div class="col col-md-6">
															<div class="row form-group">
																<div class="col col-md-3" style="width: 25%;">
																	<label for="text-input" class=" form-control-label">팀명</label>
																</div>
																<div class="col col-md-9" style="width: 75%;">
																	<c:if test="${map.dto.writer != sessionScope.userid}">
																		<span class="has-sub user-sub"> 
																			<a class="js-arrow" href="#" style="color: #43bc9c; font-weight: bold;">${map.dto.teamid}</a>
																			<ul class="list-unstyled navbar__sub-list js-sub-list user-nav ml180 tal" style="display: none;">
																				<li>
																					<button type="button" class="btn btn-secondary mb-1" data-toggle="modal"
																						data-target="#largeModal" onclick="messageEventBtn('${map.dto.writer}')">
																						<i class="fa fa-envelope" style="padding-right: 5px;"></i>메세지 보내기
																					</button>
																				</li>
																				<li>
																					<button type="button" class="btn btn-secondary mb-1"
																						data-toggle="modal" data-target="#scrollmodal" onclick="reportEventBtn('${map.dto.writer}')">
																						<i class="fa fa-thumbs-down" style="padding-right: 5px;"></i>신고하기
																					</button>
																				</li>
																			</ul>
																		</span>
																	</c:if>
																	<c:if test="${map.dto.writer == sessionScope.userid}">
																		<span class="text-danger">${map.dto.teamid}</span>
																	</c:if>
																</div>
															</div>
														</div>
													</div>
													<div class="col col-md-12" style="display: flex;">
														<div class="col col-md-6">
															<div class="row form-group">
																<div class="col col-md-3" style="width: 25%;">
																	<label for="text-input" class=" form-control-label">전화번호</label>
																</div>
																<div class="col col-md-9" style="width: 75%;">
																	<p class="form-control-static">${map.dto.tel}</p>
																</div>
															</div>
														</div>
														<div class="col col-md-6">
															<div class="row form-group">
																<div class="col col-md-3" style="width: 25%;">
																	<label for="text-input" class=" form-control-label">이메일</label>
																</div>
																<div class="col col-md-9" style="width: 75%;">
																	<p class="form-control-static">${map.dto.email}</p>
																</div>
															</div>
														</div>
													</div>
													<div class="col col-md-12" style="display: flex;">
														<div class="col col-md-6">
															<div class="row form-group">
																<div class="col col-md-3" style="width: 25%;">
																	<label for="text-input" class=" form-control-label">일정</label>
																</div>
																<div class="col col-md-9" style="width: 75%;">
																	<p class="form-control-static">
																		<fmt:formatDate value="${map.dto.calendar}" pattern="yyyy-MM-dd HH:mm" />
																	</p>
																</div>
															</div>
														</div>
														<div class="col col-md-6">
															<div class="row form-group">
																<div class="col col-md-3" style="width: 25%;">
																	<label for="text-input" class=" form-control-label">장소</label>
																</div>
																<div class="col col-md-9" style="width: 75%;">
																	<p class="form-control-static">${map.dto.place}</p>
																</div>
															</div>
														</div>
													</div>
													<div class="col col-md-12" style="margin-bottom: 20px; font-size: 18px; font-weight: bold;">본문</div><hr>
													<div style="text-align: left; background-color: #f0f0f0; border-radius: 10px; padding: 10px;">${map.dto.content}</div>
												</div>
												
												<!-- 게시글 수정 및 삭제 버튼 -->
												<c:if test="${sessionScope.userid == map.dto.writer}">
                                       				<div style="text-align: center;">
                                       					<br>
                                             			<button class="item" data-toggle="tooltip" data-placement="top" title="" 
                                             			data-original-title="Edit" onClick="updateEvent('${map.dto.bno}')"
                                             			style="border: 1px solid #43bc9c; width: 180px; height: 50px; background-color: #43bc9c; color: white; font-weight: bold; font-size: 20px; border-radius: 10px;">
                                             				수 정
                                            			</button>
                                            			&nbsp;&nbsp;&nbsp;
                                             			<button class="item" data-toggle="tooltip" data-placement="top" title="" 
                                             			data-original-title="Delete" onClick="deleteEvent('${map.dto.bno}')"
                                             			style="border: 1px solid #f76767; width: 180px; height: 50px; background-color: #f76767; color: white; font-weight: bold; font-size: 20px; border-radius: 10px;">
                                                			삭 제
                                             			</button>
                                       				</div>
                                   		 		</c:if>
												

												<!-- 참여팀테이블 영역 -->
												<div id="join-table" style="background-color: white;"></div>

												<!-- 댓글 영역 -->
												<div id="reply-table" style="margin-bottom: 10px;"></div>
												<div class="input-group">
													<input type="text" id="reply-text" name="reply-text"
														placeholder="댓글을 입력하세요" class="form-control">
													<button class="btn btn-primary" id="reply-btn" style="background-color: #43bc9c; border: #439cbc; font-weight: bold;">등록</button>
												</div>
											</div>
										</div>

										<!-- 오른쪽 container -->
										<div class="col-lg-3">

											<c:if test="${map.dto.isrec == 'y'}">
												<div>
													<span class="badge badge-danger" style="font-size: 16px; font-weight: bold;">모집중</span>
												</div><div style="height: 5px;"></div>
											</c:if>
											<c:if test="${map.dto.isrec == 'n'}">
												<div>
													<span class="badge badge-success" style="font-size: 16px; font-weight: bold;">모집완료</span>
												</div><div style="height: 5px;"></div>
											</c:if>

											<c:choose>
												<c:when test="${sessionScope.userid != null }">
													<c:choose>
														<c:when
															test="${map.dto.writer != sessionScope.userid and map.ismatch == 'n'}">
															<div id="join-create" class="btn btn-primary" style="background-color: #43bc9c; border: #43bc9c; font-weight: bold;">참여하기</div>
														</c:when>
														<c:when
															test="${map.dto.writer != sessionScope.userid and map.ismatch == 'y'}">
															<div id="join-delete" class="btn btn-danger" style="font-weight: bold;">취소하기</div>
														</c:when>
													</c:choose>
												</c:when>
											</c:choose>

											<!-- 안내문 -->
											<div class="warn">
												<div
													class="au-card au-card--no-shadow au-card--no-pad m-b-40 au-card--border">
													<div class="au-card-title"
														style="background-image: url('images/bg-title-01.jpg');">
														<div class="bg-overlay bg-overlay--blue" style="background-color: #43bc9c;"></div>
														<h3 style="font-weight: bold;">
															<i class="zmdi zmdi-pin-help"></i>안내문
														</h3>
													</div>
													<div class="au-task js-list-load au-task--border">

														<div class="au-task__title" style="font-weight: bold;">
															<i class="zmdi zmdi-tag" style="padding-right: 5px;"></i>모집요강
														</div>
														<div class="au-task__item">
															<div class="au-task__item-inner">
																<p class="task" style="text-align: left;">1. 신청글을 작성 후 올립니다.</p>
																<p class="task" style="text-align: left;">2. 상대팀에서 확인 후 참여신청 연락이 옵니다.</p>
																<p class="task" style="text-align: left;">3. 신청자 중 원하시는 팀을 고릅니다.
																<p class="task" style="text-align: left;">4. 기재된 연락처를 통해 연락합니다.</p>
															</div>
														</div>

														<div class="au-task__title" style="font-weight: bold;">
															<i class="zmdi zmdi-tag-close" style="padding-right: 5px;"></i>주의사항
														</div>
														<div class="au-task__item">
															<div class="au-task__item-inner">
																<p class="task" style="text-align: left;">1. 허위 게시글 및 비매너 활동으로 인해 신고당하실 수 있습니다.</p>
																<p class="task" style="text-align: left;">2. 정확한 정보를 게재해주셔야 원활환 매칭이 가능합니다.</p>
															</div>
														</div>
													</div>
												</div>
											</div>

										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 저작권 표시 -->
		<div class="copyright">
		<p class="mt-5 mb-3 text-muted">
			<span><img src="../resources/assets/brand/haja-banner.jpg" width="50px"></span> 
			<span style="color: gray;">Copyright</span>&copy; HAJA
		</p>
		</div>
		<!-- modal -->
		<%@ include file="../include/message_modal.jsp" %>
		<%@ include file="../include/report_modal.jsp" %>
	</div>

	<%@ include file="../include/body_js.jsp"%>
</html>