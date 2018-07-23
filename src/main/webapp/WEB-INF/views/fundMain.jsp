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
	padding: 6% 15%;
	margin: 17% 10% 10.5% 44%;
	text-align: center;

}
		#write{
			position:absolute;
			top:63%;
			left:82%;
			background-color: #28977B;
			border-color:#28977B;
			border-style:solid;
			font-weight: 600;
			color: white;
			cursor: pointer;
			width:8%;
			height: 4%;
		}
	#paging{
			position:absolute;
			top:82%;
			left:53%;
		}
		

	
	#conDiv {
			position: absolute;
			left: 15.52%;
			top: 12.5%;
			width: 82.95%;
			height: 150%;
			background: white;
		}
	#conDiv input[type='button']{
			width:46%;
			height: 69%;
			left:298%;
			top:13%;
			background-color: #28977B;
			border-color:#28977B;
			border-style:solid;
			font-weight: 600;
			color: white;
			cursor: pointer;
		}
		#conDiv h1{
			position: absolute;
			left:40%; 
			margin: 5% 0% 2.5% 0%;
			text-align: center;
			color: #28977B;
			font-weight: 600;
			font-size: 30px;
		}
		#listTable{
			position:absolute;
			top:18%;
			left:10%;
			width:80%;
			margin: 2% 0.5% 20% 0.5%;
			border-collapse: collapse;
			padding: 0.5% 0.1%;
		}
		#listTable input[type='text']{
			width:100%;
		}
		#listTable textarea{
			width:100%;
			resize:none;
			margin:0;
		}
		#listTable td{
			text-align: center;
			border: 1px solid white;
			border-collapse: collapse;
			padding: 0.2% 0.2%;
		}
		#listTable th{
			border: 1px solid white;
			border-collapse: collapse;
			padding: 0.5% 0.1%;
			background-color: #28977B;
			color: white;
		}
		#sideFrame {
			position: absolute;
			left: 0.52%;
			top: 11.4%;
			width: 15%;
			height: 150%;
			background: black;
		}
		/* 셀렉트박스 테이블 */
		#selectTable{
 			top:12%;
			left:15%;
			width:5-%;
			height: 50px;
			position:absolute;
			float: left;
				padding: 5px 10px 5px 10px;
		}
		
		#searchbtn{
		top:12%;
			left:38%;
			width:5-%;
			height: 50px;
			position:absolute;
			float: left;
				padding: 5px 10px 5px 10px;
		
		
		}
		
		#searchbtn input[type='text']{
			width:322%;
			height:88%;
		}
       #selectTable input[type='text']{
			width:100%;
			height:100%;
		}
		#selectTable select { 
			width: 150px; /* 원하는 너비설정 */ 
			padding: .8em .5em; /* 여백으로 높이 설정 */ 
			font-family: inherit; /* 폰트 상속 */ 
			background: url(resources/arrowIcon.jpg) no-repeat 95% 50%; /* 네이티브 화살표 대체 */
			border: 1px solid #999; border-radius: 0px; /* iOS 둥근모서리 제거 */ 
			-webkit-appearance: none; /* 네이티브 외형 감추기 */ 
			-moz-appearance: none; 
			appearance: none; 
		}
		#cSearchKey{
			color:#28977B;
			font-weight:600;
			font-size:13px;
		}
		#fundTable a:link{
			text-decoration: none;
			color: black;
		}
</style>
</head>
<body>

	

	<jsp:include page="mainFrame.jsp"/>
		<div id="sideFrame"></div>
	<div id="conDiv">
		<h1>모금 게시판</h1>
		<div id="selectTable">
			<select id="sido" onchange="getSigungu()" id="cSearchKey" >
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
   		
		<select id="sigundo" id="cSearchKey" name="cSearchKey">
			<option value="">선택</option>
		</select>
		</div>
		<div id="searchbtn">
		<input type="text" id="keyWord" placeholder="검색어를 입력해주세요." /> 
		<input type="button" id="searchBtn" onclick="fundlistCall(showPageNum)" value="검색" />
</div>
	<table id="listTable">
	<thead>
		<tr>
					<th style="width: 150px">글번호</th>
					<th style="width: 450px">글제목</th>
					<th style="width: 150px">작성자</th>
							<th style="width: 150px">지역</th>
					<th style="width: 150px">작성일</th>
				
					<th style="width: 150px">조회수</th>
					
					
				</tr>
				</thead>
						<tbody id="fundTable">
			</tbody>
	</table>
	<button onclick="location.href='./fundWrite'" id="write">글 작성</button>
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
var menuName = {'구조후기':'saveMain', '모금':'fundMain'};

$(document).ready(function() {
	/* 
	if('${sessionScope.loginId}'==""){
		alert("로그인이 필요한 서비스입니다.");
		location.href="loginPage";} */
		//else{
		fundlistCall(showPageNum);
	//}
		var content = "";
		for ( var key in menuName) {
			console.log(key);
			content += "<div class='menuName'";
			content += "style='"
			if (key == '모금') {
				content += "background:#28977B;color:white;font-weight: 600;";
			}
			content += "cursor: pointer'";
			content += "onclick='pageMove(this)' id=" + menuName[key] + ">";
			content += key;
			content += "</div>";
		}
		;

		$("#sideMenu").empty();
		$("#sideMenu").append(content);
});

function pageMove(e) {
	console.log($(e).attr("id"));
	location.href="./"+$(e).attr("id");
};

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
		/* 	showPageNum=data.currPage;  //보여지는 페이지 = 현재 페이지 (data.currPage) */

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
		 content += "<td><a href='funddetail?idx="+item.board_idx+"&call=detail'>"+ item.board_title +"</a></td>";
		content += "<td>" + item.board_writer+ "</td>";
		content += "<td>" + item.fund_area +"</td>";
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