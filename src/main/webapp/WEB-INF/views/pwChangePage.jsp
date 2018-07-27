<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
<title>비밀번호 변경</title>
<style>
/* 타이틀 JOIN 텍스트 */
#ChangeBtn {
	margin-top: 370px;
	margin-left: 867px;
}

#title h1 {
	top: 17%;
	left: 18%;
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
.pwChange hr {
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

#pwTable {
	border: none;
	border-collapse: collapse;
	padding: 7px 15px;
	position: absolute;
	margin: auto auto 150px auto;
	width: 600px;
	left: 27%;
	top: 50%;
}

#pwTable tr {
	border: none;
	border-collapse: collapse;
	padding: 7px 15px;
}

#pwTable th {
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

#pwTable td {
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
</style>
</head>
<body>
	<jsp:include page="mainFrame.jsp" />
	<div class="pwChange">
		<div id="title">
			<h1 style="font-size: 50">비밀번호 변경</h1>
			<h5>비밀번호를 변경합니다.</h5>
		</div>
		<hr />

		<form id="SearchPage" action="changePwPage" method="post">
			<table id="pwTable">
				<tr>
					<th style="font-size: 20">PW</th>
					<td colspan="3"><input type="password" class="inp"
						id="changePw" name="pw" placeholder="비밀번호 입력" maxlength="20" /></td>
				</tr>
				<tr>
					<th style="font-size: 20">PW&nbsp;CHECK</th>
					<td><input type="password" class="inp" id="changePwChk"
						name="pwChk" placeholder="비밀번호 확인" maxlength="20" /></td>
					<td><input type="button" id="pwChangeChk" class="btn"
						value="비밀번호확인"></td>
				</tr>
			</table>
			<input type="hidden" id="findId" name="changeId" /> <input
				type="button" class="btn" id="ChangeBtn" value="변경하기" />
		</form>
	</div>
</body>
<script>
      var msg = "${msg}";
      var pwChangeChk = 0;
      var changeMsg = "${changeMsg}";
      
      if(changeMsg=="fail"){
         alert("변경에 실패했습니다.");
      }
      
      $("#findId").val(msg);
      
      $(function() {
          $("#pwChangeChk").click(function() { 
            if($("#changePw").val() == $("#changePwChk").val()){
               alert("비밀번호을 확인했습니다.");
               $('#changePw').prop('readonly', true);
               $('#changePwChk').prop('readonly', true);
               pwChangeChk = 1;
            } else{
               alert("비밀번호가 같지 않습니다. 다시 적어주세요.");
            }
          });
      });
   
      $(function() {
         $("#ChangeBtn").click(function() {
            if ($("#changePw").val() == "") {
               $("#changePw").focus();
               alert("비밀번호를 적어주세요.");
            } else if ($("#changePwChk").val() == "") {
               $("#changePwChk").focus();
               alert("비밀번호를 확인해주세요.");
            } else if (pwChangeChk == 0) {
               $("#changePwChk").focus();
               alert("비밀번호를 확인해주세요.");
            } else {
               
               console.log($("#findId").val());
               console.log($("#changePw").val());
               
               $("#SearchPage").submit();
            }
         });
      });
   </script>
</html>









