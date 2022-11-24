<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
.img-cir i {
	font-size: 22px;
	color: #fff;
	position: relative;
	top: 25%;
	left: 30%;
}
</style>
<%@ include file="../include/header.jsp"%>
<script type="text/javascript">
$(function() {
	listAlarm(1);
});

function listAlarm(page) {
	$.ajax({
		type : "get",
		url : "${path}/alarm/alarmList.do?curPage="+page,
		success : function(result) {
			var output = "<table class='table table-data2'>";
			output += "<thead><tr><th style='width= 20%;'></th><th style='width= 60%;'>내용</th><th style='width= 10%;'>날짜</th><th style='width= 10%;'></th></tr></thead>"
			output += "<tbody>"
			
			for (var i in result.list) {
				output += "<tr class='tr-shadow'>";
				output += "<td><div class='bg-c3 img-cir img-40'><i class='zmdi zmdi-notifications'></i></div></td>";
				output += "<td>"+result.list[i].alarmtext+"</td>";
				output += "<td>"+changeDate(result.list[i].regdate)+"</td>";
				output += "<td><button class='item' data-toggle='tooltip' data-placement='top' title='' data-original-title='Delete' onclick='deleteAlarmBtn("+result.list[i].ano+")'><i class='zmdi zmdi-delete'></i></button></td>";
				output += "</tr><tr class='spacer'></tr>";
			}
			
			output += "</tbody></table>";
			output += "<nav aria-label='Page navigation'>";
			output += "<ul class='pagination pagination-circle pg-blue justify-content-center'>";
			
			if (result.pager.curBlock > 1) {
				output += "<li class='page-item'><a class='page-link' onclick='listAlarm(1)'>First</a></li>"
				output += "<li class='page-item'><a class='page-link'"+
				"onclick='listAlarm("+result.pager.prevPage+")' aria-label='Previous'>"+
				"<span aria-hidden='true'>&laquo;</span> <span class='sr-only'>Previous</span></a></li>";
			}
			
			for (var i=result.pager.blockBegin; i<=result.pager.blockEnd; i++) {
				if (i == result.pager.curPage) {
					output += "<li class='page-item active'><a class='page-link'>"+i+"</a></li>";
				} else {
					output += "<li class='page-item'><a class='page-link' onclick='listAlarm("+i+")'>"+i+"</a></li>";
				}
			}
			
			if (result.pager.curBlock < result.pager.totBlock) {
				output += "<li class='page-item'><a class='page-link' onclick='listAlarm("+result.pager.nextPage+")' aria-label='Next'>"+ 
				"<span aria-hidden='true'>&raquo;</span> <span class='sr-only'>Next</span></a></li>";
			}
			
			if (result.pager.curPage < result.pager.totPage) {
				output += "<li class='page-item'><a class='page-link' onclick='listAlarm("+result.pager.totPage+")'>Last</a></li>";
			}
			
			output += "</ul></nav>";
			$("#alarm-table").html(output);
			$("#alarm-cnt").html(result.alarmCnt);
		}
	});
}

function deleteAlarmBtn(ano) {
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
				url : "${path}/alarm/delete.do?ano="+ano,
				success : function() {
					successMessage('알람을 삭제하셨습니다');
				},
				error : function() {
					errorMessage('이미 알람을 삭제하였거나 다른 아이디의 알람입니다');
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
						<div id="alarm-table" class="table-responsive table-responsive-data2"></div>
					</div>
				</div>
			</div>
		</div>
		
	</div>
<%@ include file="../include/body_js.jsp"%>
</body>
</html>