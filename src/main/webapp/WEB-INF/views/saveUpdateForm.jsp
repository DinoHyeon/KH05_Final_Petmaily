<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="resources/plugIn/jquery-ui.css">
<link rel="stylesheet" href="resources/plugIn/jquery-ui.theme.css">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="resources/plugIn/jquery-ui.js"></script>
<title>구조 후기 글 수정 페이지</title>
</head>
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
	/* 타이틀 */ # title h1 { top : 16%;
	left: 45%;
	margin: 50px 0px 25px 0px;
	text-align: center;
	color: #28977B;
	font-weight: 700;
	font-size: 30;
	position: absolute;
}

#title h5 {
	top: 44%;
	left: 22%;
	margin: 10px 0px 40px 0px;
	text-align: right;
	color: black;
	font-weight: 700;
	font-size: 10;
	position: absolute;
}

/* 셀렉트박스 테이블 */
.adopt  #selectTable {
	top: 373px;
	left: 21%;
	padding: 1px 1px 1px 1px;
	margin: 25px auto auto auto;
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
/* IE 10, 11의 네이티브 화살표 숨기기 */
#selectTable select::-ms-expand {
	display: none;
}

#selectTable select {
	width: 180px; /* 원하는 너비설정 */
	height: 30px;
	font-family: inherit; /* 폰트 상속 */
	background: url(resources/arrowIcon.jpg) no-repeat 95% 50%;
	/* 네이티브 화살표 대체 */
	border: 1px solid #999;
	border-radius: 0px; /* iOS 둥근모서리 제거 */
	-webkit-appearance: none; /* 네이티브 외형 감추기 */
	-moz-appearance: none;
	appearance: none;
}

/* 글 작성 테이블 */
.adopt #writeTable {
	top: 62%;
	left: 21%;
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
/* 업로드 테이블 */
.adopt #uploadTable {
	top: 800px;
	left: 21%;
	border: 1px solid lightgray;
	width: 1000px;
	height: 150px;
	margin: 50px 5px 100px 5px;
	border-collapse: collapse;
	padding: 5px 10px;
	position: absolute;
}

#btnTable {
	left: 70%;
	top: 1010px;
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

#uploadBtn {
	left: 88%;
	top: 100px;
	height: 40px;
	width: 107px;
	background-color: #28977B;
	border-color: #28977B;
	border-style: solid;
	font-weight: 600;
	color: white;
	cursor: pointer;
	position: absolute;
}
</style>
<body>
	<jsp:include page="mainFrame.jsp" />
	<div id="sideFrame"></div>
	<jsp:include page="sideMenu.jsp" />
	<div id="contentFrame">
		<div class="adopt">

			<div id=title>
				<h1>구조 후기 수정</h1>
				<h5>자신이 작성한 구조 후기를 수정합니다</h5>
			</div>
			<form id="saveUpdate" action="saveUpdate" name="saveUpdate"
				method="post">
				<input type="hidden" name="board_idx"
					value="${sUpdateForm.board_idx}" />
				<table id="selectTable">
					<tr>
						<th colspan=2 style="width: 1000px">필수 선택 항목</th>
					</tr>
					<tr>
						<td class=tap>지역</td>
						<td><select id="sido" onchange="getSigungu()"
							name="save_loc1">
								<option selected>시/도 선택 (필수)</option>
								<option value="6110000">서울특별시</option>
								<option value="6260000">부산광역시</option>
								<option value="6270000">대구광역시</option>
								<option value="6280000">인천광역시</option>
								<option value="6290000">광주광역시</option>
								<option value="6300000">대전광역시</option>
								<option value="6310000">울산광역시</option>
								<option value="6410000">경기도</option>
								<option value="6420000">강원도</option>
								<option value="6430000">충청북도</option>
								<option value="6440000">충청남도</option>
								<option value="6450000">전라북도</option>
								<option value="6460000">전라남도</option>
								<option value="6470000">경상북도</option>
								<option value="6480000">경상남도</option>
								<option value="6500000">제주특별자치도</option>
						</select> <select id="sigundo" name="save_loc2">
								<option selected>시/군/도 선택</option>
						</select> <input id="selsido" name="selsido" type="hidden" /></td>
					</tr>
				</table>

				<table id="writeTable">
					<tr>
						<th style="width: 100px">작성자</th>
						<td><input id="board_writer" type="text" name="board_writer"
							readOnly value=${sUpdateForm.board_writer } /></td>
					</tr>
					<tr>
						<th style="width: 100px">제 목</th>
						<td><input id="board_title" type="text" name="board_title"
							value="${sUpdateForm.board_title}" onkeyup="chkword(this, 200)" /></td>
					</tr>
					<tr>
						<th colspan=2 style="width: 1000px">내 용</th>
					</tr>
					<tr>
						<td colspan=2>
							<!-- 단점이... 값을 넘길 수 없다는것!! 그래서 hidden 만든다 --> <input
							type="hidden" id="contentForm" name="board_content" /> <!-- div에서 내용 받아 볼 수 있게 하려고 설정 -->
							<div id="content_div" contenteditable="true" onkeyup="div_chk()">
								${sUpdateForm.board_content}</div>
						</td>
					</tr>
				</table>
				<table id="uploadTable">
					<tr>
						<td>사진첨부</td>
						<td></td>
						<td><input type="button" id="uploadBtn"
							onclick="savePhotoWrite()" value="첨부" /></td>
					</tr>
					<tr>
						<td colspan="3">
							<div id="photo_div" contenteditable="true"></div>
						</td>
					</tr>
				</table>
				<table id="btnTable">
					<tr>
						<td><input class="btn" type="button" value="수정"
							id="btn_saveUpdate" /> <input class="btn" type="button"
							value="취소" onclick="location.href='./saveMain'" /></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
<script>
var menuName = {'구조후기':'saveMain', '모금':'fundMain'};
var conImg = $("#content_div").children('img');
var content="";

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
for(var i = 0; i<conImg.length; i++){
	content+="<img width='100px' height='100px' src='"+conImg[i].src+"'/>";
	}
$("#photo_div").append(content);//하단 div에 넣기
 $("#photo_div img").each(function(){//삭제 버튼 만들기
	 var delBtn = "<input type='button' value='삭제' onclick='del(this)'>";
	 $(this).after(delBtn);
 });
function del(elem){//이미지+버튼 삭제
	 	//content_div에 있는 id 찾아오기
	 	var findId = $(elem).prev().attr('src').split("controller/")[1]+"img";
		$(elem).prev().remove();//photo_div 이미지삭제
		$(elem).remove();//photo_div 버튼삭제
		document.getElementById(findId).remove();//content_div 이미지삭제
}

	//내용 placeholder+글자수 제한을 위해!
	function div_chk(){
		var div_len = $("#content_div").html().length;
		console.log("div_len", div_len);
	    if (div_len > 1500) {
		          alert("허용 가능한 글자수를 초과하셨습니다.");
		          var new_len = $("#content_div").html().substr(0, 1500);
		          console.log("new_len", new_len);
 		          $("#content_div").text(new_len);
		       }
	}
	//수정 버튼 클릭시
	$("#btn_saveUpdate").click(function() {
		$("#contentForm").val($("#content_div").html());//div 내용을 hidden에 담기

		// 시/도, 시/도 값
		var sido = document.getElementById("sido");
		var sidoText = sido.options[sido.selectedIndex].text;

		//null 들어가지 않도록 설정
		 if (sidoText == "시/도 선택 (필수)") {
			alert("시/도 를 선택해주세요!");
		} else {
			$("#saveUpdate").submit();
		}
	});

	//파일 업로드
	function savePhotoWrite() {
		//fileUpload 새 창을 띄운다.
		var myWin = window.open("./savePhotoWriteForm", "파일 업로드",
				"width=400, height=100");
	}

	////////////////////////////////////////////////////////////////
	/* 셀렉트테이블 api */
	function getSigungu() {
		// 텍스트값 가져오기
		var target = document.getElementById("sido");
		var selsido = target.options[target.selectedIndex].text;
		$.ajax({
			"url" : "./getSigungu",
			"type" : "get",
			"data" : {
				"sidoCode" : $("#sido").val()
			},
			"success" : function(data) {
				console.log(data);
				var content = "";
				data.forEach(function(item) {
					content += "<option value="+item.sigundoName+">";
					content += item.sigundoName;
					content += "</option>";
				})
				$("#sigundo").empty();
				$("#sigundo").append(content);
				$("#selsido").val(selsido);
			},
			"error" : function(x, o, e) {
				alert(x.status + ":" + o + ":" + e);
			}
		});
	}
	
</script>
</html>