<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!-- 체크 모달 -->
<div class="modal fade check_modal" id="modal-check">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title"></h4>
			</div>

			<div class="modal-body text-center"></div>

			<div class="modal-footer">
				<form id="roomCheckForm" action="" method="POST">
					<input type="hidden" id="pj_Num" name="pj_Num" value="${list[0].PJ_NUM}">
					<input type="hidden" id="info" name="info" value="">
					<input type="submit" class="send_btn btn btn-danger pull-left">
					<a href="#" class=" btn btn-default" data-dismiss="modal">CANCLE</a>
				</form>
			</div>
		</div>
	</div>
</div>