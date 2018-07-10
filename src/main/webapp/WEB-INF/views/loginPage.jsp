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
		
			table, th, td{
				border : 1px solid black;
				border-collapse : collapse;
				padding : 5px 10px;
				
				border-right:none;
				border-left:none;
				border-top:none;
				border-bottom:none
			}
			
			h3{
				color: gray;
				padding: 150px 600px 5px 600px;
			}
			
			h2{
				color: red;
				font-size: 15;
			}
			
			button{
				width: 70pt;
				height: 20pt;
			}
			
			#loginFail{
				color: red;
				display: none;
			}
		</style>
	</head>
	<body>
		<jsp:include page="mainFrame.jsp" />
		<h3>LOGIN</h3>
		<hr>

		<form action="loginConfirmPage" method="post">
			<table>
				<tr>
					<th>ID</th>
					<td><input type="text" name="id" placeholder="아이디 입력" maxlength="20" /></td>
					<td><button>로그인</button></td>
				</tr>
				<tr>
					<th>PW</th>
					<td><input type="password" name="pw" placeholder="비밀번호 입력" maxlength="20" /></td>
					<td><input type="button" onclick="location.href='loginSearchPage'" style="width:70pt; height:20pt;" value="ID/PW 찾기"></td>
				</tr>
			</table>
			<h2 id="loginFail">&nbsp;&nbsp;ID 또는 PW가 올바르지 않습니다 다시 작성하세요.</h2>
		</form>
	</body>
	<script>
		var msg = "${msg}";
	
		if(msg=="fail"){
			var loginFail = document.getElementById("loginFail");
			
			loginFail.style.display = "block";
		}
	</script>
</html>










