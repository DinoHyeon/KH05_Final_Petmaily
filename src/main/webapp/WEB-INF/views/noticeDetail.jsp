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
	height: 87%;
	background: white;
}

#sideFrame {
	position: absolute;
	left: 0.52%;
	top: 12.4%;
	width: 14.7%;
	height: 130%;
	border-right: 1px solid gray;
	border-left: 1px solid gray;
}

#noticeNo{
	text-align: center;
    position: absolute;
    width: 80%;
    height: 45%;
    top: 3%;
    left: 10%;
    font-size: 20px;
    font-weight: 600;
    color: #02886F;
}

#imgDiv{
    position: absolute;
    left: 10%;
    top: 8.8%;
    border: 1px solid black;
    text-align: center;
    width: 80%;
    height: 45%;
}

#img{
  display: inline-block;
  vertical-align: middle;
  max-height: 100%;
  max-width: 100%;
}

#animal{
    position: absolute;
    left: 10%;
    top: 54%;
    text-align: center;
    width: 80.2%;
    height: 6%;
}

#noticeText{
	position: absolute;
    left: 10%;
    top: 76%;
    text-align: center;
    width: 80.2%;
}

#animalShelter{
    position: absolute;
    left: 10%;
    top: 80%;
    text-align: center;
    width: 80.2%;
    height: 6%;
}

table,td,tr{
	border: 1px solid black;
	border-collapse: collapse;
}

.ui-widget{
	font-size: 15px !important;
	font-weight: 600 !important;
}

#listBtn{
	position: absolute;
	left: 84%;
	top: 93%;
}
</style>
</head>
<body>
	<jsp:include page="mainFrame.jsp" />
	<div id="sideFrame"></div>
	<jsp:include page="sideMenu.jsp" />
	<div id="contentFrame">
		<div id="noticeNo">[ ${dto.noticeNo} ]</div>
		<div id="imgDiv">
			<img id="img" src="${dto.popfile}">
		</div>
		<table id="animal">
			<tr>
				<th colspan="2">${dto.processState}</th>
				<td colspan="2"><span id="remainderDate"></span></td>
			</tr>
			<tr>
				<td colspan="4">${dto.kindCd}/ <span id="gender"></span> / ${dto.colorCd} / ${dto.age} / ${dto.weight}</td>
			</tr>
			<tr>
				<th>공고번호</th>
				<td>${dto.noticeNo}</td>
				<th>공고기간</th>
				<td>${dto.noticeSdt} ~ ${dto.noticeEdt}</td>
			</tr>
			<tr>
				<th>발견 장소</th>
				<td colspan="3">${dto.happenPlace}</td>
			</tr>
			<tr>
				<th>특이 사항</th>
				<td colspan="3">${dto.speciaMark}</td>
			</tr>
		</table>
		<div id="noticeText">※ 유기동물 문의는 보호센터에 연락하시기 바랍니다.</div>
		<table id="animalShelter">
			<tr>
				<th>보호센터</th>
				<td colspan="2">${dto.careNm}</td>
				<th>전화 번호</th>
				<td colspan="2">${dto.careTel}</td>		
			</tr>
			<tr>
				<th>보호센터 위치</th>
				<td colspan="5">${dto.careAddr}</td>	
			</tr>
			<tr>
				<th>관할기관 </th>
				<td>${dto.orgNm}</td>
				<th>담당자</th>
				<td>${dto.chargeNm}</td>
				<th>연락처</th>
				<td>${dto.officetel}</td>			
			</tr>
		</table>
		
		<div id="listBtn">
			<button>리스트</button>
		</div>
	</div>
</body>
<script>
var menuName = {'유기동물공고':'animalNotice', '입양후기':'adoptMain'};
$(document).ready(function() {
	var content = "";
	for(var key in menuName){
		console.log(key);
		content += "<div class='menuName'";
		content += "style='"
		if(key=='유기동물공고'){
			content += "background:#28977B;color:white;font-weight: 600;";
		}
		content += "cursor: pointer'";
		content += "onclick='pageMove(this)' id="+menuName[key]+">";
		content += key;
		content += "</div>";
	};	
	
	$("#sideMenu").empty();
	$("#sideMenu").append(content);
	
	if("${dto.processState}"== "보호중" || "${dto.processState}" == "공고중"){
		remainderDate();
	}
	
	$( "button" ).button();
	if("${dto.sexCd}" == "M"){
		$("#gender").html("수컷");
	}else if("${dto.sexCd}" == "F"){
		$("#gender").html("암컷");
	}else{
		$("#gender").html("알 수 없음");
	}
});

function pageMove(e) {
	console.log($(e).attr("id"));
	location.href="./"+$(e).attr("id");
};


function remainderDate() {
	var endDate = "${dto.noticeEdt}";
	
	console.log(endDate);
	var end_year = endDate.substring(0,4);
	var end_month = endDate.substring(4,6);
	var end_day = endDate.substring(6,8);
	
	var nowDate = new Date();
	var today_year = nowDate.getFullYear();
	var today_month = nowDate.getMonth()+1;
	var today_day = nowDate.getDate();
	
	var today = new Date(today_year,today_month,today_day);
	var endday = new Date(end_year, end_month, end_day);
	
	var btMs = endday.getTime() - today.getTime() ;
	var btDay = Math.floor(btMs / (1000 * 60 * 60 * 24));
	
	if(btDay < 1){
		$("#remainderDate").html("현재 입양가능");
	}else{
		$("#remainderDate").html(btDay+" 일 후 입양가능");
	}
	
	
}

$( "button" ).click( function( event ) {
	location.href="./animalNotice";
} );
</script>
</html>