<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
table, th, td {
	border: 1px solid black;
	border-collapse: collapse;
	padding: 6px 15px;
	text-align: center;
}

#buttonarea {
	position: absolute;
	top: 44%;
	left: 38%;
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

#flist, #fedit, #fdel {
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
</style>
</head>
<body>
	<jsp:include page="mainFrame.jsp" />
	<div id="sideFrame"></div>
	<jsp:include page="sideMenu.jsp" />
	<div id="conDiv">
		<h1>${dto.board_title}</h1>
		<input type="hidden" id="board_idx" value="${dto.board_idx}" />
		<table id="detailTable" style="border: 1px solid gray">
			<tr class="littleTr">
				<th style="width: 100px">작성자</th>
				<td class="littleTd" style="width: 500px">${dto.board_writer}</td>
				<th style="width: 100px">작성일</th>
				<td>${dto.board_regDate}</td>
			</tr>
			<tr class="littleTr">
				<th style="width: 100px">제 목</th>
				<td class="littleTd" style="width: 500px">${dto.board_title}</td>
				<th style="width: 100px">조회수</th>
				<td>${dto.board_hit}</td>
			</tr>
			<tr class="littleTr">
				<th style="width: 100px">지역</th>
				<td class="littleTd" style="width: 500px">${dto.fund_area}</td>
			<tr>
				<th colspan=4 style="width: 1000px; border: 1px solid gray;">내
					용</th>
			</tr>
			<tr>
				<td colspan=4 style="text-align: left; border: 1px solid gray;">
					${dto.board_content}</td>
			</tr>
			<tr>
				<td colspan=4 style="text-align: right"><input type="button"
					id="flist" onclick="fundList()" value="글목록" /> <input
					type="button" id="fedit" onclick="fundedit()" value="수정" /> <input
					type="button" id="fdel" onclick="funddelete()" value="삭제" /></td>
			</tr>

		</table>
	</div>
	<jsp:include page="reply.jsp"/>


</body>
<script>
	var msg = "${msg}";
	var menuName = {
		'구조후기' : 'saveMain',
		'모금' : 'fundMain'
	};

	$(document).ready(function() {
		var content = "";
		for ( var key in menuName) {
			console.log(key);
			content += "<div class='menuName'";
			content += "style='"
			if (key == '모금') {
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

	function fundList() {
		location.href = "./fundMain";
	}
	function funddelete() {
		var del = confirm("해당 글을 삭제하시겠습니까?");
		if (del) {
			location.href = "./funddelete?idx=${dto.board_idx}";
		}
	}
	function fundedit() {
		location.href = "./fundupdateForm?idx=${dto.board_idx}&call=fundupdateForm";

	}

	var fileMap = {};
	var fileCnt = "${size}";//첨부파일 유무 확인

	<c:forEach items="${files}" var = "list">
	fileMap["${list.photo_newName}"] = "${list.photo_oriName}";
	</c:forEach>
	console.log("fileMap", fileMap);

	//파일이 있으면 fileMap 에 있는 값으로 링크를 생성
	if (fileCnt > 0) {
		//object 에서 키추출 -> 키에 따른 값을 추출
		//console.log(Object.keys(fileMap));
		//키를 이용해 값을 하나씩 뽑아내기
		//array.forEach(function(item){});
		var content = "";
		Object.keys(fileMap).forEach(
				function(item) {
					content += "    <a href='./download?file=" + item + "'>"
							+ "<img width='15px' src='resources/icon.png'/>"
							+ fileMap[item] + "</a>";

				});
		$("#attach").append(content);

	} else {
		$("#attach").html("첨부된 파일이 없습니다.");
	}
</script>
</html>