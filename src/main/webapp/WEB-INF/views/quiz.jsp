<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
@import
	url('https://fonts.googleapis.com/css?family=Black+Han+Sans|Jua|Nanum+Gothic')
	;

.ui-dialog .ui-dialog-titlebar-close {
	display: none;
	position: absolute;
	right: .3em;
	top: 50%;
	width: 19px;
	margin: -10px 0 0 0;
	padding: 1px;
	height: 18px;
}

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

fieldset {
	position: absolute;
	border: 8px solid #2478FF;
	border-radius: 5px;
	padding: 15px;
	width: 85%;
	height: 20%;
	top: 5%;
	left: 6%;
	text-align: center;
}

fieldset legend {
	background: #fff;
	color: #38547F;
	padding: 5px 10px;
	font-size: 30px;
	border-radius: 10px;
	box-shadow: 0 0 0 5px #2478FF;
	margin-left: 20px;
}

#ask {
	position: absolute;
	width: 96%;
	height: 53%;
	line-height: 2;
	font-size: 35px;
	font-family: 'Jua', sans-serif;
	color: #38547F;
}

#quizStart {
	position: absolute;
	width: 100;
	height: 100;
	left: 10%;
	top: 30%;
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
	position: absolute;
	border: 8px solid #2478FF;
	border-radius: 5px;
	width: 88%;
	height: 32%;
	top: 39%;
	left: 6%;
	text-align: center;
}

#content {
	position: absolute;
	font-family: 'Nanum Gothic', sans-serif;
	font-size: 25px;
	top: 32%;
	height: 60%;
	width: 100%;
}

#askResult {
	position: absolute;
	font-family: 'Black Han Sans', sans-serif;
	font-size: 30px;
	left: 48%;
	top: 3%;
}

#nextQuizBtn {
	display: none;
	position: absolute;
	top: 83%;
	left: 45%;
}

#answerChkBtn {
	display: none;
	position: absolute;
	top: 83%;
	left: 45%;
}

#askCheck {
	position: absolute;
	display: none;
	float: left;
	top: 43%;
	left: 25%;
	padding: 30px;
	width: 50%;
	height: 20%;
}

.answer {
	font-size: 200px;
	font-family: 'Jua', sans-serif;
	color: #868686;
	padding: 2%;
}

#O {
	position: absolute;
	top: -16%;
	left: 6%;
}

#X {
	position: absolute;
	top: -16%;
	left: 69%;
}

#quizCnt {
	position: absolute;
	top: 27%;
	left: 90.5%;
}

.ui-widget {
	font-size: 25px !important;
}

#quizEnding{
	display: none;
}

</style>
</head>
<body>
	<jsp:include page="mainFrame.jsp" />
	 <div id="sideFrame"></div>
   <jsp:include page="sideMenu.jsp" />
   <div id="contentFrame">
		<div id="dialog-confirm" title="퀴즈 시작 !">
			<p>열심히 풀어주세요 !</p>
		</div>
		<fieldset>
			<legend>
				<b> ${animal} - ${category} </b>
			</legend>
			<div id="ask"></div>
		</fieldset>
		<div id="result">
			<span id="askResult"></span>
			<div id="content"></div>
		</div>
		<div id="askCheck">
			<span class="answer" id="O" style="cursor: pointer">O</span> <span
				class="answer" id="X" style="cursor: pointer">X</span>
		</div>
		<input type="button" id="answerChkBtn" onclick="answerChk()"
			value="정답확인"> <input type="button" id="nextQuizBtn"
			onclick="nextQuiz()" value="다음문제">

		<div id="quizCnt">
			<span id="solveNum"></span> / <span id="reqNum"></span>
		</div>

		<div id="quizEnding" title="퀴즈 결과 발표">
			정답 : <span id="rightNum"></span><br/>
			오답 : <span id="wrongNum"></span>
		</div>
	</div>
</body>
<script>
	var quiz="";
	var quiz_answer;
	var rightNum=0;
	var wrongNum=0;
	var menuName = {'보호소센터 찾기':'searchShelter', '퀴즈':'quizSetting', '질병':'diseaseMain', '커뮤니티':'communityMain'};
	$(document).ready(function() {
		var content = "";
		for(var key in menuName){
			console.log(key);
			content += "<div class='menuName'";
			content += "style='"
			if(key=='퀴즈'){
				content += "background:#28977B;color:white;font-weight: 600;";
			}
			content += "cursor: pointer'";
			content += "onclick='pageMove(this)' id="+menuName[key]+">";
			content += key;
			content += "</div>";
		};	
		
		$("#sideMenu").empty();
		$("#sideMenu").append(content);
		
		
		console.log();
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
	      },
	    });
	    $( "input[type=button]" ).button();

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
		
		$("#solveNum").html(0);
		$("#reqNum").html('${quizNum}');
		
	});
	
	function pageMove(e) {
		console.log($(e).attr("id"));
		location.href="./"+$(e).attr("id");
	};

	//다음 퀴즈
	function nextQuiz() {
		$.ajax({
			"url" : "./nextQuiz",
			"type" : "get",
			"success" : function(data) {
				console.log(data);
				
				$("#nextQuizBtn").css("display","none");
				$("#result").css("display", "none");
				$("#askCheck").css("display","block");
				$('.answer').css("color","#868686");
				$("#answerChkBtn").css("display","none");
				
				quiz = data.quiz;
				$("#askResult").html("");
				$("#content").html("");
				if (!data.quiz) {
					$("fieldset").css("display","none");
					$("#quizCnt").css("display","none");
					$("#askCheck").css("display","none");
					
					$("#rightNum").html(rightNum);
					$("#wrongNum").html(wrongNum);
					
					$( "#quizEnding" ).dialog({
					      resizable: false,
					      height: "auto",
					      width: 400,
					      modal: true,
					      buttons: {
					    	  "퀴즈세팅": function() {
						        	$( this ).dialog( "close" );
						        	location.href="./quizSetting";
						        }
					      },
				    });
				} else {
					$("#ask").html(quiz.quiz_ask);
				}
				
				$("#solveNum").html(data.currQuizNum+1);
			},
			"error" : function(x, o, e) {
				alert(x.status + ":" + o + ":" + e);
			}
		});
	}

	//정답체크
	function answerChk() {
		if(quiz_answer==""){
			alert("정답을 선택해주세요.");
		}else{
			var askResult;
			if(quiz.quiz_answer==quiz_answer){
				askResult = "정답";
				rightNum+=1;
				$("#result").css("border-color","#2EA097");
			}else{
				askResult = "오답";
				wrongNum+=1;
				$("#result").css("border-color","#DE400B");
			}	
			
			$("#answerChkBtn").css("display","none");
			$("#nextQuizBtn").css("display","block");
			$("#result").css("display","block");
			$("#askCheck").css("display","none");
			$("#askResult").html(askResult);
			$("#content").html(quiz.quiz_content);
		}
	}
	
	//정답 클릭
	$(".answer").click(function() {

		quiz_answer = $(this).attr("id");
		$("#answerChkBtn").css("display","block");
		
		if(quiz_answer == 'X'){
			$(this).css( 'color', '#FF003C');
		}else{
			$(this).css( 'color', '#38547F');
		}
		
		$('.answer').not($(this)).css( 'color', '#868686');
		
	})
</script>
</html>