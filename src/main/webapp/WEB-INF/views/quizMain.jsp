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
<script src="resources/js/zer0boxPaging.js" type="text/javascript"></script>
<title>Insert title here</title>
<style>
textarea {
	resize: none;
}

#quizAsk {
	width: 50%;
	border: 1px solid black;
}

#quizContent {
	width: 50%;
	height: 20%;
	border: 1px solid black;
}

button{
	width: 10%;
	
}
</style>
</head>
<body>
	<div>
		<select id="aniamlList">
			<option value="강아지">강아지</option>
			<option value="고양이">고양이</option>
			<option value="기타">기타</option>
		</select> <select id="category">
			<option value="건강">건강</option>
			<option value="음식">음식</option>
			<option value="습성">습성</option>
			<option value="생활">생활</option>
			<option value="기타">기타</option>
		</select>
	</div>
	<textarea id="quizAsk" rows="" cols=""></textarea>
	<div id="quizAnswerDiv">
		<label>
			O<input type="radio" name="answer" value="O">
		</label>
		<label>
			X<input type="radio" name="answer" value="X">
		</label>
	</div>
	<textarea id="quizContent" rows="" cols=""></textarea>
	<input type="button" onclick="registQuiz()" value="문제 등록">
	<div id="quizListDiv">
		<select id="searchAniamlList">
			<option value="강아지">강아지</option>
			<option value="건강">고양이</option>
			<option value="기타">기타</option>
		</select> <select id="searchCategory">
			<option value="전체">전체</option>
			<option value="건강">건강</option>
			<option value="음식">음식</option>
			<option value="습성">습성</option>
			<option value="생활">생활</option>
			<option value="기타">기타</option>
		</select> 
		문제 <input id="searchWord" type="text">
		<input type="button" onclick="quizListCall(showPageNum)" value="검색">
		<table>
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
		<div id="paging" />
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
		$('input[type="radio"]').checkboxradio();
	    $( "input[type=submit], button, input[type=button]" ).button();
	    $( "input[type=submit], button, input[type=button]" ).click( function( event ) {
	      event.preventDefault();
	    } );
		quizListCall(showPageNum);
	});

	function registQuiz() {
		$.ajax({
			type : "get",
			url : "./registQuiz",
			data : {
				"animal" : $("#aniamlList").val(),
				"category" : $("#category").val(),
				"ask" : $("#quizAsk").val(),
				//~:checked : 라디오버튼들 중에서 선택된 개체
				"answer" : $("input[name='answer']:checked").val(),
				"content" : $("#quizContent").val()
			},
			success : function(data) {
				if (data == 1) {
					alert("문제 등록에 성공했습니다");
					$("#aniamlList").val("");
					$("#category").val("");
					$("#quizAsk").val("");
					$("#quizContent").val("");
					//checked 속성 제거
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
		data.list.forEach(function(item) {
			content += "<tr>";
			content += "<td>" + item.quiz_idx + "</td>";
			content += "<td>" + item.animal_idx + "</td>";
			content += "<td>" + item.quiz_category + "</td>";
			content += "<td><a href='./quizDetailPage?idx="+ item.quiz_idx + "'>" + item.quiz_ask + "</a></td>";
			content += "<td>" + item.quiz_answer + "</td>";
			content += "</tr>";
		})
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