<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="icon" href="resources/icon.jpg" />
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
<title>커뮤니티 파일 업로드</title>
<style></style>
</head>
<body>
	<form id="cFileUpload" action="cFileUpload" method="post"
		enctype="multipart/form-data">
		<input type="file" name="file" onchange="cFileUpload(this)" />
	</form>
</body>
<script>
		function cFileUpload(photoEvt) {
			var thumbext = photoEvt.value; //파일을 추가한 input 박스의 값
			thumbext = thumbext.slice(thumbext.indexOf(".") + 1).toLowerCase(); //파일 확장자를 잘라내고, 비교를 위해 소문자로
			if (thumbext != "jpg" && thumbext != "png" && thumbext != "bmp") { //확장자를 확인
				alert("확장자는 이미지 파일(jpg, png, bmp)만 등록 가능합니다.");
				self.close();
			} else {
				$("#cFileUpload").submit();
			}
		}
		var filePath = "${path}";
		var imgId = filePath + "img";
		if (filePath != "") {
			var content = "";//img 태그
			var elem = window.opener.document.getElementById("content_div");
			var elem2 = window.opener.document.getElementById("photo_div");
			content += "<img id='"+imgId+"' width='150' src='${path}'/>";
			elem.innerHTML += content + "<br/>";
			content = "";//content 초기화
			content += "<img src='${path}'/>";
			content += "<input id='${path}' type='button' value='삭제' onclick='del(this)'>";
			elem2.innerHTML += content;
			self.close();
		}
	</script>
</html>

