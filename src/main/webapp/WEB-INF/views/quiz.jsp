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
	<div id="dialog-confirm" title="퀴즈 시작 !">
  		<p>
 			열심히 풀어주세요 !
  		</p>
	</div>
	
	<div id="ask"></div>
	<div id="result">
		<span id="askResult"></span> <span id="content"></span>
	</div>
	<input type="radio" name="answer" value="O">O
	<input type="radio" name="answer" value="X">X
	<input type="button" onclick="answerChk()" value="정답확인">
	<input type="button" onclick="nextQuiz()" value="다음문제">
	
	<div id="quizEnding" title="퀴즈 결과 발표">
		<p><span id="quizEndingContent"></span></p>
	</div>
</body>
<script>
	var quiz;
	var rightNum=0;
	var wrongNum=0;
	
	$(document).ready(function() {
		  $( function() {
			  	//dialog plugin적용
			    $( "#dialog-confirm" ).dialog({
			      resizable: false,
			      height: "auto",
			      width: 400,
			      modal: true,
			      buttons: {
			        Start: function() {
			        	$( this ).dialog( "close" );
			        	nextQuiz();
			        }
			      }
			    });
			  } );
		
		//퀴즈 목록 초기화
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
					alert("정답: "+rightNum+" / "+"오답: "+wrongNum);
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
		if(quiz.quiz_answer==$("input[name='answer']:checked").val()){
			console.log("정답");
			rightNum+=1;
			console.log(rightNum);
		}else{
			console.log("오답");
			wrongNum+=1;
			console.log(wrongNum);
		}	
	}
</script>
</html>