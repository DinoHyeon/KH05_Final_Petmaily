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
<style type="text/css">
#knowledgeList {
	position: absolute;
	top: 26%;
	width: 49.7%;
	height: 20%;
	left: 25%;
}

#sideFrame {
	position: absolute;
	left: 0.52%;
	top: 12.4%;
	width: 14.8%;
	height: 95%;
	border-right: 1px solid gray;
	border-left: 1px solid gray;
}

#paging {
	position: absolute;
	top: 80%;
	width: 49.7%;
	height: 20%;
	left: 43%;
}

.ui-accordion .ui-accordion-header {
	font-weight: 600 !important;
	font-size: 110%;
}

#searchWord {
	width: 20%;
	height: 3.7%;
}

#selectArea {
	position: absolute;
	width: 100%;
	top: 17%;
	left: 25%;
}
</style>
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="mainFrame.jsp" />
	<div id="sideFrame"></div>
	<jsp:include page="sideMenu.jsp" />
	<div id="selectArea">
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
		</select> <input id="searchWord" type="text"> <input id="search"
			type="button" onclick="knowledgeListCall(showPageNum)" value="검색">
	</div>

	<div id="knowledgeList"></div>

	<div id="paging"></div>
</body>
<script>
	var showPageNum = 1
	var menuName = {
		'보호소센터 찾기' : 'searchShelter',
		'퀴즈' : 'quizSetting',
		'질병' : 'diseaseMain',
		'커뮤니티' : 'communityMain'
	};

	$(document).ready(function() {
		var content = "";
		for ( var key in menuName) {
			console.log(key);
			content += "<div class='menuName'";
			content += "style='"
			if (key == '퀴즈') {
				content += "background:#28977B;color:white;font-weight: 600;";
			}
			content += "cursor: pointer'";
			content += "onclick='pageMove(this)' id=" + menuName[key] + ">";
			content += key;
			content += "</div>";
		}
		;

		$("#sideMenu").empty();
		$("#sideMenu").append(content);

		$("#searchAniamlList").selectmenu();
		$("#searchCategory").selectmenu();
		$("#search").button();
		$("#knowledgeList").accordion();
		knowledgeListCall(showPageNum);
	});

	function pageMove(e) {
		console.log($(e).attr("id"));
		location.href = "./" + $(e).attr("id");
	};

	function knowledgeListCall(page) {
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
		console.log(data);

		$("#knowledgeList").accordion("destroy");

		var content = "";
		data.list.forEach(function(item) {
			content += "<h3>"
					+ "<"+item.animal_idx+" - "+item.quiz_category+"> "
					+ item.quiz_ask + "</h3>";
			content += "<div>";
			content += "<p>" + item.quiz_content + "</p>";
			content += "</div>";
		})

		console.log(content);

		$("#knowledgeList").empty();
		$("#knowledgeList").append(content);

		$(function() {
			$("#knowledgeList").accordion();
		});

		$("#paging").zer0boxPaging({
			viewRange : 5,
			currPage : data.currPage,
			maxPage : data.range,
			clickAction : function(e) {
				knowledgeListCall($(this).attr('page'));
			}
		});

	}
</script>
</html>