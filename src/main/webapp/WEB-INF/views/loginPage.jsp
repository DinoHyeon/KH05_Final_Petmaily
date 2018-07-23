<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri ="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
		<title>로그인</title>		
		<style>
			/* 타이틀 JOIN 텍스트 */
#title h1 {
   top: 17%;
   left: 12%;
   margin: 50px 0px 40px 0px;
   text-align: center;
   color: gray;
   font-weight: 700;
   font-size: 30;
   position: absolute;
}
/* 페이지 안내 문구 */
#title h5 {
   top: 28%;
   left: 74%;
   text-align: right;
   color: black;
   font-weight: 700;
   font-size: 14;
   position: absolute;
}
/* hr 선 설정 */
.login hr {
   border: none;
   width: 1250px;
   border: 1px solid gray;
   color: gray; /* IE */
   border-color: gray; /* 사파리 */
   background-color: gray; /* 크롬, 모질라 등, 기타 브라우저 */
   position: absolute;
   left: 10%;
   top: 33%;
}

#loginTable {
   border: none;
   border-collapse: collapse;
   padding: 7px 15px;
   position: absolute;
   margin: auto auto 150px auto;
   width: 600px;
   left: 27%;
   top: 50%;
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
   height: 40px;
}
/* 버튼 스타일 */
.btn {
   position: relative;
   height: 45px;
   width: 120px;
   font-weight: 800;
   font-size: 14;
   text-align: center;
   margin: auto 10px auto 0;
   padding: 5px 0 5px 0;
   border: 2.5px solid white;
   background-color: #28977B;
   color: white;
   cursor: pointer;
}

#loginFail {
   color: red;
   display: none;
   position:absolute;
   top:80%;
   left:29%;
}

		</style>
	</head>
	<body>
		 <jsp:include page="mainFrame.jsp" />
   <div class="login">
      <div id="title">
         <h1 style="font-size: 50">로그인</h1>
         <h5>등록된 회원 정보로 로그인 합니다</h5>
      </div>
      <hr />

      <form action="loginConfirmPage" method="post">
         <table id="loginTable">
            <tr>
               <th style="font-size: 20">아이디</th>
               <td><input type="text" class="inp" name="id"
                  placeholder="아이디 입력" maxlength="20" /></td>
               <td><button class="btn">로그인</button></td>
            </tr>
            <tr>
               <th style="font-size: 20">비밀번호</th>
               <td><input type="password" class="inp" name="pw"
                  placeholder="비밀번호 입력" maxlength="20" /></td>
               <td><input type="button" class="btn"
                  onclick="location.href='loginSearchPage'" value="ID/PW 찾기"></td>
            </tr>
         </table>
         <h2 id="loginFail">&nbsp;&nbsp;아이디 또는 비밀번호가 올바르지 않습니다 다시 입력하세요.</h2>
      </form>
      
   </div>

	</body>
	<script>
		var msg = "${msg}";
		var loginId = "${loginId}";
	
		if(msg=="fail"){
			var loginFail = document.getElementById("loginFail");
			
			loginFail.style.display = "block";
		}
	</script>
</html>










