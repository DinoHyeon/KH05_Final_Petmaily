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

#sideFrame{
	position: absolute;
	left: 0.52%;
	top: 12.4%;
	width: 15%;
	height: 87%;
	background: black;
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
        top: 9.8%;
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

table{
    position: absolute;
    left: 10%;
    top: 55%;
    text-align: center;
    width: 80.2%;
    height: 6%;
}

table,td,tr{
	border: 1px solid black;
	border-collapse: collapse;
}
</style>
</head>
<body>
	<jsp:include page="mainFrame.jsp" />
	<div id="sideFrame"></div>
	<div id="contentFrame">
		<div id="noticeNo">[ ${dto.noticeNo} ]</div>
		<div id="imgDiv">
			<img id="img" src="${dto.popfile}">
		</div>
		<table>
			<tr>
				<th colspan="2">${dto.processState}</th>
				<td colspan="2"><span id="remainderDate"></span> 일 후 입양가능</td>
			</tr>
			<tr>
				<td colspan="4">${dto.kindCd}/${dto.sexCd} / ${dto.colorCd} / ${dto.age} / ${dto.weight}</td>
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
	</div>
</body>
<script>
$(document).ready(function() {
	remainderDate();
});

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
	
	$("#remainderDate").html(btDay);
}
</script>
</html>