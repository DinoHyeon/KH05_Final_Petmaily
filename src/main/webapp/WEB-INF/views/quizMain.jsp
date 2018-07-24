<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>퀴즈 페이지</title>
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

/* 첫번째 타이틀 */
#title1 h1 {
	top: 3%;
	left: 44%;
	margin: 50px 0px 25px 0px;
	text-align: center;
	color: #A9CB73;
	font-weight: 700;
	font-size: 40;
	position: absolute;
}
#title1 h5 {
	top: 22%;
	left: 64%;
	margin: 10px 0px 40px 0px;
	text-align: right;
	color: gray;
	font-weight: 700;
	font-size: 15;
	position: absolute;
}

/* 두번째 타이틀 */
#title2 h1 {
	top: 90%;
	left: 44%;
	margin: 50px 0px 25px 0px;
	text-align: center;
	color: #A9CB73;
	font-weight: 700;
	font-size: 40;
	position: absolute;
}
#title2 h5 {
	top: 102%;
	left: 74%;
	margin: 10px 0px 40px 0px;
	text-align: right;
	color: gray;
	font-weight: 700;
	font-size: 15;
	position: absolute;
}

/* selectBox(동물종/카테고리) */
#registSelectBox{
	position: absolute;
	top : 31.5%;
	left : 20%;
}


/* 정답 div */
#registAnswerRadio{
	position: absolute;
	top : 81%;
	left : 20%;
}

/* 테이블 상단 */
#quizListTable{
	border-top : 1px solid black;
	border-bottom: 1px solid black;
	margin-top : 20px;
	width : 100%;
	padding-top: 3px;
	background-color: #A9CB73;
}

#quizListTable td{
	text-align: center;
	width : 5.4%;
}

textarea {
	resize: none;
}

#noLisd{
	width : 14%;
}

/* 문제작성 */
#quizAsk {
	width: 65%;
	height : 6%;
	border: 1px solid black;
	position: absolute;
	top : 37%;
	left : 20%;
}

/* 문제해설 */
#registQuizContent {
	width: 65%;
	height: 26%;
	border: 1px solid black;
	position: absolute;
	top : 44%;
	left : 20%;
}

/* 버튼(문제등록) */
#registBtn{
	position: absolute;
	top : 74%;
	left : 48%;
}

#qqq{
	margin-left : 15px;
}

/* 리스트 */
#quizList{
	position: absolute;
	top : 110%;
}
/* 페이징 */
#paging{
	position: absolute;
	top : 169%;
	left : 47%;
}

/* selectBox(검색) */
#quizListDiv{
	position: absolute;
	top : 108%;
	left : 17%;
	width: 73%;
}

button{
	width: 10%;
	
}
td{
	border-bottom: 1px solid black;
	padding : 1% 0;
}
.ui-widget{
    font-size: 16px !important;
}

#a{
	margin-top: 55%;
}
border-right: 1px solid gray;
</style>
</head>
<body>
	<jsp:include page="mainFrame.jsp" />
	<div id="sideFrame"></div>
   <jsp:include page="sideMenu.jsp" />
   <div id="contentFrame">
	
	<div id="contentFrame">
			<div id=title1>
				<h1>퀴즈 등록</h1>
				<h5>임의의 동물과 주제로 퀴즈를 등록합니다</h5>
			</div>
		<div id="registSelectBox">
			<select id="aniamlList">
				<option value="동물">동물 선택</option>
				<option value="강아지">강아지</option>
				<option value="고양이">고양이</option>
				<option value="기타">기타</option>
			</select>
			<select id="category">
				<option value="카테고리">카테고리 선택</option>
				<option value="건강">건강</option>
				<option value="음식">음식</option>
				<option value="습성">습성</option>
				<option value="생활">생활</option>
				<option value="기타">기타</option>
			</select>
		</div>
		<textarea id="quizAsk" rows="" cols="" placeholder="퀴즈 제목 작성"></textarea>
		<div id="registAnswerRadio">
			<label>
				O<input type="radio" name="answer" value="O">
			</label>
			<label>
				X<input type="radio" name="answer" value="X">
			</label>
		</div>
		<textarea id="registQuizContent" rows="" cols="" placeholder="퀴즈 해설 작성"></textarea>
		<div id="registBtn">
		<input type="button" onclick="registQuiz()" value="문제 등록">
		</div>
		<hr id="a">
		<div id=title2>
			<h1>퀴즈 목록</h1>
			<h5>등록된 퀴즈들의 목록입니다</h5>
		</div>
		<div id="quizListDiv">
			<select id="searchAniamlList">
				<option value="전체">전체</option>
				<option value="강아지">강아지</option>
				<option value="고양이">고양이</option>
				<option value="기타">기타</option>
			</select> 
			<select id="searchCategory">
				<option value="전체">전체</option>
				<option value="건강">건강</option>
				<option value="음식">음식</option>
				<option value="습성">습성</option>
				<option value="생활">생활</option>
				<option value="기타">기타</option>
			</select> 
			문제 : <input id="searchWord" type="text">
			<input type="button" onclick="quizListCall(showPageNum)" value="검색" >
			<table id="quizListTable">
				<thead>
					<tr>
						<th>번호</th>
						<th>동물</th>
						<th>주제</th>
						<th>문제</th>
						<th>정답</th>
					</tr>
				</thead>
				
				<tbody id="quizList">
				</tbody>
			</table>
		</div>
		</div>
		<div id="paging"></div>
	</div>
</body>
<script>
	//현재 보여줄 페이지
	var showPageNum = 1;
	 var menuName = {
				'회원관리' : 'memberlist',
				'모금글관리' : 'agreeAdmin',
				'퀴즈등록' : 'quizMain'
			};
	$(document).ready(function() {
		var content = "";
		for(var key in menuName){
			content += "<div class='menuName'";
			content += "style='"
			if(key=='퀴즈등록'){
				content += "background:#28977B;color:white;font-weight: 600;";
			}
			content += "cursor: pointer'";
			content += "onclick='pageMove(this)' id="+menuName[key]+">";
			content += key;
			content += "</div>";
		};	
		
		$("#sideMenu").empty();
		$("#sideMenu").append(content);
		
		$( "#aniamlList" ).selectmenu();
		$( "#category" ).selectmenu();
		$( "#searchAniamlList" ).selectmenu();
		$( "#searchCategory" ).selectmenu();
		$('input[type="radio"]').checkboxradio({icon: false});
	    $( "input[type=submit], button, input[type=button]" ).button();
		quizListCall(showPageNum);
	});

	function pageMove(e) {
		console.log($(e).attr("id"));
		location.href="./"+$(e).attr("id");
	}
	
	function registQuiz() {
		console.log($("#quizAsk"));
		console.log("퀴즈 내용 : "+$("#quizAsk").val())
		
		console.log($("input[name=answer]")[0]);
		console.log("퀴즈 정답 : "+$("input[name='answer']").val())
		
		if($("#aniamlList").val()=="동물" || $("#category").val()=="카테고리"){
			alert("동물 또는 카테고리를 선택해주세요.");
		}else if($("#quizAsk").val()==""){
			alert("퀴즈를 입력해주세요.");
		}else if($("#registQuizContent").val()==""){
			alert("퀴즈 해설을 입력해주세요.");
		}else if(!$("input:radio[name='answer']").is(":checked")){
			alert("퀴즈정답을 입력해주세요.");
		}else{
			$.ajax({
				type : "get",
				url : "./registQuiz",
				data : {
					"animal" : $("#aniamlList").val(),
					"category" : $("#category").val(),
					"ask" : $("#quizAsk").val(),
					//~:checked : 라디오버튼들 중에서 선택된 개체
					"answer" : $("input[name='answer']:checked").val(),
					"content" : $("#registQuizContent").val()
				},
				success : function(data) {
					if (data == 1) {
						alert("문제 등록에 성공했습니다");
						$("#aniamlList").val("동물");
						$("#category").val("카테고리");
						$("#quizAsk").val("");
						$("#registQuizContent").val("");
						$("input[name='answer']:checked").closest("label").attr("class","ui-checkboxradio-label ui-corner-all ui-button ui-widget ui-checkboxradio-radio-label");
						$("input[name='answer']:checked").removeAttr('checked');
						quizListCall(showPageNum);
					} else {
						alert("문제 등록에 실패했습니다");
					}
				},
				error : function(e) {
					console.log(e);
				}
			});
		}
	}

	function quizListCall(page) {
		$.ajax({
			type : "get",
			url : "./getQuizList",
			data : {
				"searchAnimal" : $("#searchAniamlList").val(),
				"searchCategory" : $("#searchCategory").val(),
				"searchWord" : $("#searchWord").val(),
				"showPageNum" : page
			},
			success : function(data) {
				listPrint(data);
			},
			error : function(e) {
				console.log(e);
			}
		});
	}
	
	function listPrint(data) {
		var content = "";
		if(data.list.length!=0){
			data.list.forEach(function(item) {
				content += "<tr>";
				content += "<td>" + item.quiz_idx + "</td>";
				content += "<td>" + item.animal_idx + "</td>";
				content += "<td>" + item.quiz_category + "</td>";
				content += "<td><a href='./quizDetailPage?idx="+ item.quiz_idx + "'>" + item.quiz_ask + "</a></td>";
				content += "<td>" + item.quiz_answer + "</td>";
				content += "</tr>";
			})	
		}else{
			content += "<tr>";
			content += "<td id='noLisd' colspan='5'>데이터가 없습니다.</td>"
			content += "</tr>";
		}
		
		$("#quizList").empty();
		$("#quizList").append(content);
		
		$("#paging").zer0boxPaging({
            viewRange : 5,
            currPage : data.currPage,
            maxPage : data.range,
            clickAction : function(e){
            	quizListCall($(this).attr('page'));
            }
        });
	}
</script>
</html>