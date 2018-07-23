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
<title>퀴즈 수정 페이지</title>
<style>
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
	height: 140%;
	background: black;
}

/* 타이틀 */
#title h1 {
	top: 3%;
	left: 42%;
	margin: 50px 0px 25px 0px;
	text-align: center;
	color: #A9CB73;
	font-weight: 700;
	font-size: 40;
	position: absolute;
}

#title h5 {
	top: 26%;
	left: 64%;
	margin: 10px 0px 40px 0px;
	text-align: right;
	color: gray;
	font-weight: 700;
	font-size: 15;
	position: absolute;
}

#quiz textarea {
	width: 100%;
	resize: none;
	margin: 0;
	border: none;
}

#quiz table {
	border: 2px solid lightgray;
	border-collapse: collapse;
	top: 18%;
	left: 12%;
	width: 70%;
	margin: auto;
	margin-top: 8%;
	position: absolute;
}

#quiz th {
	border: 2px solid lightgray;
	border-collapse: collapse;
	padding: 5px 10px;
	background-color: #A9CB73;
	color: white;
}

#quiz td {
	text-align: center;
	border: 2px solid lightgray;
	border-collapse: collapse;
	padding: 2px 2px;
	margin: 0px;
}

#td_cont {
	text-align: center;
}

#buttonArea {
	left: 41%;
	top: 75%;
	margin-top: 3%;
	margin-left: 4%;
	text-align: center;
	position: absolute;
}
</style>
</head>
<body>
	<jsp:include page="mainFrame.jsp" />
	<div id="sideFrame"></div>
	<div id="contentFrame">
		<div id="quiz">
			<div id=title>
				<h1>퀴즈 수정</h1>
				<h5>등록된 퀴즈의 정보를 수정합니다</h5>
			</div>
			<table>
				<form id="update" action="quizUpdate">
					<tr>
						<th style="width:15%">동물</th>
						<td style="width:35%"><select id="aniamlList" name="aniamlList">
								<option value="강아지">강아지</option>
								<option value="고양이">고양이</option>
								<option value="기타">기타</option>
						</select></td>
						<th style="width:15%">주제</th>
						<td style="width:35%"><select id="category" name="category">
								<option value="건강">건강</option>
								<option value="음식">음식</option>
								<option value="습성">습성</option>
								<option value="생활">생활</option>
								<option value="기타">기타</option>
						</select></td>
					</tr>
					<tr>
						<th>문제</th>
						<td colspan="3"><input type="hidden" name="quiz_idx"
							value="${dto.quiz_idx}"> <textarea id="ask" name="ask"
								rows="4" cols="">${dto.quiz_ask}</textarea></td>
					</tr>
					<tr>
						<th>정답</th>
						<td colspan="3">
							<div id="quizAnswerDiv">
								<label> O<input type="radio" name="answer" value="O">
								</label> <label> X<input type="radio" name="answer" value="X">
								</label>
							</div>
						</td>
					</tr>
					<tr>
						<th>해설</th>
						<td colspan="3"><textarea id="content" name="content"
								rows="12" cols="">${dto.quiz_content}</textarea></td>
					</tr>
				</form>
			</table>
		</div>
		<div id="buttonArea">
			<input type="button" onclick="update()" id="updateBtn" value="저장">
			<input type="button"
				onclick="location.href='./quizDetailPage?idx=${dto.quiz_idx}'"
				value="취소">
		</div>
	</div>
</body>
<script>
	$(document).ready(function() {
		$("input[value='${dto.quiz_answer}']").attr("checked", true);
		selectBoxChk($("#aniamlList"),"${dto.animal_idx}");
		selectBoxChk($("#category"),"${dto.quiz_category}");
		
		$( "#category" ).selectmenu();
		$( "#aniamlList" ).selectmenu();
		$('input[type="radio"]').checkboxradio({icon: false});
		$( "input[type=submit], button, input[type=button]" ).button();
	});
	
	function update() {
		if($("#ask").val()==""){
			alert("퀴즈를 입력해주세요.");
		}else if($("#content").val()==""){
			alert("퀴즈 해설을 입력해주세요.");
		}else{
			$("#update").submit();	
		}		
	}
	
	function selectBoxChk(selectBox,data) {
		selectBox.find("option").each(function(index){
			if( $(this).val() == data ){
				selectBox.val(data).prop("selected", true);
			}
		});
	}

</script>
</html>