<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<title>Insert title here</title>
<style></style>
</head>
<body>
	<form id="fileUpload" action="./Photoupload" method="post"
		enctype="multipart/form-data">
		<input type="file" name="file" onchange="fileUpload()" />

	</form>
	업로드 한 파일 경로 :
	<span></span>
</body>
<script>
      function fileUpload(){
         $("#fileUpload").submit();
      }
      var filePath = "${path}";
      $("span").text(filePath);
      
      var filesize="${fileList}"
   
      var imgId = filePath.split("/")[2];
      
      if(filePath != ""){
         var content = "";//img 태그
           var elem = window.opener.document.getElementById("editable");
           var elem2 = window.opener.document.getElementById("receiptList");
           elem.innerHTML +="<영수증사진>"+"<hr>";
           content +="<img id='"+imgId+"' width='250' src='${path}'/>";
           elem.innerHTML += content+"<br/>";
           elem.innerHTML += "<hr>";
           content ="";//content 초기화
           content +="<div id='attachani'><img width='250' src='${path}'/>";
           content +="<input id='${path}' type='button' value='삭제' onclick='deltwo(this)'><div>";
           
           elem2.innerHTML += content;
           self.close();   
      }

   </script>
</html>










