<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="modal fade" id="largeModal" tabindex="-1" role="dialog"
	aria-labelledby="largeModalLabel"
	style="display: none; padding-right: 17px;">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="largeModalLabel">메세지창</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<input type="hidden" id="message-receive" name="message-receive">
			<div class="modal-body">
				<textarea class="form-control" id="messagetext" rows="20" style="resize: none;"></textarea>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
				<button id="messageBtn" type="button" class="btn btn-primary">보내기</button>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
$(function() {
	$("#messageBtn").click(function() {
		var text = $("#messagetext").val();
		var receive = $("#message-receive").val();
		var param = {
				"text" : text,
				"receive" : receive
		};
		$.ajax({
			type : "post",
			url : "${path}/message/create.do",
			data : param,
			success : function() {
				successMessage('메세지를 보냈습니다');
			},
			error : function() {
				errorMessage('로그인을 하지 않았거나 없거나 잘못된 상대방에게 보냈습니다');
			}
		});
	});
});

function messageEventBtn(id) {
	$("#message-receive").val(id);
}
</script>