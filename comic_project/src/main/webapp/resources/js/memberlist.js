var re2 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;  // 이메일이 적합한지 검사할 정규식
var regExp = /^\d{3}-\d{3,4}-\d{4}$/; // 핸드폰번호 정규식

var email = document.getElementById("MEMBER_EMAIL_modify");
var phone4 = document.getElementById("MEMBER_PHONE_NUMBER4_modify");
var phone1,phone2,phone3,phone4;

$('input').keydown(function() {
	  if (event.keyCode === 13) {
	    event.preventDefault();
	  };
});

$(document).ready(function(){
	
	$('#modalstyle').css('display','none');
	$('#memberListTable').DataTable({ // 페이징 처리, 검색, show entries
		pageLength: 10, //처음 페이지에 처리 개수
	    bPaginate: true, // 페이징 기능
	    bLengthChange: true,
	    lengthMenu : [ [ 10, 20, 30, -1 ], [ 10, 20, 30, "All" ] ], //show entries
	    bAutoWidth: false,
	    processing: true,
	    ordering: true,
	    serverSide: false,
	    searching: true, // 검색 기능
	    ajax : {
	    	url : "/member/MemberData.json",
	    	type : "get",
	    	dataSrc: '',
	    },
	    aoColumns: [
	    	{data: "member_ID"},
	    	{data: "member_NAME"},
	    	{data: "member_EMAIL"},
	    	{data: "member_PHONE_NUMBER"},
            {
                mData: "member_ID",
                mRender: function (data, type, row) {
                    return "<button name ='membermodifyBtn' value=" + data +" type='button' class='btn btn-warning' onclick='javascript:membermodifyBtn(value)' style='color:white;'>수정</button> ";
                }
            }
        ],
	    
	    bStateSave: true,
	    "iDisplayLength": 10,
	    "language": {
	      search: "Search :"
	    },
	    "columnDefs": [{
	        targets: 'no-sort',
	        orderable: false
	    }],
	    
	    order: [[0, 'desc']]
	});
	
});

function membermodifyBtn(MEMBER_ID) {
    	
	$.ajax({
	    type: 'get',
	    url: "/member/MemberModify?MEMBER_ID="+MEMBER_ID,
	    dataType : "json",
	    success: function(data) {
	    	$('#MEMBER_ID_modify').attr('value',data.getModify['member_ID']);
	    	$('#MEMBER_NAME_modify').attr('value',data.getModify['member_NAME']);
	    	$('#MEMBER_EMAIL_modify').attr('value',data.getModify['member_EMAIL']);
	    	var Modifyphonenum = data.getModify['member_PHONE_NUMBER'];
			var Modifyphone = Modifyphonenum.split("-");
			$('#MEMBER_PHONE_NUMBER1_modify').attr('value',
					Modifyphone[0]);
			$('#MEMBER_PHONE_NUMBER2_modify').attr('value',
					Modifyphone[1]);
			$('#MEMBER_PHONE_NUMBER3_modify').attr('value',
					Modifyphone[2]);
	    	$('#MemberModifyModal').show();
	    }
	});
	$('#modifyclose_modify').click(function(){
		$('#MemberModifyModal').hide();
		$('#MemberModifyModal').find('form')[0].reset();
		$('#modalstyle').css('display','none');
	});
	$('#modalstyle').css('display','');
	
}

function modifyvalidate() {
	  phone1 = $('#MEMBER_PHONE_NUMBER1_modify').val();
	  phone2 = $('#MEMBER_PHONE_NUMBER2_modify').val();
	  phone3 = $('#MEMBER_PHONE_NUMBER3_modify').val();
	  $('#MEMBER_PHONE_NUMBER4_modify').val(phone1 + "-" + phone2 + "-" + phone3);
	  
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
    if(re.test(what.value)) {
        return true;
    }
    alert(message);
    if(what===phone4){
  	  $('#MEMBER_PHONE_NUMBER1_modify').val('');
  	  $('#MEMBER_PHONE_NUMBER2_modify').val('');
  	  $('#MEMBER_PHONE_NUMBER3_modify').val('');
  	  $('#MEMBER_PHONE_NUMBER1_modify').focus();
    } else {
    what.value = "";
    what.focus();
    }
    return false;
}
