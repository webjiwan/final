<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../include/header.jsp"%>
<script type="text/javascript">
	$(function() {
		listMatch(1);
	});
	
	function listMatch(page) {
		$.ajax({
			type : "get",
			url : "${path}/join/matchList.do?curPage="+page,
			success : function(result) {
				var output = "<table class='table table-data2'>";
				output += "<thead><tr><th style='width: 10%;'>상대 아이디</th><th style='width: 10%;'>상대 팀이름</th><th style='width: 10%'>방이름</th><th style='width: 45%; text-align: center;'>장소</th><th style='width: 10%;'>일정</th><th style='width: 10%'>매칭여부</th><th style='width: 5%;'></th></tr></thead>"
				output += "<tbody>"
				
				for (var i in result.list) {
					output += "<tr class='tr-shadow'>";
					if (result.list[i].userid2 == "${sessionScope.userid}") {
						output += "<td><span class='text-danger'>"+result.list[i].userid2+"</span></td>";
					} else {
						output += "<td><span class='has-sub user-sub'><a class='js-arrow text-danger' onclick='matchMenu("+result.list[i].jno+")'>"+result.list[i].userid2+"</a>"
						+"<ul id='matchMenu"+result.list[i].jno+"' class='list-unstyled navbar__sub-list js-sub-list user-nav' style='display: none;'>"
						+"<li><button type='button' class='btn btn-secondary mb-1' data-toggle='modal' data-target='#scrollmodal' onclick='messageEventBtn(\""+result.list[i].userid2+"\")'>"
						+"<i class='fa fa-envelope' style='padding-right: 5px;'></i>메세지 보내기</button></li>"
						+"<li><button type='button' class='btn btn-secondary mb-1' data-toggle='modal' data-target='#scrollmodal' onclick='reportEventBtn(\""+result.list[i].userid2+"\")'>"
						+"<i class='fa fa-thumbs-down' style='padding-right: 5px;'></i>신고하기</button></li>"
						+"</ul></span></td>";
					}
					
					output += "<td>"+result.list[i].teamid+"</td>";
					output += "<td><a href='${path}/board/view.do?bno="+result.list[i].bno+"' class='text-muted'>"+result.list[i].title+"</a></td>";
					output += "<td style='text-align: center;'>"+result.list[i].place+"</td>";
					output += "<td>"+changeDate(result.list[i].calendar)+"</td>";
					output += "<td>"
					
					if (result.list[i].ismatch == 'y') {
						output += "<span class='badge badge-success'>매칭완료</span>";
					}
					
					if (result.list[i].ismatch == 'n') {
						output += "<span class='badge badge-warning'>매칭중</span>";
					}
					
					output += "</td><td>";
					output += "<button class='item' data-toggle='tooltip' data-placement='top' title='' data-original-title='Delete' onclick='deleteMatchBtn("+result.list[i].jno+")'><i class='zmdi zmdi-delete'></i></button>";
					output += "</td></tr><tr class='spacer'></tr>";
				}
				
				output += "</tbody></table>";
				output += "<nav aria-label='Page navigation'>";
				output += "<ul class='pagination pagination-circle pg-blue justify-content-center'>";
				
				if (result.pager.curBlock > 1) {
					output += "<li class='page-item'><a class='page-link' onclick='listMatch(1)'>First</a></li>"
					output += "<li class='page-item'><a class='page-link'"+
					"onclick='listMatch("+result.pager.prevPage+")' aria-label='Previous'>"+
					"<span aria-hidden='true'>&laquo;</span> <span class='sr-only'>Previous</span></a></li>";
				}
				
				for (var i=result.pager.blockBegin; i<=result.pager.blockEnd; i++) {
					if (i == result.pager.curPage) {
						output += "<li class='page-item active'><a class='page-link'>"+i+"</a></li>";
					} else {
						output += "<li class='page-item'><a class='page-link' onclick='listMatch("+i+")'>"+i+"</a></li>";
					}
				}
				
				if (result.pager.curBlock < result.pager.totBlock) {
					output += "<li class='page-item'><a class='page-link' onclick='listMatch("+result.pager.nextPage+")' aria-label='Next'>"+ 
					"<span aria-hidden='true'>&raquo;</span> <span class='sr-only'>Next</span></a></li>";
				}
				
				if (result.pager.curPage < result.pager.totPage) {
					output += "<li class='page-item'><a class='page-link' onclick='listMatch("+result.pager.totPage+")'>Last</a></li>";
				}
				
				output += "</ul></nav>";
				$("#match-table").html(output);
			}
		});
	}
	
	function matchMenu(jno) {
		$("#matchMenu"+jno).toggle();
	}
	
	function deleteMatchBtn(jno) {
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
					type : "get",
					url : "${path}/join/delete.do?jno="+jno,
					success : function() {
						successMessage('매칭을 삭제하셨습니다');
					},
					error : function() {
						errorMessage('이미 매칭을 삭제하였거나 로그인하지 않았습니다');
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
						<div id="match-table" class="table-responsive table-responsive-data2">
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