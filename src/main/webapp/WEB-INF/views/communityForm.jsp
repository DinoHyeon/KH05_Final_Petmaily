<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>커뮤니티 글 작성</title>
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
/* 타이틀 */
#conDiv h1 {
	top: -5%;
	left: 28%;
	margin: 50px 0px 25px 0px;
	text-align: center;
	color: #28977B;
	font-weight: 700;
	font-size: 30;
	position: absolute;
}
/* 글 작성 테이블 */
#writeTable {
	position: absolute;
	top: 10%;
	left: -5%;
	width: 1000px;
	margin: 0px 5px 5px 5px;
	border-collapse: collapse;
	padding: 5px 10px;
}

.thCls {
	width: 20%;
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

#conDiv #content_div {
	border: 1px solid gray;
	height: 250px;
	height: 500px;
	padding: 5px;
	overflow: auto;
	text-align: left;
}

#conDiv #photo_div img {
	height: 100px;
	width: 100px;
}
/* 업로드 테이블 */
#uploadTable {
	position: absolute;
	top: 61%;
	left: -5%;
	border: 1px solid gray;
	width: 1000px;
	height: 150px;
	margin: 50px 5px 100px 5px;
	border-collapse: collapse;
	padding: 5px 10px;
}

#uploadTable tr, td {
	font-weight: 600;
	font-family: "나눔고딕 보통";
	border: 1px solid gray;
	text-align: center;
}

#uploadTable input[type='button'] {
	width: 60px;
	height: 30px;
	font-family: "나눔고딕 보통";
	background-color: #28977B;
	border-color: #28977B;
	border-style: solid;
	font-weight: 600;
	color: white;
	cursor: pointer;
}

#btn_communityWrite, #cancel {
	/* 				position:absolute;
				top:80%;
				left:73%; */
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
			<h1>커뮤니티 글 작성</h1>
			<form id="communityWrite" action="communityWrite" method="post">
				<table id="writeTable">
					<tr>
						<th class="thCls">작성자</th>
						<td><input id="board_writer" type="text" name="board_writer"
							readOnly value="${sessionScope.loginId}" /></td>

					</tr>
					<tr>
						<th class="thCls">제 목</th>
						<td><input id="board_title" type="text" name="board_title"
							onkeyup="chkword(this, 70)" /></td>
					</tr>
					<tr>
						<th class="thCls">내 용</th>
						<td><input type="hidden" id="contentForm"
							name="board_content" />
							<div id="content_div" contenteditable="true" onkeyup="div_chk()"></div>
						</td>
					</tr>
				</table>
				<table id="uploadTable">
					<tr>
						<td>사 진 첨 부 <input type="button" onclick="cFileUp()"
							value="첨부" /></td>
					</tr>
					<tr>
						<td colspan="3" style="height: 120px; border: 1px solid gray;">
							<div id="photo_div"></div>
						</td>
					</tr>
					<tr>
						<td colspan="3"
							style="text-align: right; border: 1px solid white;"><input
							type="button" id="btn_communityWrite" value="등록" /> <input
							id="cancel" type="button"
							onclick="location.href='./communityMain'" value="취소" /></td>
					</tr>
				</table>

			</form>
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

	//byte수 제한 -> 제목
	function chkword(obj, maxByte) {
		var strValue = obj.value;
		var strLen = strValue.length;
		var totalByte = 0;
		var len = 0;
		var oneChar = "";
		var str2 = "";
		for (var i = 0; i < strLen; i++) {
			oneChar = strValue.charAt(i);
			if (escape(oneChar).length > 4) {
				totalByte += 3;
			} else {
				totalByte++;
			}
			// 입력한 문자 길이보다 넘치면 잘라내기 위해 저장
			if (totalByte <= maxByte) {
				len = i + 1;
			}
		}
		// 넘어가는 글자는 자른다.
		if (totalByte > maxByte) {
			alert("허용 가능한 글자수를 초과하셨습니다.");
			str2 = strValue.substr(0, len);
			obj.value = str2;
		}
	}
	//글자수 제한 -> div
	function div_chk() {
		var div_len = $("#content_div").html().length;
		console.log("div_len", div_len);
		if (div_len > 1500) {
			alert("허용 가능한 글자수를 초과하셨습니다.");
			var new_len = $("#content_div").html().substr(0, 1500);
			console.log("new_len", new_len);
			$("#content_div").text(new_len);
		}
	}
	//파일 업로드
	function cFileUp() {
		//fileUpload 새 창을 띄운다.
		var myWin = window.open("./cFileUploadForm", "파일 업로드",
				"width=400, height=100");
	}
	//사진 삭제 - ajax
	function del(elem) {
		var path = elem.id;
		var pathimg = path + "img";//content_div id를위해
		var fileName = elem.id.split("/")[2];
		console.log("fileName", fileName);
		$.ajax({
			url : "./cFileDel",
			type : "get",
			data : {
				"fileName" : fileName
			},
			success : function(data) {
				console.log(data);
				if (data.success == 1) {
					//이미지 삭제+버튼삭제
					$(elem).prev().remove();//photo_div 이미지삭제
					$(elem).remove();//photo_div 버튼삭제
					document.getElementById(pathimg).remove();//content_div 이미지삭제
				}
			},
			error : function(e) {
				console.log(e);
			}
		});
	}
	//등록 버튼 클릭시
	$("#btn_communityWrite").click(function() {
		$("#contentForm").val($("#content_div").html());//div 내용을 hidden에 담기
		//null 들어가지 않도록 설정
		if ($("input[name='board_title']").val() == "") {//제목
			alert("제목을 작성해주세요!");
			$("input[name='board_title']").focus();
		} else if ($("input[name='board_content']").val() == "") {//내용
			alert("내용을 작성해주세요!!");
			$("input[name='board_content']").focus();
		} else {
			$("#communityWrite").submit();
		}
	});
</script>
</html>