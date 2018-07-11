<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri ="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
		<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
		<title>ID/PW 찾기</title>		
		<style>
			h3{
				padding: 150px 600px 5px 600px;
			}
			
			#pwSearch{
				padding-top: 50px;
			}
			
			table{
			padding:  10px 600px 5px 650px;
			}
			
			th, td{
				border : 1px solid black;
				border-collapse : collapse;
				padding : 7px 15px;
			
				border-right:none;
				border-left:none;
				border-top:none;
				border-bottom:none;
			}
			
		</style>
	</head>
	<body>
		<jsp:include page="mainFrame.jsp" />
		<h3>ID&nbsp;찾기</h3>
		<form action="" method="post">
			<table>
				<tr>
					<td><input type="text" id="nameSearch" name="name" placeholder="이름 입력" maxlength="20" /></td>
				</tr>
				<tr>
					<td><input type="text" id="emailSearch" name="email" placeholder="아메일 입력" maxlength="20" /></td>
				</tr>
				<tr>
					<td><input type="text" id="phoneSearch" name="phone" placeholder="휴대폰번호 입력" maxlength="20" /></td>
				</tr>
				<tr>
					<td></td>
					<td><input type="button" id="idSearchBtn" value="아이디 찾기"/></td>
				</tr>
			</table>
		</form>
		<form action="" method="post">
			<hr>
			<h3 id="pwSearch">PW&nbsp;찾기</h3>
			<table>
				<tr>
					<td><input type="text" id="idSearch" name="id" placeholder="아이디 입력" maxlength="20" /></td>
				</tr>
				<tr>
					<td><input type="text" id="pwEmailSearch" name="pwEmail" placeholder="아메일 입력" maxlength="20" /></td>
					<td><input type="button" id="emailSend" value="인증번호 발송"/></td>
				</tr>
				<tr>
					<td><input type="text" name="pwEmailNumSearch" placeholder="인증번호 입력" maxlength="20" /></td>
					<td><input type="button" id="emailNumConfirm" value="인증번호 확인"/></td>
				</tr>
				<tr>
					<td></td>
					<td><input type="button" id="pwSearchBtn" value="비밀번호 찾기"/></td>
				</tr>
			</table>
		</form>
		<hr>
	</body>
	<script>
	var pwConfirm = 0;
	$(function() {
	    $("#emailNumConfirm").click(function() { 
	   		var pwConfirmNum = $("#pwEmailNumSearch").val();
	  
	    	$.ajax({
	            async: true,
	            type : 'POST',
	            url : "pwConfirmNum",
	            data : {"pwConfirmNum" : pwConfirmNum},
	            dataType : "json",
	            contentType: "application/json; charset=UTF-8",
	            success : function(data) {
	            	 if (data.cnt > 0) {
	            		 alert("인증이 완료되었습니다.");
	                     $('#pwEmailNumSearch').prop('readonly', true);
	                     pwConfirm = 1;
	                 } else {
	                	 alert("인증번호를 다시 확인해주세요.");
	                     $("#pwEmailNumSearch").focus();
	                 }
	            },
	            error : function(error) {
	            	alert("인증번호를 다시 확인해주세요.");
	            }
	        });
	    });
	});
	
	$(function() {
	    $("#emailSend").click(function() {
	    	var email = $("#pwEmailSearch").val();
			
			$.ajax({
	            async: true,
	            type : 'POST',
	            data : email,
	            url : "pwSearchChkPage",
	            dataType : "json",
	            contentType: "application/json; charset=UTF-8",
	            success : function(data) {
	            	alert("인증번호를 발송했습니다.");
	            },
	            error : function(error) {
	            	alert("인증번호 발송에 실패했습니다.");
	            }
	        });
	    });
	});
	
	var pwSearchChk = 0;
	$(function() {
	    $("#pwSearchBtn").click(function() {
	    	if($("#idSearch").val() == ""){
				$("#idSearch").focus();
				alert("아이디를 적어주세요.");
			} else if($("#pwEmailSearch").val() == ""){
				$("#pwEmailSearch").focus();
				alert("이메일을 적어주세요.");
			} else if($("#pwEmailNumSearch").val() == ""){
				$("#pwEmailNumSearch").focus();
				alert("인증번호를 적어주세요.");
			} else if(pwSearchChk == 0){
				alert("인증번호를 확인해주세요.");
			} else{
				 var id=  $("#idSearch").val(); 
				 var pwEmail=  $("#pwEmailNumSearch").val(); 
				 
		        $.ajax({
		            type : 'get',
		            url : "pwSearchPage",
		            data : {"id": id, "pwEmail": pwEmail},		            
		            dataType : "json",	
		            contentType: "application/json; charset=UTF-8",
		            success : function(data) {
		            	alert("ㅇㅇㅇㅇ");
		            	pwSearchChk = 1;
		            },
		            error : function(error) {
		                alert("입력해주세요.");
		            }
		        });
			}
	    });
	});
	
	$(function() {
	    $("#idSearchBtn").click(function() {
	    	if($("#nameSearch").val() == ""){
				$("#nameSearch").focus();
				alert("이름을 적어주세요.");
			} else if($("#emailSearch").val() == ""){
				$("#emailSearch").focus();
				alert("이메일을 적어주세요.");
			} else if($("#phoneSearch").val() == ""){
				$("#phoneSearch").focus();
				alert("휴대폰번호를 적어주세요.");
			} else{
				 var name=  $("#nameSearch").val(); 
				 var email=  $("#emailSearch").val(); 
				 var phone=  $("#phoneSearch").val(); 
				 
		        $.ajax({
		            type : 'get',
		            url : "idSearchPage",
		            data : {"name": name, "email": email, "phone": phone},		            
		            dataType : "json",	
		            contentType: "application/json; charset=UTF-8",
		            success : function(data) {
		            	 alert(data.findId);
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










