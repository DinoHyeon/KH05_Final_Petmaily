<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
/* 전체(배경) */
#contentFrame {
	position: absolute;
	left: 15.52%;
	top: 12.5%;
	width: 82.95%;
	height: 140%;
	background: white;
}

#sideFrame{
	position: absolute;
	left: 0.52%;
	top: 12.4%;
	width: 15%;
	height: 140%;
	background: black;
}

#searchTable{
	position: absolute;
    width: 78%;
    height: 17%;
    top: 2%;
    left: 11%;
    border: 1px solid black;
    border-collapse: collapse;
}

table,td,tr{
	border: 1px solid black;
	border-collapse: collapse;
	text-align: center;
}

#searchTable th{
	width: 10%;
	background-color: #02886F;
	color: white;
}

#date{
	font-weight: 450;
}

.overflow{
	height: 150px;
}

#clearBtn{
	position: absolute;
    left: 55%;
    top: 20.5%;
    width: 20% !important;
    height: 3% !important;
    font-weight: 600 !important;
}

#searchBtn{
	position: absolute;
    left: 28%;
    top: 20.5%;
    width: 20% !important;
    height: 3% !important;
    font-weight: 600 !important;
}

#list{
    position: absolute;
    left: 4.9%;
    top: 26%;
    width: 90%;
    height: 60%;
}

#paging{
	position: absolute;
	left: 37%;
	top: 89%;
}

.animalTable{
	float: left;
	width: 23%;
	height: 48%;
	margin: 1% 1%;
	font-size: 12px;
}

.animalTable th{
	 width: 10%;
	 background-color: #02886F;
}

</style>
</head>
<body>
	<jsp:include page="mainFrame.jsp" />
	<div id="sideFrame"></div>
	<div id="contentFrame">
		<table id="searchTable">
			<tr>
				<th>날짜</th>
				<td colspan="5" id="date">
					<select id="start_year"></select>년
					<select id="start_month"></select>월
					<select id="start_day"><option value=''>선택</option></select>일 ~ 
					<select id="end_year"></select>년
					<select id="end_month"></select>월
					<select id="end_day"><option value=''>선택</option></select>일
				</td>
			</tr>
			<tr>
				<th>시/도</th>
				<td>
					<select id="sido">
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
				</td>
				<th>시/구/군</th>
				<td>
					<select id="sigundo">
						<option value="">선택</option>
					</select>
				</td>
				<th>보호센터</th>
				<td>
					<select id="shelter">
						<option value="">선택</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>축종</th>
				<td colspan="3">
					<select id="animal">
						<option value="">선택</option>
						<option value="417000">개</option>
						<option value="422400">고양이</option>
						<option value="429900">기타</option>
					</select>
					<select id="animalType">
						<option value="">선택</option>
					</select>					
				</td>
				<th>상태</th>
				<td>
					<select id="statement">
						<option value="">전체</option>
						<option value="notice">공고중</option>
						<option value="protect">보호중</option>
					</select>
				</td>
			</tr>
		</table>
		
		<button id="clearBtn">초기화</button>
		<button id="searchBtn">검색</button>

		<div id="list">
			
		</div>
		<div id="paging"></div>
	</div>
	
</body>
<script>
var showPageNum = 1;

$(document).ready(function() {
	getYear();
	getMonth();
	$( "#start_year" ).selectmenu({width: 100});
	$( "#start_month" ).selectmenu({
		width: 80,
		change: function( event, ui ) {
			getStart_day(event.target);
		}
	}).selectmenu( "menuWidget" ).addClass( "overflow" );
	$( "#start_day" ).selectmenu({width: 80}).selectmenu( "menuWidget" ).addClass( "overflow" );
	$( "#end_year" ).selectmenu({width: 100});
	$( "#end_month" ).selectmenu({
		width: 80,
		change: function( event, ui ) {
			getEnd_day(event.target);
		}
	}).selectmenu( "menuWidget" ).addClass( "overflow" );
	$( "#end_day" ).selectmenu({width: 80}).selectmenu( "menuWidget" ).addClass( "overflow" );
	
	$( "#sido" ).selectmenu({
		width: 160,
		change: function( event, ui ) {
			getSigungu();
		}
	}).selectmenu( "menuWidget" ).addClass( "overflow" );
	
	$( "#sigundo" ).selectmenu({
		width: 120,
		change: function( event, ui ) {
			getShelter();
		}
	}).selectmenu( "menuWidget" ).addClass( "overflow" );
	
	$( "#shelter" ).selectmenu({width: 200}).selectmenu( "menuWidget" ).addClass( "overflow" );
	
	$( "#animal" ).selectmenu({
		width: 100,
		change: function( event, ui ) {
			getAnimalType();
		}
	});
	
	$( "#animalType" ).selectmenu({width: 210}).selectmenu( "menuWidget" ).addClass( "overflow" );
	
	$( "#statement" ).selectmenu({width: 100});
	
	$( "button" ).button();
	
	noticeList(showPageNum);
});	

function getYear() {
	var date = new Date();
	var year = date.getFullYear();
	var content = "";
	
	content += "<option value=''>선택</option>";
	for(var i=year; i>=year-2; i--){
		content += "<option value="+i+">"+i+"</option>"; 
	}
	
	$("#start_year").empty();
	$("#start_year").append(content);
	
	$("#end_year").empty();
	$("#end_year").append(content);
	
	content = "";
}

function getMonth() {
	$("#start_month").empty();
	$("#end_month").empty();
	
	var content = "";
	
	content += "<option value=''>선택</option>"; 
	for(var i=1; i<=12; i++){
		if(i<10){
			content += "<option value=0"+i+">0"+i+"</option>"; 
		}else{
			content += "<option value="+i+">"+i+"</option>"; 
		}
	}
	
	$("#start_month").append(content);
	$("#end_month").append(content);
	
	content = "";
}

function getStart_day(e) {
	var month = $(e).val();
	var end_day;
	
	if(month%2==0){
		if(month==2){
			end_day = 28;
		}else{
			end_day = 30;
		}
	}else{
		end_day = 31;
	}
	
	var content = "";
	
	for(var i=1; end_day>=i; i++){
		if(i<10){
			content += "<option value=0"+i+">0"+i+"</option>"; 
		}else{
			content += "<option value="+i+">"+i+"</option>"; 
		}
	}
	
	$("#start_day").empty();
	$("#start_day").append(content);
	
	$( "#start_day" ).selectmenu( "refresh" );
	
	content = "";
}

function getEnd_day(e) {
	var month = $(e).val();
	var end_day;
	
	if(month%2==0){
		if(month==2){
			end_day = 28;
		}else{
			end_day = 30;
		}
	}else{
		end_day = 31;
	}
	
	var content = "";
	
	for(var i=1; end_day>=i; i++){
		content += "<option value="+i+">"+i+"</option>"; 
	}
	
	$("#end_day").empty();
	$("#end_day").append(content);
	
	console.log(content);
	
	$("#end_day").selectmenu("refresh");
	
	content = "";
}

function getSigungu() {
	console.log($("#sido").val())
	$.ajax({
		"url" : "./getSigungu",
		"type" : "get",
		"data" : {"sidoCode" : $("#sido").val()},
		"success" : function(data) {
			console.log(data);
			var content = "";
			content += "<option value=''>선택</option>"; 
			data.forEach(function(item) {
				content += "<option value="+item.sigundoCode+">";
				content += item.sigundoName;
				content += "</option>";
			})
			$("#sigundo").empty();
			$("#sigundo").append(content);
			
			$( "#sigundo" ).selectmenu( "refresh" );
		},
		"error" : function(x, o, e) {
			alert(x.status + ":" + o + ":" + e);
		}
	});
}

function getAnimalType() {
	$.ajax({
		"url" : "./getAnimalType",
		"type" : "get",
		"data" : {"animalCode" : $("#animal").val()},
		"success" : function(data) {
			console.log(data);
			var content = "";
			content += "<option value=''>선택</option>"; 
			data.forEach(function(item) {
				content += "<option value="+item.animalCode+">";
				content += item.animalType;
				content += "</option>";
			})
			$("#animalType").empty();
			$("#animalType").append(content);
			
			$( "#animalType" ).selectmenu( "refresh" );
		},
		"error" : function(x, o, e) {
			alert(x.status + ":" + o + ":" + e);
		}
	});
}

function getShelter() {
	$.ajax({
		"url" : "./getShelter",
		"type" : "get",
		"data" : {
			"sidoCode" : $("#sido").val(),
			"sigundoCode" : $("#sigundo").val()
			},
		"success" : function(data) {
			console.log(data);
			var content = "";
			content += "<option value=''>선택</option>"; 
			data.forEach(function(item) {
				content += "<option value="+item.shelterCode+">";
				content += item.shelterName;
				content += "</option>";
			})
			$("#shelter").empty();
			$("#shelter").append(content);
			
			$( "#shelter" ).selectmenu( "refresh" );
		},
		"error" : function(x, o, e) {
			alert(x.status + ":" + o + ":" + e);
		}
	});
}

$( "#clearBtn" ).click( function( event ) {
	console.log("삭제");
} );

$( "#searchBtn" ).click( function( event ) {
	console.log("검색");
	noticeList(showPageNum);
} );
  
function noticeList(page) {
	$.ajax({
		"url" : "./noticeList",
		"type" : "get",
		"data" : {
			"showPageNum":page,
			"start_date":$("#start_year").val()+$("#start_month").val()+$("#start_day").val(),
			"end_date":$("#end_year").val()+$("#end_month").val()+$("#end_day").val(),
			"sido":$("#sido").val(),
			"sigundo":$("#sigundo").val(),
			"shelter":$("#shelter").val(),
			"animal":$("#animal").val(),
			"animalType":$("#animalType").val(),
			"statement":$("#statement").val()
			},
		"success" : function(data) {
			listPrint(data);
			console.log(data);
		},
		"error" : function(x, o, e) {
			alert(x.status + ":" + o + ":" + e);
		}
	});
}

function listPrint(data) {
	var content = "";
	data.list.forEach(function(item) {
		content+="<table class='animalTable'>";
		content+="<tr>";
		content+="<td colspan='2' class='image'><a href='./noticeDetail?idx="+item.noticeNo+"'><img width='255' height='200' src='"+item.popfile+"'></a></td>";
		content+="</tr>";
		content+="<tr>";
		content+="<th>품종</th>";
		content+="<td>"+item.kindCd+"</td>";
		content+="</tr>";
		content+="</tr>";
		content+="<th>등록일</th>";
		content+="<td>"+item.happenDt+"</td>";
		content+="</tr>";
		content+="</tr>";
		content+="<th>구조장소</th>";
		content+="<td>"+item.happenPlace+"</td>";
		content+="</tr>";
		content+="</table>";
	})	
	
	$("#list").empty();
	$("#list").append(content);

	
	$("#paging").zer0boxPaging({
        viewRange : 5,
        currPage : data.currPage,
        maxPage : data.pageCnt,
        clickAction : function(e){
        	noticeList($(this).attr('page'));
        }
    });
}
</script>
</html>