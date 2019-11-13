<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="modal" id="headerMemberModifyModal">
			<div class="modal-dialog">
				<div class="modal-content" align="center">

					<!-- Modal Header -->
					<div class="modal-header">
						<h3 class="modal-title">회원 정보</h3>
					</div>

					<!-- Modal body -->
					<div class="card">
						<div class="card-body">
							<h4 class="card-title">
								<font style="vertical-align: inherit;">회원 정보</font>
							</h4>
							<form class="forms-sample" name="headermembermodify" method="post" autocomplete="off" action="/member/MemberModify" onsubmit="return headervalidate();">
								<div class="form-group">
									<label> <font style="vertical-align: inherit;">아이디</font>
									</label> <input name="MEMBER_ID" id="HeaderMEMBER_ID" readonly="readonly"
										class="form-control" value="${Memberlogin.MEMBER_ID}"/>
								</div>
								<div class="form-group">
									<label> <font style="vertical-align: inherit;">이름</font>
									</label> <input name="MEMBER_NAME" id="HeaderMEMBER_NAME" readonly="readonly"
										class="form-control" value="${Memberlogin.MEMBER_NAME}">
								</div>
								<div class="form-group">
									<label> <font style="vertical-align: inherit;">비밀번호</font>
									</label> <input name="MEMBER_PWD" id="HeaderMEMBER_PWD" type="password"
										class="form-control" style='ime-mode:disabled' maxlength="12">
								</div>
								<div class="form-group">
									<label> <font style="vertical-align: inherit;">이메일</font>
									</label> <input name="MEMBER_EMAIL" id="HeaderMEMBER_EMAIL" type="email"
										class="form-control" value="${Memberlogin.MEMBER_EMAIL}" maxlength="50">
								</div>
								<div class="form-group">
									<label> <font style="vertical-align: inherit;">핸드폰
											번호</font>
									</label>
									<div>
						                <input type="text" class="form-control" id="HeaderMEMBER_PHONE_NUMBER1"
						                		name="MEMBER_PHONE_NUMBER1" style="display:inline;float:left; width: 30%" maxlength="3">
						                <h3 style="display:inline;float:left; width: 5%; height: 3.5rem; margin: 15px 0px; text-align: center;">-</h3>
						                <input type="text" class="form-control" id="HeaderMEMBER_PHONE_NUMBER2" 
						                		name="MEMBER_PHONE_NUMBER2" style="display:inline;float:left; width: 30%" maxlength="4">
						                <h3 style="display:inline;float:left; width: 5%; height: 3.5rem; margin: 15px 0px; text-align: center;">-</h3>
						                <input type="text" class="form-control" id="HeaderMEMBER_PHONE_NUMBER3" 
						                		name="MEMBER_PHONE_NUMBER3" style="display:inline;float:left; width: 30%" maxlength="4">
					                </div>
					                <input type="hidden" name="MEMBER_PHONE_NUMBER" id="HeaderMEMBER_PHONE_NUMBER4" value="">
								</div>
								<div class="form-group" align="center"  style="float: right; width:430px;">
									<button type="submit" id="headermodifyBtn" name="headermodifyBtn" class="btn btn-info">수정</button>
									<button type="button" id="headermodifyclose" class="btn btn-success">닫기</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>