<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<title>구조 후기 상세보기 페이지</title>
<style>
#contentFrame {
	position: absolute;
	left: 15.52%;
	top: 12.5%;
	width: 82.95%;
	height: 150%;
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
/* 타이틀 */
#title h1 {
	left: 40%;
	margin: 50px 0px 25px 0px;
	text-align: center;
	color: #28977B;
	font-weight: 700;
	font-size: 30;
	position: absolute;
}

#title h5 {
	top: 9%;
	left: 69%;
	margin: 10px 0px 40px 0px;
	text-align: right;
	color: black;
	font-weight: 700;
	font-size: 10;
	position: absolute;
}

/* 동물 종류, 품종, 지역 테이블 */
.adopt  #selectTable {
	top: 9%;
	left: 7%;
	padding: 2px 2px 2px 4px;
	margin: 30px auto auto auto;
	position: absolute;
	float: left;
}

.tap {
	background-color: #28977B;
	font-weight: 600;
	color: white;
	height: 30px;
	margin: auto auto auto 10px;
	text-align: center;
	width: 100px;
}

#selectTable th {
	background-color: #28977B;
	height: 30px;
	width: 1000px;
	color: white;
	font-weight: 600;
}

#selectTable td {
	padding: 5px 10px 5px 10px;
}

/* 글 작성 테이블 */
.adopt #writeTable {
	top: 19%;
	left: 7%;
	width: 1000px;
	margin: 0px 5px 5px 5px;
	border-collapse: collapse;
	padding: 5px 10px;
	position: absolute;
}

#writeTable input[type='text'] {
	width: 100%;
	height: 30px;
}

#writeTable textarea {
	width: 100%;
	resize: none;
	margin: 0;
}

#writeTable td {
	text-align: center;
	border: 1px solid white;
	border-collapse: collapse;
	padding: 2px 2px;
	margin: 0px;
}

#writeTable th {
	border: 1px solid white;
	border-collapse: collapse;
	padding: 5px 10px;
	background-color: #28977B;
	color: white;
}

#content_div {
	border: 1px solid lightgray;
	height: 250px;
	text-align: left;
}

.littleTd {
	text-align: left;
}

/* 업로드 테이블 */
.adopt #uploadTable {
	top: 42%;
	left: 7.2%;
	border: 1px solid lightgray;
	width: 1000px;
	height: 100px;
	margin: 100px 5px 100px 5px;
	border-collapse: collapse;
	padding: 5px 10px;
	position: absolute;
}

#btnTable {
	left: 60%;
	top: 61%;
	position: absolute;
}

#replyTable {
	width: 1000px;
	top: 70%;
	left: 7.1%;
	position: absolute;
}

.btn {
	top: 90%;
	height: 40px;
	width: 107px;
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
	<div id="contentFrame">
		<div class="adopt">

			<div id=title>
				<h1>구조 후기 글 보기</h1>
				<h5>회원님들이 작성한 구조 후기 입니다</h5>
			</div>

			<table id="selectTable">
				<tr>
					<th colspan=2 style="width: 1000px">분류</th>
				</tr>
				<tr>
					<td class=tap>지역</td>
					<td style="font-weight: 300">${boardSaveDetail.save_loc1}
						${boardSaveDetail.save_loc2}</td>
				</tr>
			</table>
			<table id="writeTable">
				<input type="hidden" id="board_idx" value="${sDetail.board_idx}" />
				<tr class="littleTr">
					<th style="width: 100px">작성자</th>
					<td class="littleTd" style="width: 500px">${sDetail.board_writer}</td>
					<th style="width: 100px">작성일</th>
					<td>${sDetail.board_regDate}</td>
				</tr>
				<tr class="littleTr">
					<th style="width: 100px">제 목</th>
					<td class="littleTd" style="width: 530px">${sDetail.board_title}</td>
					<th style="width: 100px">조회수</th>
					<td>${sDetail.board_hit}</td>
				</tr>
				<tr>
					<th colspan=4 style="width: 1000px">내 용</th>
				</tr>
				<tr>
					<td colspan=4 style="text-align: left">
						<div id="content_div">${sDetail.board_content}</div>
					</td>
				</tr>
				<%-- <tbody>
				<tr>
			<td>	<jsp:include page="reply.jsp"/>
			</td>
			</tr>
			</tbody> --%>
			</table>
			<table id="uploadTable">
				<tr>
					<td>첨부된 파일</td>
					<td id="photoTd">${sDetailPhoto}</td>
				</tr>
			</table>
			<table id=btnTable>
				<tr>
					<td><input type="button" class="btn"
						onclick="location.href='./saveUpdateForm?board_idx=${sDetail.board_idx}'"
						value="수정" /> <input type="button" class="btn"
						onclick="saveDel()" value="삭제" /> <input type="button"
						class="btn" onclick="location.href='./saveMain'" value="글 목록으로" />
					</td>
				</tr>
				<tbody>
					<tr>
						<td><jsp:include page="reply.jsp" /></td>
					</tr>
				</tbody>
			</table>
			<!-- 			<table id="replyTable">
				<tbody>
				
			</tbody>
			</table> -->
		</div>
	</div>
</body>
<script>
	var menuName = {'구조후기':'saveMain', '모금':'fundMain'};
	var oriName = '${sDetailPhoto}';
	var del = $("#board_idx").val();
	
	$(document).ready(function() {
			var content = "";
			for ( var key in menuName) {
				console.log(key);
				content += "<div class='menuName'";
				content += "style='"
				if (key == '구조후기') {
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
		location.href="./"+$(e).attr("id");
	};
	
	//파일명에 넣을 수 없는 \기호를 사용
	var newStr = oriName.replace( /a\a/gi, "<br/>");
	$("#photoTd").html(newStr);

	function saveDel() {
		var sDel = confirm("구조후기 게시글을 삭제하시겠습니까?");
		   if (sDel) {
			      alert("삭제 되었습니다.");
			      location.href='./saveDelete?board_idx=${sDetail.board_idx}';
			   }
			   else {
			      alert("삭제가 취소되었습니다.");
			   }
	}
	</script>
</html>