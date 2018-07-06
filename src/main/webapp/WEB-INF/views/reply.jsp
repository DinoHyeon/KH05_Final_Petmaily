<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="resources/plugIn/jquery-ui.css">
<link rel="stylesheet" href="resources/plugIn/jquery-ui.theme.css">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="resources/plugIn/jquery-ui.js"></script>
<script src="resources/js/autosize.js"></script>
<title>Insert title here</title>
<style type="text/css">
#ip{
	font-size: 10px;
}

.del{
	float: left;
	padding: 5px;
}

.modi{
	float: left;
	padding: 5px;
}

.content{
	background-color: white;
	resize: none;
}

</style>
</head>
<body>
<div id="noneMemberPassChk" title="비회원 댓글 삭제">
	<div>
		<h1>비밀번호를 입력해주세요.</h1>
		<input id="replyPass" type="password">
	</div>
</div>

<div class="registArea">
	<input type="text" id="replyContent" placeholder="내용">
	<c:set var="loginId" value="${sessionScope.loginId}"/>
    	<c:if test="${empty loginId}">
			비밀번호 <input type="password" id="noneMemberPass">
    	</c:if>
	<input type="button" onclick="regist()" value="저장">
</div>
<div class="replyArea">
	<table>
		<thead>
			<tr>
				<th>작성자</th>
				<th>내용</th>
				<th></th>
			</tr>
		</thead>
		<tbody id="replyList">
		</tbody>
	</table>
</div>
</body>
<script>
var replyIdx;
var request;

$(document).ready(function() {
	replyListCall();
	$( "#noneMemberPassChk" ).dialog({
		autoOpen: false,
     	resizable: false,
	    height: "auto",
	    width: 400,
	    modal: true,
	    buttons: {
	    	"확인": function() {
	    		replyPassChk();
	        },
	   }
	});
});

function replyListCall() {
	$.ajax({
		type : "get",
		url : "./replyListCall",
		data : {
			"idx": 1,
		},
		success : function(data) {
			listPrint(data);
		},
		error : function(e) {
			console.log(e);
		}
	});
}

function replyPassChk() {
	$.ajax({
		type : "get",
		url : "./replyPassChk",
		data : {
			"idx": replyIdx,
			"pass": $("#replyPass").val()
		},
		success : function(data) {
			if(data){
				$("div#noneMemberPassChk.ui-dialog-content.ui-widget-content").dialog( "close" );
				if(request=='del'){
					replyDel(replyIdx)
				}else{
					replyModiForm(replyIdx);
				}
				$("#replyPass").val("");
				replyIdx=null;
				request=null;
			}else{
				alert("비밀번호가 일치하지않습니다.");
				$("#replyPass").val("");
			}
		},
		error : function(e) {
			console.log(e);
		}
	});
}

function listPrint(data){
	var content="";
	data.forEach(function(item){
		var pre = item.reply_writer.substr(0,3);
		var ip = item.reply_writer.substr(4,15);
		var ipArr = ip.split('.');
		
		content += "<tr>";
		if(item.reply_writer.indexOf("비회원")!=-1){
			content += "<td>"+pre+"<sapn id='ip'>"+ipArr[0]+"."+ipArr[1]+".*.*</span></td>";
		}else{
			content += "<td>"+item.reply_writer+"</td>";
		}
		
		
	    	
		//content += "<td><div id='"+item.reply_idx+"' contenteditable='true'>"+item.reply_content+"</div></td>";
		content += "<td><textarea class='content' id='"+item.reply_idx+"' cols='80' id='"+item.reply_idx+"' onkeyup='autoSize()' readonly='true' disabled>"+item.reply_content+"</textarea></td>";
		if(item.reply_writer.indexOf("비회원")!=-1){
			content += "<c:set var='loginId' value='${sessionScope.loginId}'/>";
			content += "<c:if test='${empty loginId}'>";
			content += "<td class='btn' id='"+item.reply_idx+"'>";
			content += "<div class='modi' id='"+item.reply_idx+"' onclick='replyModiChk("+item.reply_idx+",this)'> 수정 </div>";
			content += "<div class='del' id='"+item.reply_idx+"' onclick='replyModiChk("+item.reply_idx+",this)'> 삭제 </div>";
			content += "</td>";
			content += "</c:if>";
		}
		if(item.reply_writer=='${sessionScope.loginId}'){
			content += "<td>";
			content += "<div class='modi' id='"+item.reply_idx+"' onclick='replyModiForm("+item.reply_idx+")'>수정</div>";
			content += "<div class='del' id='"+item.reply_idx+"' onclick='replyDel("+item.reply_idx+")'> 삭제 </div>";
			content += "</td>";
		}
		content += "</tr>";
	});
	
	$("#replyList").empty();
	$("#replyList").append(content);
}

function regist() {
	$.ajax({
		type : "get",
		url : "./replyRegist",
		data : {
			"idx": 1,
			"content":$("#replyContent").val(),
			"pass":$("#noneMemberPass").val()
		},
		success : function(data) {
			$("#replyContent").val("");
			$("#noneMemberPass").val("");
			replyListCall();
		},
		error : function(e) {
			console.log(e);
		}
	});
}

function replyDel(idx) {
	var del = confirm("해당 댓글을 삭제하시겠습니까?");
	if(del){
		$.ajax({
			type : "get",
			url : "./replyDel",
			data : {
				"replyIdx": idx
			},
			success : function(data) {
				if(data==1){
					alert("댓글이 삭제되었습니다");
					replyListCall();
				}
				
			},
			error : function(e) {
				console.log(e);
			}
		});
	}
}

function replyModiChk(data,req) {
	request = $(req).attr("class");
	replyIdx=data;
	$( "#noneMemberPassChk" ).dialog( "open" );
}

function replyModi(data) {
	$.ajax({
		type : "get",
		url : "./replyModi",
		data : {
			"replyIdx": data,
			"content": $(".content[id='"+data+"']").val()
		},
		success : function(result) {
			if(result==1){
				alert("댓글이 수정되었습니다.");
				replyListCall();
			}
			
		},
		error : function(e) {
			console.log(e);
		}
	});
}

function replyModiForm(data) {
	$(".content[id="+data+"]").css("border-color","red");
	$(".content[id="+data+"]").attr("readOnly",false);
	$(".content[id="+data+"]").attr("disabled",false);
	$(".modi[id="+data+"]").html(" 취소 ");
	$(".modi[id="+data+"]").attr("onclick","replyListCall()");
	$(".del[id="+data+"]").html(" 저장 ");
	$(".del[id="+data+"]").attr("onclick","replyModi("+data+")");
	$("td[class='btn']").not($("td[id="+data+"]")).css("display","none");
}

function autoSize() {
	console.log($(this));
	$(this).css("height","1px");
	$(this).css("height",(20+$(this).scrollHeight)+"px");
}
</script>
</html>