var socket = new WebSocket("ws://localhost:8080/echo_order");
socket.onopen = function() {
	console.log("소켓 시작");
};
var roomValue;
var setIntervalChatStop;
var setIntervalOrderStop;
var setIntervalStopChatCss;
var checkChat = false;
var checkOrder = false;

function orderArlet(roomNum, userid) {
	   alert(roomNum + " 방"  + userid + "님 주문!");
	   $("#orderDetail" + roomNum).css("background-color","RGB(255,71,71)");
	   $("#orderDetail" + roomNum).css("border-color","RGB(255,71,71)");
	   if (checkOrder == true) {
		   clearInterval(setIntervalOrderStop);
	   }
	   setIntervalOrderStop = setInterval("flashOrder("+roomNum+")", 500);
}

socket.onmessage = function(event) {
	console.log(event.data);
	var data = event.data.split('|');
	  if(data[0] == "chat") {
		  roomValue = data[1];
	      test = data[1];
	      message_side = 'left';
	      console.log(data); 
	      sendMessage(data[2]);
	      console.log("##########################채팅");
	      $("#chat" + test).css("background-color","rgb(255, 71, 71)");
	      $("#chat" + test).css("border-color","rgb(255, 71, 71)");
	      $('#chatCss').css('display','');
	      if (checkChat == true) {
	    	  clearInterval(setIntervalChatStop);
	      }
	      setIntervalChatStop = setInterval("flashChat("+test+")", 500);
	   } else {
	      if(data[1] == "주문") {
	         console.log("test");
	         orderArlet(data[0], data[2]);
	         realOrderRenew();
	      } else if(data[1] == "시작") {
	         ajaxtosenddb_comic_room_use2(data[2], data[0], "on");
	      } else if(data[1] == "종료") {
	         console.log(sessionValue);
	         chatDataDelete(data[0]);
	         ajaxtosenddb_comic_room_use2(data[2], data[0], "off");
	         alert(data[0] + "방 사용 종료!!");
	         location.href="/managerpos/managerpos";
	      } else if(data[1] == "주문가져가") {
	         alert('주문이 준비되었습니다 카운터로 오셔서 가져가주세요!');
	      }
	   }
	};

	function flashChat(test){
	   if ($("#chat" + test).css("background-color") == "rgb(255, 71, 71)") {
	      $("#chat" + test).css("background-color","rgb(113,192,22)");
	      $("#chat" + test).css("border-color","rgb(113,192,22)");
	   }
	   else{ 
	      $("#chat" + test).css("background-color","RGB(255, 71, 71)");
	      $("#chat" + test).css("border-color","rgb(255, 71, 71)");
	   }
	   
	   checkChat = true;
	}


socket.onclose = function() {
	console.log("소켓 끝");
};

	
	
	function flashOrder(roomNum){
	   
	   console.log($("#orderDetail" + roomNum).css("background-color"));
	   if ($("#orderDetail" + roomNum).css("background-color") == "rgb(255, 71, 71)") {
	      $("#orderDetail" + roomNum).css("background-color","RGB(77,131,255)");
	      $("#orderDetail" + roomNum).css("border-color","RGB(77,131,255)");
	   }
	   else{ 
	      $("#orderDetail" + roomNum).css("background-color","RGB(255,71,71)");
	      $("#orderDetail" + roomNum).css("border-color","RGB(255,71,71)");
	   }
	   
	   checkOrder = true;
	   
	}

function userOrderArlet() {
	$("#orderArlet").modal("show");
}

function ajaxtosenddb_comic_room_use2(roomuse_id, roomuse_num,
		roomuse_status) {
	console.log("오니?");
	
	var list = [ roomuse_id, roomuse_num,
		roomuse_status];
	//사용자,시작시간,사용자 상태,주문 상태,방번호
	//alert("보내기전의 list" + list);
	var sendData = {
		'list' : list
	};

	$.ajax({
		url : '/managerpos/room_start2',
		dataType : 'json',
		data : JSON.stringify(sendData),
		contentType : "application/json; charset=utf-8;",
		type : 'POST',
		success : function(data) {
			ajaxtogetdb_comic_room_uselist();
			console.log("성공");
		},
		error : function(data) {
			console.log("실패");
		}
	});
}

function ajaxtogetdb_comic_room_uselist() {			
	console.log("ajaxtogetdb_comic_room_uselist");
	$.ajax({
		url : '/managerpos/get_room_uselist',
		dataType : 'json',
		contentType : "application/json; charset=utf-8;",
		type : 'POST',
		async : false,
		success : function(data) {
			
			var text="";
			console.log(data);
			$.each(data, function(index,list){
				var number=1;
				number = list.roomuse_num;
					startnstop_init(list.roomuse_id,number,list.starttime,list.roomuse_status);
			});

		},
		error : function(data) {
			console.log("실패");
		}
		
	});	
	
}

function chatDataDelete(roomNum) {
	console.log("채팅데이터 날리기");
	$.ajax({
		url : '/chat/chattingDelete?roomNum=' + roomNum,
		dataType : 'json',
		contentType : "application/json; charset=utf-8;",
		type : 'GET',
		success : function(data) {
			
		},
		error : function(data) {
			console.log("실패");
		}
	});	
}


var Message;
Message = function(arg) {
	this.text = arg.text, this.message_side = arg.message_side;
	this.draw = function(_this) {
		return function() {
			var $message;
			if(roomValue == undefined){
				test = chatRoom;
			} else {
				test = roomValue;
			}
			console.log(test);
			$message = $($('.message_template' + test).clone().html());
			$message.addClass(_this.message_side).find('.text').html(
					_this.text);
			$('#messages' + test).append($message);
			return setTimeout(function() {
				return $message.addClass('appeared');
			}, 0);
		};
	}(this);
	return this;
};

var getMessageText, message_side, sendMessage;
getMessageText = function() {
	var $message_input;
	$message_input = $('.message_input');
	return $message_input.val();
};
sendMessage = function(text) {
	var $messages, message;
	if (text.trim() === '') {
		return;
	}
	$messages = $('.messages');
	
	message = new Message({
		text : text,
		message_side : message_side
	});
	message.draw();
	
	return $messages.animate({
		scrollTop : $messages.prop('scrollHeight')
	}, 300);
};
