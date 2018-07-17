<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<link rel="stylesheet" href="resources/plugIn/jquery-ui.css">
<link rel="stylesheet" href="resources/plugIn/jquery-ui.theme.css">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="resources/plugIn/jquery-ui.js"></script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">

#animal {
	position: absolute;
	left: 50%;
}

#contentFrame {
	position: absolute;
	left: 0.8%;
	top: 12.9%;
	width: 98%;
	height: 100%;
	background: white;
}

#quizPlaySetting {
	position: absolute;
	width: 100%;
	height: 100%;
}

#animalChoice {
	position: absolute;
	left: 15%;
	top: 8%;
	width: 70%;
	height: 34%;
}

#AnimalSleDog {
	position: absolute;
	left: 9%;
	top: 67%;
}

#AnimalSleCat {
	position: absolute;
	left: 34%;
	top: 67%;
}

#AnimalSleEtc {
	position: absolute;
	left: 60%;
	top: 67%;
}

#AnimalSleAll {
	position: absolute;
	left: 85%;
	top: 67%;
}

.animal {
	float: left;
	width: 25%;
	height: 100%;
}

.animalImg {
	position: absolute;
	width: 17%;
	height: 70%;
	margin-left: 3%;
	margin-top: 0.5%;
}

.animalName {
	position: absolute;
	margin-top: 17%;
	margin-left: 9.5%;
	font-weight: 600;
	font-size: 14;
	text-align: center;
}

#categoryChoice{
	position: absolute;
	top : 50%;
	left : 20%;
	
}

#quizNumChoice{
	position: absolute;
	left : 21%;
}

#categoryFieldset {
	border: none;
}

#play{
	position: absolute;
	margin-top: 10%;
	margin-left: 80%;
}

#one{
	margin-top: 250px;
}

#two{
	margin-top: 125px;
}

</style>
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="mainFrame.jsp" />

	<div id="contentFrame">
		<form action="quizPlaySetting" id="quizPlaySetting">

		  <h4>●동물 선택</h4>
			<div id="animalChoice">
				<div class="animal" id="dog">
					<img class="animalImg" id="강아지" alt="강아지"
						src="resources/img/dog.png">
					<div id="AnimalSleDog">
						<label>강아지 <input type="radio" value="강아지" name="animal">
						</label>
					</div>
				</div>
				<div class="animal" id="cat">
					<img class="animalImg" id="고양이" alt="고양이"
						src="resources/img/cat.png">
					<div id="AnimalSleCat">
						<label>고양이 <input type="radio" value="고양이" name="animal">
						</label>
					</div>
				</div>
				<div class="animal" id="etc">
					<img class="animalImg" id="기타" alt="기타"
						src="resources/img/fish.png">
					<div id="AnimalSleEtc">
						<label>기타 <input type="radio" value="기타" name="animal">
						</label>
					</div>
				</div>
				<div class="animal" id="all">
					<img class="animalImg" id="기타" alt="기타"
						src="resources/img/turtle.png">
					<div id="AnimalSleAll">
						<label>전체 <input type="radio" value="전체" name="animal">
						</label>
					</div>
				</div>
			</div>

			<hr id="one">
			 <h4>●Quiz 카테고리</h4>
			<div id="categoryChoice">
				<fieldset id="categoryFieldset">
					<label>전체 <input type="radio" value="전체" name="category">
					</label> <label>음식 <input type="radio" value="음식" name="category">
					</label> <label>습성 <input type="radio" value="습성" name="category">
					</label> <label>생활 <input type="radio" value="생활" name="category">
					</label> <label>건강 <input type="radio" value="건강" name="category">
					</label> <label>기타 <input type="radio" value="기타" name="category">
					</label>
				</fieldset>
			</div>
			
			<hr id="two">
			<h4>●Quiz 갯수</h4>
			<div id="quizNumChoice">
				<label>3 <input type="radio" value="3" name="quizNum">
				</label> <label>5 <input type="radio" value="5" name="quizNum">
				</label> <label>10 <input type="radio" value="10" name="quizNum">
				</label>
			</div>

			<input type="button" id="play" onclick="quizPlay()" value="문제풀기">
		</form>
	</div>
</body>
<script>
	$(document).ready(function() {
		$('input[type="radio"]').checkboxradio({
			icon: false
		});
		$('#categoryFieldset').controlgroup();$
	    $("input[type=submit], button, input[type=button]").click( function( event ) {
	        event.preventDefault();
	    } );
	});

	var animal;
	$(".animalImg").click(function() {
		animal = $(this).attr("id");
	});

	function quizPlay() {
		if(!$("input:radio[name='animal']").is(":checked")){
			alert("퀴즈 동물을 선택해주세요.");
		}else if(!$("input:radio[name='category']").is(":checked")){
			alert("퀴즈 주제를 선택해주세요.");
		}else if(!$("input:radio[name='quizNum']").is(":checked")){
			alert("퀴즈 문제 수를 선택해주세요.");
		}else if(!QuizSettingChk()){
			alert($("input:radio[name='animal']:checked").val()+" - "+ $("input:radio[name='category']:checked").val() + "문제의 수는 "+$("input:radio[name='quizNum']:checked").val()+"개 보다 적습니다. \n빠른 시일 내에 문제를 추가하겠습니다. TT");
		}else{
			$("#quizPlaySetting").submit();
		}
	}
	
	function QuizSettingChk() {
		var success;
		$.ajax({
			type : "get",
			url : "./QuizSettingChk",
			async:false,
			data : {
				"searchAnimal" : $("input:radio[name='animal']:checked").val(),
				"searchCategory" :$("input:radio[name='category']:checked").val(),
				"quiz_num" : $("input:radio[name='quizNum']:checked").val()
			},
			success : function(data) {
				success = data;
				console.log(data);
			},
			error : function(e) {
				console.log(e);
			}
		});
		
		return success;
	}
</script>
</html>