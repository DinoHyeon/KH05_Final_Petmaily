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
<title>Insert title here</title>
<style>
/* 전체(배경) */
#contentFrame {
	position: absolute;
	left: 15.52%;
	top: 12.5%;
	width: 82.95%;
	height: 100%;
	background: white;
}

#sideFrame {
	position: absolute;
	left: 0.52%;
	top: 10.5%;
	width: 15%;
	height: 100%;
	background: black;
}
textarea {
	resize: none;
	width: 100%;
}
table{
	border : 1px solid black;
	border-collapse: collapse;
	width: 70%;
	margin: auto;
	margin-top: 8%;
}
th{
border : 1px solid black;
width: 18%;
background-color: #A9CB73;
}

td{
	padding : 0.5% 0.5%;
}

#td_cont{
	border : 1px solid black;
	text-align: center;
}
#buttonArea{
	margin-top: 3%;
	margin-left : 4%;
	text-align: center;
}
.ui-widget{
    font-size: 16px !important;
}
</style>
</head>
<body>
<jsp:include page="mainFrame.jsp" />
	<div id="sideFrame"></div>
	<div id="contentFrame">
	<table>
		<tr>
			<th>동물</th>
			<td id="td_cont">${dto.animal_idx}</td>
			<th>주제</th>
			<td id="td_cont">${dto.quiz_category}</td>
		</tr>
		<tr>
			<th>문제</th>
			<td colspan="3" id="td_cont"><textarea id="ask" rows="4" cols="" readonly="readonly">${dto.quiz_ask}</textarea></td>
		</tr>
		<tr>
			<th>정답</th>
			<td colspan="3" id="td_cont">
				<div id="quizAnswerDiv">
					<label>
							O<input type="radio" name="answer" value="O">
					</label>
					<label>
							X<input type="radio" name="answer" value="X">
					</label>
				</div>
			</td>
		</tr>
		<tr>
			<th>해설</th>
			<td colspan="3" id="td_cont">
				<textarea id="content" rows="12" cols="" readonly="readonly">${dto.quiz_content}
				</textarea>
			</td>
		</tr>
	</table>
	<div id="buttonArea">
	<button id="updateFormBtn" onclick="location.href='./quizUpdatePage?idx=${dto.quiz_idx}'">수정</button>
	<button id="deleteBtn" onclick="del()">삭제</button>
	<button onclick="location.href='./quizMain'">리스트</button>
	</div>
	</div>
</body>
<script>
	$(document).ready(function() {
		//$("input[name='answer").not('input[value="${dto.quiz_answer}"]').attr("disabled",true);
		$("input[value='${dto.quiz_answer}']").attr("checked",true);
		$("input[name='answer']").attr("disabled",true);
		
		$('input[type="radio"]').checkboxradio({icon: false});
		$( "input[type=submit], button, input[type=button]" ).button();
	});
	
	function del() {
		var del = confirm("해당 문제를 삭제하시겠습니까?");
		
		if(del){
			location.href='./quizDelete?idx=${dto.quiz_idx}'
		}
	}
</script>
</html>