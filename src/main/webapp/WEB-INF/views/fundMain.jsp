<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
table, th, td {
	border: 1px solid black;
	border-collapse: collapse;
	padding: 6px 15px;
	margin: 170px 10px 105px 440px;
	text-align: center;

}


</style>
</head>
<body>
	<jsp:include page="mainFrame.jsp"/>
			<select id="sido" onchange="getSigungu()">
		      <option value="">선택</option>
		      <option value="6110000">서울특별시</option>
		      <option value="6260000">부산광역시</option>
		      <option value="6270000">대구광역시</option>
		      <option value="6280000">인천광역시</option>
		      <option value="6290000">광주광역시</option>
		      <option value="5690000">세종특별자치시</option>
		      <option value="6300000">대전광역시</option>
		      <option value="6310000">울산광역시</option>
		      <option value="6410000">경기도</option>
		      <option value="6420000">강원도</option>
		      <option value="6430000">충청북도</option>
		      <option value="6440000">충청남도</option>
		      <option value="6450000">전라북도</option>
		      <option value="6460000">전라남도</option>
		      <option value="6470000">경상북도</option>
		      <option value="6480000">경상남도</option>
		      <option value="6500000">제주특별자치도</option>
   		</select>
		<select id="sigundo">
			<option value="">선택</option>
		</select>
		<input type="text" id="keyWord" placeholder="검색어를 입력해주세요." /> 
		<input type="button" onclick="fundlistCall(showPageNum)" value="검색" />
	<table>
	<thead>
		<tr>
					<th>글번호</th>
					<th>글제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
					
					
				</tr>
				</thead>
						<tbody id="fundTable">
			</tbody>
	</table>
	<button onclick="location.href='./fundWrite'">글 작성</button>
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
		fundlistCall(showPageNum)
	}

});

function getSigungu() {
	console.log();
	$.ajax({
		"url" : "./getSigungu",
		"type" : "get",
		"data" : {"sidoCode" : $("#sido").val()},
		"success" : function(data) {
			console.log(data);
			var content = "";
			data.forEach(function(item) {
				content += "<option value="+item.sigundoName+">";
				content += item.sigundoName;
				content += "</option>";
			})
			$("#sigundo").empty();
			$("#sigundo").append(content);
		},
		"error" : function(x, o, e) {
			alert(x.status + ":" + o + ":" + e);
		}
	});
}


function fundlistCall(page){
	$.ajax({
		type : "get",
		url : "./getfundList",
		data : {
			"sido" : $("#sido option:selected").html(),
			"sigundo" : $("#sigundo").val(),
			"keyWord" : $("#keyWord").val(),
			"showPageNum" : page
		},
		success : function(data) {
			fundlistPrint(data);
			showPageNum=data.currPage;  //보여지는 페이지 = 현재 페이지 (data.currPage)

		},
		error : function(e) {
			console.log(e);
		}
	});
}



function fundlistPrint(data) {
	
	var content = "";
		data.list.forEach(function(item,idx) {
			content += "<tr>"; 
			content += "<td>" + item.board_idx + "</td>";
		 content += "<td><a href='funddetail?idx="+item.board_idx+"&call=detail' style='color: blue'>"+ item.board_title +"</a></td>";
		content += "<td>" + item.board_writer+ "</td>";
		var date = new Date(item.board_regDate);			
		content +="<td>"+date.toLocaleDateString("ko-KR")+"</td>"
		content += "<td>" + item.board_hit +"</td>";
       			content += "</tr>"; 
		})
		$("#fundTable").empty();
		$("#fundTable").append(content); 
		
		$("#paging").zer0boxPaging({
            viewRange : 5,
            currPage : data.currPage,
            maxPage : data.range,
            clickAction : function(e){
            	 fundlistCall($(this).attr('page'));
            }
        });
	}		




function ajaxCall(param){
	console.log(param);
	$.ajax(param);
}




</script>

</html>