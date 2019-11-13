function headermembermodifyBtn() {
	$('#headerMemberModifyPasswordModal').show();
	
	$('#headerMemberModifyPasswordclose').click(function(){
		$('#headerMemberModifyPasswordModal').hide();
		$('#headerMemberModifyPasswordModal').find('form')[0].reset();
	});
}

function headerMemberModifyPasswordCheck(MEMBER_ID,MEMBER_PWD){
	$.ajax({
		type : 'get',
		url : "/member/MembermodifyCheck?MEMBER_ID=" + MEMBER_ID +"&MEMBER_PWD=" + MEMBER_PWD,
		dataType : "json",
		success : function(data) {
			console.log(data);
			if(data == 1){
			$('#headerMemberModifyPasswordModal').hide();
			$('#headerMemberModifyPasswordModal').find('form')[0].reset();
			$.ajax({
				type : 'get',
				url : "/member/MemberModify?MEMBER_ID=" + MEMBER_ID,
				success : function(data) {
					$('#HeaderMEMBER_ID').attr('value',
						data.getModify['member_ID']);
					$('#HeaderMEMBER_NAME').attr('value',
							data.getModify['member_NAME']);
					$('#HeaderMEMBER_EMAIL').attr('value',
							data.getModify['member_EMAIL']);
					var Headerphonenum = data.getModify['member_PHONE_NUMBER'];
					var Headerphone = Headerphonenum.split("-");
					$('#HeaderMEMBER_PHONE_NUMBER1').attr('value',
							Headerphone[0]);
					$('#HeaderMEMBER_PHONE_NUMBER2').attr('value',
							Headerphone[1]);
					$('#HeaderMEMBER_PHONE_NUMBER3').attr('value',
							Headerphone[2]);
					$('#headerMemberModifyModal').show();
				}
			});
			$('#headermodifyclose').click(function(){
				$('#headerMemberModifyModal').hide();
				$('#headerMemberModifyModal').find('form')[0].reset();
			});
			} else {
				alert("비밀번호가 틀렸습니다.");
			}
		}
	});
}

function headervalidate() {
	
	var re = /^[a-zA-Z0-9]{4,12}$/; // 패스워드가 적합한지 검사할 정규식
	var re2 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; // 이메일이 적합한지 검사할 정규식
	var regExp = /^\d{3}-\d{3,4}-\d{4}$/; // 핸드폰번호 정규식

	var pw = document.getElementById("HeaderMEMBER_PWD");
	var name = document.getElementById("HeaderMEMBER_NAME")
	var email = document.getElementById("HeaderMEMBER_EMAIL");
	var phone4 = document.getElementById("HeaderMEMBER_PHONE_NUMBER4");
	var phone1,phone2,phone3,phone4;
	
	  phone1 = $('#HeaderMEMBER_PHONE_NUMBER1').val();
	  phone2 = $('#HeaderMEMBER_PHONE_NUMBER2').val();
	  phone3 = $('#HeaderMEMBER_PHONE_NUMBER3').val();
	  phone4.value = (phone1 + "-" + phone2 + "-" + phone3);
	  
      if(pw.value=="") {
    	  alert("비밀번호를 입력해 주세요");
          pw.focus();
          return false;
      }
      
      if(!check(re,pw,"패스워드는 4~12자의 영문 대소문자와 숫자로만 입력해주세요.")) {
          return false;
      }
      
      if(name.value=="") {
          alert("이름을 입력해 주세요");
          name.focus();
          return false;
      }

      if(email.value=="") {
          alert("이메일을 입력해 주세요");
          email.focus();
          return false;
      }

      if(!check(re2, email, "적합하지 않은 이메일 형식입니다.")) {
          return false;
      }
      
      if(!check(regExp, phone4, "적합하지 않은 번호 형식입니다.")) {
    	  return false;
      }
}

function check(re, what, message) {
	var pw = document.getElementById("HeaderMEMBER_PWD");
	var name = document.getElementById("HeaderMEMBER_NAME")
	var email = document.getElementById("HeaderMEMBER_EMAIL");
	var phone4 = document.getElementById("HeaderMEMBER_PHONE_NUMBER4");
	
      if(re.test(what.value)) {
          return true;
      }
      alert(message);
      if(what===phone4){
    	  $('#HeaderMEMBER_PHONE_NUMBER1').val('');
    	  $('#HeaderMEMBER_PHONE_NUMBER2').val('');
    	  $('#HeaderMEMBER_PHONE_NUMBER3').val('');
    	  $('#HeaderMEMBER_PHONE_NUMBER1').focus();
      } else {
      what.value = "";
      what.focus();
      }
      return false;
}

$("#orderOK").on("click", function() {
	$("#ModalorderArlet").modal("hide");
});