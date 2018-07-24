<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>커뮤니티 메인</title>
<style>
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

#conDiv {
	position: absolute;
	left: 15.52%;
	top: 12.5%;
	width: 82.95%;
	height: 150%;
	background: white;
}

#conDiv input[type='button'] {
	width: 80px;
	height: 40px;
	background-color: #28977B;
	border-color: #28977B;
	border-style: solid;
	font-weight: 600;
	color: white;
	cursor: pointer;
}

#conDiv h1 {
	position: absolute;
	left: 40%;
	margin: 50px 0px 25px 0px;
	text-align: center;
	color: #28977B;
	font-weight: 600;
	font-size: 30px;
}
/* 셀렉트박스 테이블 */
#selectTable {
	top: 12%;
	left: 18%;
	height: 50px;
	position: absolute;
	float: left;
}

#cSearchKey {
	color: #28977B;
	font-weight: 600;
	font-size: 13px;
}

#selectTable td {
	padding: 5px 10px 5px 10px;
}

#valTd {
	width: 70%;
}

#selectTable input[type='text'] {
	width: 100%;
	height: 100%;
}

#selectTable select {
	width: 150px; /* 원하는 너비설정 */
	padding: .8em .5em; /* 여백으로 높이 설정 */
	font-family: inherit; /* 폰트 상속 */
	background: url(resources/arrowIcon.jpg) no-repeat 95% 50%;
	/* 네이티브 화살표 대체 */
	border: 1px solid #999;
	border-radius: 0px; /* iOS 둥근모서리 제거 */
	-webkit-appearance: none; /* 네이티브 외형 감추기 */
	-moz-appearance: none;
	appearance: none;
}

#listTable {
	position: absolute;
	top: 18%;
	left: 10%;
	width: 80%;
	margin: 20px 5px 200px 5px;
	border-collapse: collapse;
	padding: 5px 10px;
}

#listTable input[type='text'] {
	width: 100%;
}

#listTable textarea {
	width: 100%;
	resize: none;
	margin: 0;
}

#listTable td {
	text-align: center;
	border: 1px solid white;
	border-collapse: collapse;
	padding: 2px 2px;
}

#listTable th {
	border: 1px solid white;
	border-collapse: collapse;
	padding: 5px 10px;
	background-color: #28977B;
	color: white;
}

#paging {
	position: absolute;
	top: 63%;
	left: 39%;
}

#write {
	position: absolute;
	top: 63%;
	left: 70%;
}

#cList a:link {
	text-decoration: none;
	color: black;
}
</style>
</head>
<body>
	<jsp:include page="mainFrame.jsp" />
		<div id="sideFrame"></div>
   <jsp:include page="sideMenu.jsp" />
   <div id="contentFrame">
	<!-- 내용시작 -->
	<div id="conDiv">
		<h1>커뮤니티 게시판</h1>
		<table id="selectTable">
			<tr>
				<td><select id="cSearchKey" name="cSearchKey">
						<option value="검색 키워드" selected>검색 키워드</option>
						<option value="제목">제목</option>
						<option value="작성자">작성자</option>
						<option value="내용">내용</option>
				</select></td>
				<td id="valTd"><input type="text" id="cSearchVal"
					name="cSearchVal" /></td>
				<td><input type="button" id="searchBtn"
					onclick="communityList(showPageNum)" value="검색" /></td>
			</tr>
		</table>
		<table id="listTable">
			<thead>
				<tr>
					<th style="width: 150px">글번호</th>
					<th style="width: 450px">제목</th>
					<th style="width: 150px">작성자</th>
					<th style="width: 150px">작성일</th>
					<th style="width: 100px">조회수</th>
				</tr>
			</thead>
			<tbody id="cList">
			</tbody>
		</table>
		<input type="button" id="write" value="글 작성"
			onclick="location.href='./communityForm'" />
		<div id="paging"></div>
	</div>
	</div>
</body>
<script>
	//현재 보여줄 페이지
	var showPageNum = 1;
	var page = 1;
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
			if (key == '커뮤니티') {
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
		communityList(showPageNum);
	});

	function pageMove(e) {
		console.log($(e).attr("id"));
		location.href = "./" + $(e).attr("id");
	};
	
	//리스트 ajax
	function communityList(page) {
		$.ajax({
			type : "get",
			url : "./communityList",
			data : {
				"cSearchKey" : $("#cSearchKey").val(),
				"cSearchVal" : $("#cSearchVal").val(),
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
	//리스트 그리기
	function listPrint(data) {
		var content = "";
		var dateVal = "";
		console.log(data);
		data.cList.forEach(function(item) {
			var date = new Date(item.board_regDate);

			content += "<tr>";
			content += "<td>" + item.board_idx + "</td>";
			content += "<td><a href='./communityDetail?board_idx="
					+ item.board_idx + "'>" + item.board_title + "</td>";
			content += "<td>" + item.board_writer + "</td>";
			content += "<td>" + date.toLocaleDateString("en-KOR") + "</td>";
			content += "<td>" + item.board_hit + "</td>";
			content += "</tr>";
		})
		$("#cList").empty();
		$("#cList").append(content);
		$("#paging").zer0boxPaging({
			viewRange : 5,
			currPage : data.currPage,
			maxPage : data.range,
			clickAction : function(e) {
				communityList($(this).attr('page'));
			}
		});
	}
</script>
</html>