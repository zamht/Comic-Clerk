<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- The Modal -->
<div class="modal" id="MemberModifyModal">
	<div class="modal-dialog">
		<div class="modal-content" align="center">

			<!-- Modal Header -->
			<div class="modal-header">
				<h3 class="modal-title">회원 관리</h3>
			</div>

			<!-- Modal body -->
			<div class="card">
				<div class="card-body">
					<h4 class="card-title">
						<font style="vertical-align: inherit;">회원 수정</font>
					</h4>
					<form class="forms-sample" action="/member/AdminMemberModify" method="post" autocomplete="off" onsubmit="return modifyvalidate();">
						<div class="form-group">
							<label>
								<font style="vertical-align: inherit;">아이디</font>
							</label>
							<input name="MEMBER_ID" id="MEMBER_ID_modify" readonly="readonly" class="form-control">
						</div>
						<div class="form-group">
							<label>
								<font style="vertical-align: inherit;">이름</font>
							</label>
							<input name="MEMBER_NAME" id="MEMBER_NAME_modify" readonly="readonly" class="form-control">
						</div>
						<div class="form-group">
							<label>
								<font style="vertical-align: inherit;">이메일</font>
							</label>
							<input name="MEMBER_EMAIL" id="MEMBER_EMAIL_modify" type="email" class="form-control" maxlength="50"
							style="border:3px solid #dadfe4">
						</div>
						<div class="form-group">
							<label>
								<font style="vertical-align: inherit;">핸드폰 번호</font>
							</label>
							<div>
				                <input type="text" class="form-control" id="MEMBER_PHONE_NUMBER1_modify"
				                		name="MEMBER_PHONE_NUMBER1" style="display:inline;float:left; width: 30%" maxlength="3">
				                <h3 style="display:inline;float:left; width: 5%; height: 3.5rem; margin: 15px 0px; text-align: center;">-</h3>
				                <input type="text" class="form-control" id="MEMBER_PHONE_NUMBER2_modify" 
				                		name="MEMBER_PHONE_NUMBER2" style="display:inline;float:left; width: 30%" maxlength="4">
				                <h3 style="display:inline;float:left; width: 5%; height: 3.5rem; margin: 15px 0px; text-align: center;">-</h3>
				                <input type="text" class="form-control" id="MEMBER_PHONE_NUMBER3_modify" 
				                		name="MEMBER_PHONE_NUMBER3" style="display:inline;float:left; width: 30%" maxlength="4">
			                </div>
			                <input type="hidden" name="MEMBER_PHONE_NUMBER" id="MEMBER_PHONE_NUMBER4_modify" value="">
						</div>
						<div class="form-group" align="center"  style="float: right; width:430px;">
							<button type="submit" class="btn btn-warning" style="color:white;">수정</button>
							<button type="button" id="modifyclose_modify" class="btn btn-secondary">닫기</button>
						</div>
					</form>
				</div>
			</div>

		</div>
	</div>
</div>

<!-- End Modal -->