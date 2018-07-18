<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
table, th, td {

	border-collapse: collapse;
	padding: 6px 15px;
	float: left;
	margin: 0 10px 50px 10px;
	text-align: center;
}
table,tr{
	border: 1px solid black;

}
#listTable{


	margin: 0 10px 116px 300px;


}


</style>
</head>
<body>
	<jsp:include page="mainFrame.jsp"/>
	<div id="mylistTable"></div>

<div id="dialog">
<span id="reason"></span><span id="content"></span>
</div>

<div id="paging" >
	</div>


</body>
<script>





var obj = {};		
obj.type="get";
obj.dataType="json";
obj.error=function(e){console.log(e)};
var showPageNum = 1


$(document).ready(function() {
	if('${sessionScope.loginId}'==""){
		alert("로그인이 필요한 서비스입니다.");
		location.href="loginPage";}
	else{
	 mylistCall(showPageNum)
	}
});

function mylistCall(page){
	$.ajax({
		type : "get",
		url : "./getmyList",
		data : {
			"showPageNum" : page
		},
		success : function(data) {
			mylistPrint(data);
		},
		error : function(e) {
			console.log(e);
		}
	});
}




function mylistPrint(data) {
	
		var content = "";
		data.list.forEach(function(item) {
			content += "<table>"; 
			content += "<tr>"; 
			content += "<td>" + item.board_idx + "</td>";
			content += "<td><a href='funddetail?idx="+item.board_idx+"&call=detail' style='color: black'>"+ item.board_title +"</a></td>";
			content += "</tr>"; 
			content += "<tr>"; 
			content +="<td><img width='200' height='140' src='./resources/upload/"+item.photo_newName+"'/></td>";
			content += "</tr>"; 
			content += "<tr>"; 
			content += "<td>" + item.fund_state + "</td>";
			 if(item.fund_state=='승인대기'){
			content += "<td><input class='editmy' type='button' value='수정' onClick='edit(id)' id="+ item.board_idx +"><input class='delmy' type='button' value='삭제' id="+ item.board_idx +"></td>";
			 }
			 if(item.fund_state=='승인 거절'){

			content += "<td><input class='reason' type='button' value='사유보기' id="+ item.board_idx +"><input class='delmy' type='button' value='삭제' id="+ item.board_idx +"></td>";
			 }
			content += "</tr>"; 
			content += "</table>"; 
		})
		$("#mylistTable").empty();
		$("#mylistTable").append(content); 
		$("#paging").zer0boxPaging({
            viewRange : 5,
            currPage : data.currPage,
            maxPage : data.range,
            clickAction : function(e){
            	 mylistCall($(this).attr('page'));
            }
        });
	}	
	


/* 마이리스트 삭제  */
$(document).on('click', '.delmy', function() {	
	console.log("삭제");
	var idx = $(this).attr("id");
	
	console.log(idx);
	obj.url = "./delMylist";
	obj.data = {
		idx : idx
	};
	obj.success = function(data) {
		console.log(data);
		if (data==1) {
			alert("삭제에 성공하였습니다.")
			mylistCall(showPageNum);
		} else {
			alert("삭제 실패")
		}
	}
	ajaxCall(obj);
});


/* 나의 모금글 수정 */
function edit(id) {
	var del = confirm("수정하시겠습니까?");
	var idx = $(this).attr("id");
	console.log("수정"+id);
	if(del){
		location.href='./fundupdateForm?idx='+id+'&call=updateForm';
	}
}


/*나의 사유보기 */
$(document).on('click', '.reason', function() {	
	   $('#dialog').dialog({
		      title: '사유보기',
		      modal: true,
		      width: '300',
		      height: '300'
		   });
	   $.ajax({
			"type" : "get",
			"url":"./reason",
			"dataType":"text",
			"data":{
				idx:$(this).attr('id')
			},
	 	     "success" : function(data) {
			console.log(data);
			if (data) {
			$("#reason").html(data);
		} else {
				alert("불러오기 실패!")
			}
		}
		
	});
	   ajaxCall(obj);
});






function ajaxCall(param){
	console.log(param);
	$.ajax(param);
}




</script>

</html>