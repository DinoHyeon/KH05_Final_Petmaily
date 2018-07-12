<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri ="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
		<title>로그인</title>		
		<style>
			form{
				padding: 10px 600px;
			}

			h3{
				color: gray;
				padding: 150px 600px 5px 600px;
			}
			
			button{
				width: 70pt;
				height: 20pt;
			}
		</style>
	</head>
	<body>
		<h3>로그인 성공</h3>
		<h3>${msg}</h3>
		<h3>${sessionId}</h3>
			
		<form action="loginPage" method="post">
			<button onclick="sesscionCancel">로그아웃</button>	
		</form>
	</body>
	<script>
		function sessionCancel(){
			<%session.removeAttribute("sessionId");%>
		}
	</script>
</html>










