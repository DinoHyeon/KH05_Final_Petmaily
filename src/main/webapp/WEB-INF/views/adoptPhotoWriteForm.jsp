<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<title>입양후기 사진 업로더</title>
</head>
<body>
	<form id="adoptPhotoWrite" action="./adoptPhotoWrite" method="post"
		enctype="multipart/form-data">
		<input type="file" name="file" onchange="adoptPhotoWrite(this)" />
	</form>
</body>
<script>
		function adoptPhotoWrite(photoEvt){
			var thumbext = photoEvt.value; //파일을 추가한 input 박스의 값

		    thumbext = thumbext.slice(thumbext.indexOf(".") + 1).toLowerCase(); //파일 확장자를 잘라내고, 비교를 위해 소문자로
		     if(thumbext != "jpg" && thumbext != "png" &&  thumbext != "bmp"){ //확장자를 확인
		         alert("확장자는 이미지 파일(jpg, png, bmp)만 등록 가능합니다.");
		         self.close();
		      }else{
					$("#adoptPhotoWrite").submit();
		      }

		}
 		var filePath = "${path}";
		var imgId = filePath+"img";
		
 		if(filePath != ""){
			var content = "";//img 태그
			var elem = window.opener.document.getElementById("content_div");
			var elem2 = window.opener.document.getElementById("photo_div");
			content +="<img id='"+imgId+"' width='250' src='${path}'/>";
			elem.innerHTML += content+"<br/>";
			content ="";//content 초기화
			content +="<img width='250' src='${path}'/>";
			content +="<input id='${path}' type='button' value='삭제' onclick='del(this)'>";
			content +="<br/>";
			elem2.innerHTML += content;
			self.close();
		}
	</script>
</html>