<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri ="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
		<title>회원정보 수정 확인</title>		
		<style>
			form{
				padding: 10px 600px;
			}

			h3{
				padding: 20px 600px 5px 740px;
			}
			
			button{
				width: 70pt;
				height: 20pt;
			}
		</style>
	</head>
	<body>
		<jsp:include page="mainFrame.jsp" />
		<h3>비밀번호 확인</h3>
		<hr>
		
		<form action="">
			<table>
				<tr>
					<th>PW</th>
					<td><input type="password" id="confirmPw" name="pw" placeholder="비밀번호 입력" maxlength="20" /></td>
				</tr>
			</table>
			<input type="button" id="updateBtn" value="회원정보 수정" />
		</form>
	</body>
	<script>
		$(function() {
			$("#updateBtn").click(function() {
				if($("#confirmPw").val() == ""){
					$("#confirmPw").focus();
					alert("비밀번호를 적어주세요.");
				} else{
					var confirmPw = $("#confirmPw").val();
	
					$.ajax({
						async : true,
						type : 'POST',
						data : confirmPw,
						url : "memberUpdateConfirm",
						dataType : "json",
						contentType : "application/json; charset=UTF-8",
						success : function(data) {
							if (data.pwChkCnt == 1) {
								alert("비밀번호가 확인되었습니다.");
								location.href='memberUpdateForm' 
							} else {
								alert("없는 비밀번호 입니다.");
							}
						},
						error : function(error) {
							alert("입력해주세요.");
						}
					});	
				}
			});
		});
	</script>
</html>










