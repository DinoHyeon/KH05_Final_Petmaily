<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>커뮤니티 글 상세보기</title>
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
	left: 0%;
	top: 0%;
	width: 82.95%;
	height: 150%;
	background: white;
}
/* 타이틀 */
#conDiv h1 {
	left: 39%;
	margin: 50px 0px 25px 0px;
	text-align: center;
	color: #28977B;
	font-weight: 700;
	font-size: 30;
	position: absolute;
}

#conDiv table, th, td {
	border: 1px solid gray;
	border-collapse: collapse;
	padding: 6px 15px;
	text-align: center;
}

#conDiv td {
	text-align: center;
}
/* 글 테이블 */
#detailTable {
	top: 14%;
	left: 11%;
	width: 1000px;
	margin: 0px 5px 5px 5px;
	border-collapse: collapse;
	padding: 5px 10px;
	position: absolute;
}

#detailTable input[type='text'] {
	width: 100%;
	height: 30px;
}

#detailTable textarea {
	width: 100%;
	resize: none;
	margin: 0;
}

#detailTable td {
	text-align: center;
	border: 1px solid white;
	border-collapse: collapse;
	padding: 2px 2px;
	margin: 0px;
}

#detailTable th {
	border: 1px solid white;
	border-collapse: collapse;
	padding: 5px 10px;
	background-color: #28977B;
	color: white;
}

#detailTable input[type='button'] {
	height: 40px;
	width: 120px;
	background-color: #28977B;
	border-color: #28977B;
	border-style: solid;
	font-weight: 600;
	color: white;
	cursor: pointer;
}

#upBtn, #delBtn, #listBtn {
	width: 80px;
	height: 40px;
	font-family: "나눔고딕 보통";
	font-size: 20px;
	background-color: #28977B;
	border-color: #28977B;
	border-style: solid;
	font-weight: 600;
	color: white;
	cursor: pointer;
}

#conDiv input[type='button'] {
	border-radius: 5px;
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
			<h1>커뮤니티 상세 페이지</h1>
			<input type="hidden" id="board_idx" value="${cDetail.board_idx}" />
			<table id="detailTable" style="border: 1px solid gray">
				<tr class="littleTr">
					<th style="width: 100px">작성자</th>
					<td class="littleTd" style="width: 500px">${cDetail.board_writer}</td>
					<th style="width: 100px">작성일</th>
					<td>${cDetail.board_regDate}</td>
				</tr>
				<tr class="littleTr">
					<th style="width: 100px">제 목</th>
					<td class="littleTd" style="width: 500px">${cDetail.board_title}</td>
					<th style="width: 100px">조회수</th>
					<td>${cDetail.board_hit}</td>
				</tr>
				<tr>
					<th colspan=4 style="width: 1000px; border: 1px solid gray;">내
						용</th>
				</tr>
				<tr>
					<td colspan=4
						style="text-align: left; border: 1px solid gray; height: 450px;">
						${cDetail.board_content}</td>
				</tr>
				<tr>
					<td colspan=4 style="text-align: right"><input type="button"
						id="upBtn"
						onclick="location.href='./communityUpdateForm?board_idx=${cDetail.board_idx}'"
						value="수정" /> <input type="button" id="delBtn"
						onclick="communityDel()" value="삭제" /> <input type="button"
						id="listBtn" value="글 목록"
						onclick="location.href='./communityMain'" /></td>
				</tr>
				<tbody>
					<tr>
						<td><jsp:include page="reply.jsp" /></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</body>
<script>
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
	});

	function pageMove(e) {
		console.log($(e).attr("id"));
		location.href = "./" + $(e).attr("id");
	};

	//로그인 아이디 체크 -> 버튼 활성화/비활성화
	var loginId = "${sessionScope.loginId}";
	console.log("커뮤니티 상세보기 - 로그인아이디", loginId);
	if (loginId == "${cDetail.board_writer}") {
		console.log("글작성자 확인, 수정+삭제버튼 활성화");
	} else {
		$("#updateBtn").hide();
		$("#delBtn").hide();
	}
	//삭제 요청
	function communityDel() {
		var cDel = confirm("커뮤니티 게시글을 삭제하시겠습니까?");
		if (cDel) {
			alert("삭제합니다.");
			location.href = './communityDelete?board_idx=${cDetail.board_idx}';
		} else {
			alert("삭제가 취소되었습니다.");
		}
	}
</script>
</html>