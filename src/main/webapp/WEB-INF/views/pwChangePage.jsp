<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri ="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
		<title>비밀번호 변경</title>		
		<style>
			input[type='password']{
				width: 250px;
			}
		
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
				padding: 20px 600px 5px 740px;
			}
			
			button{
				width: 70pt;
				height: 20pt;
			}
			
			#ChangeBtn{
				margin-top: 20px;
				margin-left: 410px;
			} 
			
		</style>
	</head>
	<body>
		<jsp:include page="mainFrame.jsp" />
		<h3>LOGIN</h3>
		<hr>

		<form id="SearchPage" action="changePwPage" method="post">
			<table>
				<tr>
					<th>PW</th>
					<td colspan="3"><input type="password" id="changePw" name="pw" placeholder="비밀번호 입력" maxlength="20" /></td>
				</tr>
				<tr>
					<th>PW&nbsp;CHECK</th>
					<td><input type="password" id="changePwChk" name="pwChk" placeholder="비밀번호 확인" maxlength="20" /></td>
					<td><input type="button" id="pwChangeChk" style="width:80pt; height:20pt;" value="비밀번호확인"></td>
				</tr>
			</table>
			<input type="hidden" id="findId" name="changeId"/>
			<input type="button" id="ChangeBtn" value="변경하기"/>
		</form>
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










