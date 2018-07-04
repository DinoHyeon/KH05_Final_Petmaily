<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<title>Insert title here</title>
<style>
#quizStart {
	position: absolute;
	width: 100;
	height: 100;
	left: 10%; top : 30%;
	background-color: green;
	top: 30%;
}

#StartBnt {
	position: absolute;
	font-size: 20px;
	left: 10%;
	top: 30%;
	font-weight: 600;
	color: black;
}

#result {
	display: none;
}
</style>
</head>
<body>
	<div id="quizStart">
		<input type="button" id="StartBnt" value="퀴즈풀기">
	</div>
	<div id="ask"></div>
	<div id="result">
		<span id="askResult"></span> <span id="content"></span>
	</div>
	<input type="radio" name="answer" value="O">O
	<input type="radio" name="answer" value="X">X
	<input type="button" onclick="answerChk()" value="정답확인">
	<input type="button" onclick="nextQuiz()" value="다음문제">
</body>
<script>
	var quiz;

	$(document).ready(function() {
		//퀴즈 정답, 순서 클리어
		$.ajax({
			"url" : "./cleanQuiz",
			"type" : "get",
			"success" : function(data) {
			},
			"error" : function(x, o, e) {
				alert(x.status + ":" + o + ":" + e);
			}
		});
	});

	$("#StartBnt").click(function() {
		alert("퀴즈 시작!");
		nextQuiz();
	})

	//다음 퀴즈
	function nextQuiz() {
		$.ajax({
			"url" : "./nextQuiz",
			"type" : "get",
			"success" : function(data) {
				$("#result").css("display", "none");
				quiz = data;
				$("#askResult").html("");
				$("#content").html("");
				if (!data) {
					console.log("문제 끝!");
					alert("문제가 끝났습니다!");
				} else {
					$("#ask").html(data.quiz_ask);
				}
			},
			"error" : function(x, o, e) {
				alert(x.status + ":" + o + ":" + e);
			}
		});
	}

	//정답체크
	function answerChk() {
		$.ajax({
			"url" : "./answerChk",
			"type" : "get",
			"data" : {
				"answer" : $("input[name='answer']:checked").val()
			},
			"success" : function(data) {
				$("#result").css("display", "block");
				if (!data) {
					alert("마지막 문제");
				} else {
					$("#askResult").html(data);
					$("#content").html($(quiz)[0].quiz_content);
				}
			},
			"error" : function(x, o, e) {
				alert(x.status + ":" + o + ":" + e);
			}
		});
	}
</script>
</html>