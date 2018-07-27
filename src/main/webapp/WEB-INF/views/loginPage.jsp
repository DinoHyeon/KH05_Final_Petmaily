<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
<title>로그인</title>
<style>
/* 타이틀 JOIN 텍스트 */
#title h1 {
	top: 16.5%;
	left: 12%;
	margin: 50px 0px 40px 0px;
	text-align: center;
	color: gray;
	font-weight: 700;
	font-size: 30;
	position: absolute;
}
/* 페이지 안내 문구 */
.login h5 {
	text-align: right;
	position: absolute;
}

#h5_1 {
	top: 27%;
	left: 74%;
	color: black;
	font-weight: 700;
	font-size: 14;
}

#h5_2 {
	top: 64%;
	left: 43%;
	color: black;
	font-size: 12;
}

#h5_3 {
	top: 79.5%;
	left: 41.5%;
	color: black;
	font-size: 14;
}

/* hr 선 설정 */
.login #hr1 {
	border: none;
	width: 1250px;
	border: 1px solid gray;
	color: gray; /* IE */
	border-color: gray; /* 사파리 */
	background-color: gray; /* 크롬, 모질라 등, 기타 브라우저 */
	position: absolute;
	left: 10%;
	top: 31.5%;
}

.login #hr2 {
	border: none;
	width: 1250px;
	border: 1px solid gray;
	color: gray; /* IE */
	border-color: gray; /* 사파리 */
	background-color: gray; /* 크롬, 모질라 등, 기타 브라우저 */
	position: absolute;
	left: 10%;
	top: 74%;
}

#loginTable {
	border: none;
	border-collapse: collapse;
	padding: 7px 15px;
	position: absolute;
	margin: auto auto 150px auto;
	width: 600px;
	left: 27%;
	top: 43%;
}

#loginTable tr {
	border: none;
	border-collapse: collapse;
	padding: 7px 15px;
}

#loginTable th {
	border: none;
	border-collapse: collapse;
	margin: auto 20px auto auto;
	padding: 7px 15px;
	text-align: right;
	color: black;
	opacity: 0.9;
	font-weight: 700;
	width: 250px;
}

#loginTable td {
	border: none;
	border-collapse: collapse;
	padding: 5px 10px;
	text-align: left;
}
/* input박스 스타일 */
.inp {
	width: 200px;
	height: 50px;
}
/* 버튼 스타일(너비, 높이, 폰트두께는 따로 줘야합니다!) */
.btn {
	position: relative;
	font-size: 14;
	text-align: center;
	margin: auto 10px auto 0;
	padding: 5px 0 5px 0;
	/* 버튼 색 설정(컬러코드 출처: https://html-color-codes.info/Korean/  ) */
	/* 초록색 버튼
   border-top:1.5px solid #04B431;
   border-right:1.5px solid #088A29;
   border-bottom:1.5px solid #088A29;
   border-left:1.5px solid #04B431; 
   background-color: #04B431;
    */
	/* 파란색 버튼
   border-top:1.5px solid #2E9AFE;
   border-right:1.5px solid #0080FF;
   border-bottom:1.5px solid #0080FF;
   border-left:1.5px solid #2E9AFE; 
   background-color: #2E9AFE;
    */
	/* 주황색 버튼 
   border-top:1.5px solid #FE9A2E;
   border-right:1.5px solid #FF8000;
   border-bottom:1.5px solid #FF8000;
   border-left:1.5px solid #FE9A2E; 
   background-color: #FE9A2E;
    */
	/* 버튼 모서리 둥글게(픽셀 클수록 더 둥글어짐) */
	border-radius: 5px;
	color: white;
	cursor: pointer;
}
/* 로그인 버튼 */
#loginBtn {
	font-weight: 800;
	width: 100px;
	height: 120px;
	border-top: 1.5px solid #04B431;
	border-right: 1.5px solid #088A29;
	border-bottom: 1.5px solid #088A29;
	border-left: 1.5px solid #04B431;
	background-color: #04B431;
}
/* 아이디/ 비밀번호 찾기 버튼 */
#searchBtn {
	font-weight: 600;
	position: absolute;
	top: 65%;
	left: 57%;
	width: 100px;
	height: 50px;
	border-top: 1.5px solid #2E9AFE;
	border-right: 1.5px solid #0080FF;
	border-bottom: 1.5px solid #0080FF;
	border-left: 1.5px solid #2E9AFE;
	background-color: #2E9AFE;
}
/* 회원가입 버튼 */
#joinBtn {
	font-weight: 800;
	position: absolute;
	top: 80%;
	left: 57%;
	width: 100px;
	height: 60px;
	border-top: 1.5px solid #FE9A2E;
	border-right: 1.5px solid #FF8000;
	border-bottom: 1.5px solid #FF8000;
	border-left: 1.5px solid #FE9A2E;
	background-color: #FE9A2E;
}

#loginFail {
	color: red;
	display: none;
	position: absolute;
	font-size: 14px;
	top: 59.5%;
	left: 38.5%;
}
</style>
</head>
<body>
	<jsp:include page="mainFrame.jsp" />
	<div class="login">
		<div id="title">
			<h1 style="font-size: 50">로그인</h1>
			<h5 id="h5_1">등록된 회원 정보로 로그인 합니다</h5>
		</div>
		<hr id="hr1" />

		<form action="loginConfirmPage" method="post">
			<table id="loginTable">
				<tr>
					<th style="font-size: 20">아이디</th>
					<td><input type="text" class="inp" name="id"
						placeholder="아이디 입력" maxlength="20" /></td>
					<td rowspan="2"><button class="btn" id="loginBtn">로그인</button></td>
				</tr>
				<tr>
					<th style="font-size: 20">비밀번호</th>
					<td><input type="password" class="inp" name="pw"
						placeholder="비밀번호 입력" maxlength="20" /></td>
				</tr>
			</table>
			<h5 id="h5_2">아이디/ 비밀번호를 잊어버리셨나요?</h5>
			<hr id="hr2" />
			<input type="button" class="btn" id="searchBtn"
				onclick="location.href='loginSearchPage'" value="ID/PW 찾기" />
			<h5 id="h5_3">아직 Petmily의 회원이 아니신가요?</h5>
			<input type="button" class="btn" id="joinBtn"
				onclick="location.href='joinPage'" value="회원 가입" />
			<h2 id="loginFail">&nbsp;&nbsp;아이디 또는 비밀번호가 올바르지 않습니다 다시 입력하세요.</h2>
		</form>

	</div>

</body>
<script>
	
		var msg = "${msg}";
		var loginId = "${loginId}";
	    var loginChk = "${loginChk}";
	    var confirm = "${confirm}";
	
		if(msg=="fail"){
			var loginFail = document.getElementById("loginFail");

			loginFail.style.display = "block";
		} else if(msg=="out"){
			$("#loginFail").html("&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp관리자로부터 추방된 회원입니다.");
			$("#loginFail").show();
		}
		
		
	    if(loginChk != null && confirm == 1){
	        alert(loginChk);
	     }
	</script>
</html>










