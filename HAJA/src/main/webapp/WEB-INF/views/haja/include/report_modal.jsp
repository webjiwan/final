<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="modal fade" id="scrollmodal" tabindex="-1"
	role="dialog" aria-labelledby="scrollmodalLabel"
	style="display: none; padding-right: 17px;">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="scrollmodalLabel">신고창</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<div class="modal-body">
				<input type="hidden" id="report-receive" name="report-receive" value="" />
				<label class="form-control-label">신고 유형을 선택하십시오(최대 2개)</label>
				<div class="form-check">
					<div class="checkbox">
	                    <label for="report1" class="form-check-label ">
	                        <input type="checkbox" id="report1" name="report[]" class="form-check-input" value="욕설" class="form-check-input">욕설
	                    </label>
                    </div>
                    <div class="checkbox">
	                    <label for="report2" class="form-check-label ">
	                        <input type="checkbox" id="report2" name="report[]" class="form-check-input" value="비매너 행위" class="form-check-input">비매너 행위
	                    </label>
                    </div>
                    <div class="checkbox">
	                    <label for="report3" class="form-check-label ">
	                        <input type="checkbox" id="report3" name="report[]" class="form-check-input" value="무단지각" class="form-check-input">무단지각
	                    </label>
                    </div>
                    <div class="checkbox">
	                    <label for="report4" class="form-check-label ">
	                        <input type="checkbox" id="report4" name="report[]" class="form-check-input" value="무단탈주, 무단불참" class="form-check-input">무단탈주, 무단불참
	                    </label>
                    </div>
				</div>
				<br>
				<label for="report-text" class="form-conrol-label">상세내용</label>
				<textarea id="report-text" name="report-text" class="form-control" rows="20" style="resize: none;"></textarea>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
				<button id="reportBtn" type="button" class="btn btn-primary">신고하기</button>
			</div>
		</div>
	</div>
</div>

<script>
$(function() {
	$("input[name='report[]']:checkbox").change(function() {
		if ($("input[name='report[]']:checkbox:checked").length >= 2) {
			$(":checkbox:not(:checked)").attr("disabled", "disabled");
		} else {
			$("input[name='report[]']:checkbox").removeAttr("disabled");
		}
	});
	
	$("#reportBtn").click(function() {
		var category = "";
		$("input:checkbox[name='report[]']:checked").each(function() {
			category += $(this).val()+" ";
		});
		var text = $("#report-text").val();
		var receive = $("#report-receive").val();
		
		if (category == "" || text == "") errorMessage('입력안하신 값이 있습니다');
		
		var param = {
				"text" : text,
				"receive" : receive,
				"category" : category
		};
		console.log(param);
		$.ajax({
			type : "post",
			url : "${path}/report/create.do",
			data : param,
			success : function(result) {
				successMessage('신고했습니다');
			},
			error : function(request, status, error) {
				errorMessage(request.responseText);
			}
		}); 
	});
});

function reportEventBtn(id) {
	$("#report-receive").val(id);
}
</script>