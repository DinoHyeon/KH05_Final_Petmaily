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
<title>퀴즈 상세보기 페이지</title>
<style>
/* 전체(배경) */
#contentFrame {
	position: absolute;
	left: 15.52%;
	top: 12.5%;
	width: 82.95%;
	height: 95%;
	background: white;
}

#sideFrame {
	position: absolute;
	left: 0.52%;
	top: 12.4%;
	width: 14.7%;
	height: 150%;
	border-right: 1px solid gray;
	border-left: 1px solid gray;
}

/* 타이틀 */
#title h1 {
	top: 3%;
	left: 38%;
	margin: 50px 0px 25px 0px;
	text-align: center;
	color: #A9CB73;
	font-weight: 700;
	font-size: 40;
	position: absolute;
}

#title h5 {
	top: 26%;
	left: 62%;
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
	left: 35%;
	top: 75%;
	margin-top: 3%;
	margin-left: 4%;
	text-align: center;
	position: absolute;
}

.ui-widget {
	font-size: 16px !important;
}
</style>
</head>
<body>
	<jsp:include page="mainFrame.jsp" />
	<div id="sideFrame"></div>
	<jsp:include page="sideMenu.jsp" />
	<div id="contentFrame">
		<div id="quiz">
			<div id=title>
				<h1>퀴즈 상세보기</h1>
				<h5>등록된 퀴즈의 상세 정보를 확인합니다</h5>
			</div>
			<table>
				<tr>
					<th style="width: 15%">동물</th>
					<td id="td_cont" style="font-weight: 600; width: 35%;">${dto.animal_idx}</td>
					<th style="width: 15%">주제</th>
					<td id="td_cont" style="font-weight: 600; width: 35%;">${dto.quiz_category}</td>
				</tr>
				<tr>
					<th>문제</th>
					<td colspan="3" id="td_cont"><textarea id="ask" rows="4"
							cols="" readonly="readonly">${dto.quiz_ask}</textarea></td>
				</tr>
				<tr>
					<th>정답</th>
					<td colspan="3" id="td_cont">
						<div id="quizAnswerDiv" style="text-align: left">
							<label> O<input type="radio" name="answer" value="O">
							</label> <label> X<input type="radio" name="answer" value="X">
							</label>
						</div>
					</td>
				</tr>
				<tr>
					<th>해설</th>
					<td colspan="3" id="td_cont"><textarea id="content" rows="12"
							cols="" readonly="readonly">${dto.quiz_content}
				</textarea></td>
				</tr>
			</table>
			<div id="buttonArea">
				<button id="updateFormBtn"
					onclick="location.href='./quizUpdatePage?idx=${dto.quiz_idx}'">수정</button>
				<button id="deleteBtn" onclick="del()">삭제</button>
				<button onclick="location.href='./quizMain'">리스트</button>
			</div>
		</div>
	</div>
	<script>
		var menuName = {
			'보호소센터 찾기' : 'searchShelter',
			'퀴즈' : 'quizSetting',
			'질병' : 'diseaseMain',
			'커뮤니티' : 'communityMain'
		};

		$(document)
				.ready(
						function() {
							var content = "";
							for ( var key in menuName) {
								console.log(key);
								content += "<div class='menuName'";
								content += "style='"
								if (key == '퀴즈') {
									content += "background:#28977B;color:white;font-weight: 600;";
								}
								content += "cursor: pointer'";
								content += "onclick='pageMove(this)' id="
										+ menuName[key] + ">";
								content += key;
								content += "</div>";
							}
							;

							$("#sideMenu").empty();
							$("#sideMenu").append(content);

							//$("input[name='answer").not('input[value="${dto.quiz_answer}"]').attr("disabled",true);
							$("input[value='${dto.quiz_answer}']").attr(
									"checked", true);
							$("input[name='answer']").attr("disabled", true);

							$('input[type="radio"]').checkboxradio({
								icon : false
							});
							$("input[type=submit], button, input[type=button]")
									.button();
						});

		function pageMove(e) {
			console.log($(e).attr("id"));
			location.href = "./" + $(e).attr("id");
		};

		function del() {
			var del = confirm("해당 문제를 삭제하시겠습니까?");

			if (del) {
				location.href = './quizDelete?idx=${dto.quiz_idx}'
			}
		}
	</script>
</html>