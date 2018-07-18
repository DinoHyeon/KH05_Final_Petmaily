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
	height: 100%;
	background: white;
}

#sideFrame {
	position: absolute;
	left: 0.52%;
	top: 12.5%;
	width: 15%;
	height: 87%;
	background: black;
}


/* selectBox(동물종/카테고리) */
#registSelectBox{
	position: absolute;
	top : 3.5%;
	left : 20%;
}


/* 정답 div */
#registAnswerRadio{
	position: absolute;
	top : 34%;
	left : 20%;
}

/* 테이블 상단 */
#quizListTable{
	border-top : 1px solid black;
	border-bottom: 1px solid black;
	margin-top : 8px;
	width : 100%;
	padding-top: 3px;
	background-color: #D2E5A8;
}

#quizListTable td{
	text-align: center;
	width : 300px;
}

textarea {
	resize: none;
}

/* 문제작성 */
#quizAsk {
	width: 50%;
	border: 1px solid black;
	position: absolute;
	top : 8%;
	left : 20%;
}

/* 문제해설 */
#registQuizContent {
	width: 50%;
	height: 20%;
	border: 1px solid black;
	position: absolute;
	top : 13%;
	left : 20%;
}

/* 버튼(문제등록) */
#registBtn{
	position: absolute;
	top : 40%;
	left : 44%;
}

#qqq{
	margin-left : 15px;
}

/* 리스트 */
#quizList{
	position: absolute;
	top : 100%;
}

/* 페이징 */
#paging{
	position: absolute;
	top : 110%;
	left : 40%;
}

/* selectBox(검색) */
#quizListDiv{
	position: absolute;
	top : 53%;
	left : 20%;
}

button{
	width: 10%;
	
}
td{
	border-bottom: 1px solid black;
}
</style>
</head>
<body>
	<jsp:include page="mainFrame.jsp" />
	<div id="sideFrame"></div>
	<div id="contentFrame">
	<h3 id="qqq">Quiz 등록</h3>
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
			<input type="button" onclick="quizListCall(showPageNum)" value="검색">
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
		<div id="paging"></div>
	</div>
</body>
<script>
	//현재 보여줄 페이지
	var showPageNum = 1
	$(document).ready(function() {
		$( "#aniamlList" ).selectmenu();
		$( "#category" ).selectmenu();
		$( "#searchAniamlList" ).selectmenu();
		$( "#searchCategory" ).selectmenu();
		$('input[type="radio"]').checkboxradio({icon: false});
	    $( "input[type=submit], button, input[type=button]" ).button();
		quizListCall(showPageNum);
	});

	function registQuiz() {
		console.log($("#quizAsk"));
		console.log("퀴즈 내용 : "+$("#quizAsk").val())
		
		console.log($("input[name=answer]")[0]);
		console.log("퀴즈 정답 : "+$("input[name='answer']").val())
		
		if($("#aniamlList").val()=="동물" || $("#category").val()=="카테고리"){
			alert("동물 또는 카테고리를 선택해주세요.");
		}else if($("#quizAsk").val()==""){
			alert("퀴즈를 입력해주세요.");
		}else if(!$("input:radio[name='answer']").is(":checked")){
			alert("퀴즈정답을 입력해주세요.");
		}else if($("#registQuizContent").val()==""){
			alert("퀴즈 해설을 입력해주세요.");
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
			content += "<td colspan='5'>검색결과가 없습니다.</td>"
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