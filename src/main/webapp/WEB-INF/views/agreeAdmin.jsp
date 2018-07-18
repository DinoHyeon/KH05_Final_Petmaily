<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>관리자페이지 승인대기</title>
<style>
table, th, td {
	border-collapse: collapse;
	padding: 6px 15px;
	margin: 170px 10px 105px 440px;
	text-align: center;
}

table,tr{
	border: 1px solid black;
}
#noreason{

resize:none;
width: 250px;
height: 200px;
}


</style>
</head>
<body>
	<jsp:include page="mainFrame.jsp"/>
	<table>
	<thead>
				<tr>
					<th>글번호</th>
					<th>글제목</th>
					<th>승인상태</th>
					<th>[승인/거부]</th>
				</tr>
				</thead>			
		<tbody id="agreeTable">
			</tbody>
	
	</table>
	<div id="paging" >
	</div>
	

<div id="agreedialog">

<span id="idx"></span><br>
거절사유:
<textarea id = "noreason"></textarea>
<input type="button" onclick="sendmessage()" class="send" value="보내기">
</div>



</body>
<script>





var obj = {};		
obj.type="get";
obj.dataType="json";
obj.error=function(e){console.log(e)};
var showPageNum = 1

$(document).ready(function() {
	agreelistCall(showPageNum)
});


function agreelistCall(page){
	$.ajax({
		type : "get",
		url : "./getagreeList",
		data : {
			"showPageNum" : page
		},
		success : function(data) {
			agreelistPrint(data);
			showPageNum=data.currPage;  //보여지는 페이지 = 현재 페이지 (data.currPage)

		},
		error : function(e) {
			console.log(e);
		}
	});
}


function agreelistPrint(data) {
	
		var content = "";
    	data.list.forEach(function(item) {
			content += "<tr>"; 
			content += "<td>" + item.board_idx + "</td>";
			content += "<td><a href='funddetail?idx="+item.board_idx+"&call=detail' style='color: blue'>"+ item.board_title +"</a></td>";
			content += "<td>" + item.fund_state + "</td>";
			content += "<td><input class='yes' type='button' value='승인' id="+ item.board_idx +"><input class='no' type='button' onclick='popup()' value='거부' id="+ item.board_idx +"></td>";
			content += "</tr>"; 
		})
		$("#agreeTable").empty();
		$("#agreeTable").append(content); 
		$("#paging").zer0boxPaging({
            viewRange : 5,
            currPage : data.currPage,
            maxPage : data.range,
            clickAction : function(e){
            	 agreelistCall($(this).attr('page'));
            }
        });
	}	
	
	
	/*승인 버튼 클릭시 승인대기->승인  */
$(document).on('click', '.yes', function() {	

	var agree = confirm("승인하시겠습니까?");
	
	if(agree){
		$.ajax({
			"type" : "get",
			"url":"./agreeAd",
			
			"data":{
				idx:$(this).attr('id')
			},
	 	     "success" : function(data) {
			console.log(data);
			
			
			if (data) {
				agreelistCall(showPageNum);
			$("#reason").html(data);
			
		} else {
				alert("불러오기 실패!")
			}
		}
		
	});
	   ajaxCall(obj);
		
		
	}

});

/*승인 거부 버튼 클릭시 팝업창 활성화  idx값*/	
function popup(){
	
	  $('#agreedialog').dialog({
	      title: '승인 거부',
	      modal: true,
	      width: '300',
	      height: '300',
	      
	  
	});
	  
	  
	  
	  $(document).on('click', '.no', function() {	
			
		  $.ajax({
			  "type" : "get",
			  "url":"./sendno",
			  "data":{
				  idx:$(this).attr('id'),
				 
			  },
			
			  "success" : function(data) {
			
					if (data) {
						
						$("#idx").html(data);
						
					
						
				} else {
						alert("불러오기 실패!")
					}
				}
				
			});
		   
			   ajaxCall(obj);
		   
		   });
	  
	
}
//소현: 관리자 페이지 승인 리스트 거부 버튼 클릭시 거절사유 전송	 
 function sendmessage(){
	console.log($("#noreason").val());
	console.log($("#idx").text());
	
	  $.ajax({
		  "type" : "get",
		  "url":"./sendreason",
		  "data":{
			  idx:$("#idx").text(),
			  reason:$("#noreason").val()
		  },
		
		  "success" : function(data) {
		
				if (data) {
					
				$('#agreedialog').dialog('close');
					agreelistCall(showPageNum);
					alert("거절 사유 전송을 완료했습니다.!")

					
					
			} else {
					alert("불러오기 실패!")
				}
			}
			
		});
	   
		   ajaxCall(obj);
	
	
} 


function ajaxCall(param){
	console.log(param);
	$.ajax(param);
}




</script>

</html>