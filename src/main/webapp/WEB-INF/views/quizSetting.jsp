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
#contentFrame {
	position: absolute;
	left: 15.52%;
	top: 12.5%;
	width: 82.95%;
	height: 95%;
}

#sideFrame {
	position: absolute;
	left: 0.52%;
	top: 12.4%;
	width: 14.8%;
	height: 106%;
	border-right: 1px solid gray;
	border-left: 1px solid gray;
}

/* 타이틀 */
/* 첫번째 타이틀 */
#title1 h1 {
	top: 3%;
	left: 34%;
	margin: 50px 0px 25px 0px;
	text-align: center;
	color: #A9CB73;
	font-weight: 700;
	font-size: 40;
	position: absolute;
}

#title1 h5 {
	top: 12%;
	left: 55%;
	margin: 10px 0px 40px 0px;
	text-align: right;
	color: gray;
	font-weight: 700;
	font-size: 15;
	position: absolute;
}
/* 두번째 타이틀 */
#title2 h1 {
	top: 43%;
	left: 34%;
	margin: 50px 0px 25px 0px;
	text-align: center;
	color: #A9CB73;
	font-weight: 700;
	font-size: 40;
	position: absolute;
}

#title2 h5 {
	top: 52%;
	left: 55%;
	margin: 10px 0px 40px 0px;
	text-align: right;
	color: gray;
	font-weight: 700;
	font-size: 15;
	position: absolute;
}
/* 세번째 타이틀 */
#title3 h1 {
	top: 73%;
	left: 32%;
	margin: 50px 0px 25px 0px;
	text-align: center;
	color: #A9CB73;
	font-weight: 700;
	font-size: 40;
	position: absolute;
}

#title3 h5 {
	top: 82%;
	left: 55%;
	margin: 10px 0px 40px 0px;
	text-align: right;
	color: gray;
	font-weight: 700;
	font-size: 15;
	position: absolute;
}

#animal {
	position: absolute;
	left: 50%;
}

#quizPlaySetting {
	position: absolute;
	width: 100%;
	height: 100%;
}

#animalChoice {
	position: absolute;
	left: 6.5%;
	top: 20%;
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

#categoryChoice {
	position: absolute;
	top: 64%;
	left: 28%;
}

#quizNumChoice {
	position: absolute;
	top: 93%;
	left: 36%;
}

#categoryFieldset {
	border: none;
}

/* 문제풀기! 버튼 스타일 */
#play {
	position: absolute;
	top: 100%;
	left: 34.5%;
	height: 60px;
	width: 180px;
	font-weight: 800;
	font-size: 16;
	text-align: center;
	border: 2.5px solid white;
	background-color: #A9CB73;
	color: white;
	cursor: pointer;
}

#knowledge {
	position: absolute;
	z-index: 50;
	top: 2%;
	left: 88.5%;
	height: 60px;
	width: 180px;
	font-weight: 800;
	font-size: 16;
	text-align: center;
	border: 2.5px solid white;
	background-color: #A9CB73;
	color: white;
	cursor: pointer;
}

#one {
	margin-top: 28%;
}

#two {
	margin-top: 16%;
}
</style>
<title>퀴즈 풀기 페이지</title>
</head>
<body>
	<jsp:include page="mainFrame.jsp" />
	<div id="sideFrame"></div>
	<jsp:include page="sideMenu.jsp" />
	<div id="contentFrame">
		<input type="button" id="knowledge" onclick="knowledgePage()"
			value="퀴즈 리스트">

		<form action="quizPlaySetting" id="quizPlaySetting">

			<div id=title1>
				<h1>동물 선택</h1>
				<h5>동물의 종류를 선택합니다</h5>
			</div>

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
			<div id=title2>
				<h1>주제 선택</h1>
				<h5>퀴즈의 주제를 선택 합니다</h5>
			</div>
			<div id="categoryChoice">
				<fieldset id="categoryFieldset" style="height: 40px">
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
			<div id=title3>
				<h1>문제 수 선택</h1>
				<h5>풀이할 퀴즈의 숫자를 선택합니다</h5>
			</div>
			<div id="quizNumChoice">
				<label>3 <input type="radio" value="3" name="quizNum">
				</label> <label>5 <input type="radio" value="5" name="quizNum">
				</label> <label>10 <input type="radio" value="10" name="quizNum">
				</label>
			</div>

			<input type="button" id="play" onclick="quizPlay()" value="퀴즈  시작">
		</form>
	</div>
</body>
<script>
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
		
		
		
		$('input[type="radio"]').checkboxradio({
			icon: false
		});
		$('#categoryFieldset').controlgroup();$
	    $("input[type=submit], button, input[type=button]").click( function( event ) {
	        event.preventDefault();
	    } );
	});
	
	function knowledgePage() {
		location.href="./knowledge";
	}
	
	function pageMove(e) {
		console.log($(e).attr("id"));
		location.href="./"+$(e).attr("id");
	};

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