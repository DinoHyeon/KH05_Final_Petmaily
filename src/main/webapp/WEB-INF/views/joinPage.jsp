<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri ="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
		<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
		<title>회원가입</title>		
		<style>
			input[type='text']{
				width: 250px;
			}
			
			input[type='password']{
				width: 250px;
			}
		
			form{
				padding: 10px 600px;
			}
			
			table, th, td{
				border : 1px solid black;
				border-collapse : collapse;
				padding : 7px 15px;
			
				border-right:none;
				border-left:none;
				border-top:none;
				border-bottom:none;
			}
			
			h3{
				color: gray;
				padding: 150px 600px 5px 600px;
			}
		
			button{
				width: 70pt;
				height: 20pt;
			}
			
			#loginFail{
				color: red;
				display: none;
			}
			
			#joinBtn{
				margin-top: 20px;
				margin-left: 410px;
			} 
			
			.inp {
				display: none;
			}
			
			#emailConfirm1{
				width: 100px;
			}
			
			#emailConfirm2{
				width: 110px;
			}
			

		</style>
	</head>
	<body>
		<jsp:include page="mainFrame.jsp" />
		<h3>JOIN</h3>
		<hr>

		<form id="joinConfirm" action="joinConfirmPage" method="post">
			<table>
				<tr>
					<th>이름</th>
					<td colspan="3"><input type="text" id="nameConfirm" name="name" placeholder="이름 입력" maxlength="20" /></td>
				</tr>
				<tr>
					<th>ID</th>
					<td><input type="text" id="idConfirm" name="id" placeholder="아이디 입력" maxlength="20" /></td>
					<td><input type="button" id="idChkPage" style="width:80pt; height:20pt;" value="중복확인"></td>
				</tr>
				<tr>
					<th>PW</th>
					<td colspan="3"><input type="password" id="pwConfirm" name="pw" placeholder="비밀번호 입력" maxlength="20" /></td>
				</tr>
				<tr>
					<th>PW&nbsp;CHECK</th>
					<td><input type="password" id="pwChkConfirm" name="pwChk" placeholder="비밀번호 확인" maxlength="20" /></td>
					<td><input type="button" id="pwChkPage" style="width:80pt; height:20pt;" value="비밀번호확인"></td>
				</tr>
				<tr>
					<th>E-MAIL</th>
					<td>
						<input type="text" id="emailConfirm1" name="emailName" placeholder="이메일 입력" maxlength="20" />&nbsp;&nbsp;@&nbsp;
						<input type="text" id="emailConfirm2" name="emailAddr" placeholder="이메일 주소 입력" maxlength="20" />
					</td>
					<td colspan="2"><input type="button" id="emailSend" style="width:80pt; height:20pt;" value="인증번호 발송"></td>
				</tr>
				<tr>
					<th></th>
					<td><input type="text" id="emailConfirmNum" name="emailChk" placeholder="인증번호 입력" maxlength="20" /></td>
					<td colspan="2"><input type="button" id="emailConfirm" style="width:80pt; height:20pt;" value="인증번호 확인"></td>
				</tr>
				<tr>
					<th>PHONE</th>
					<td colspan="3"><input type="text" id="phoneConfirm" name="phone" placeholder="휴대폰번호 입력" maxlength="20" /></td>
				</tr>
				<tr>
					<th>ADDRESS</th>
					<td><input type="text" name="address" id="sample4_roadAddress" placeholder="주소 입력" style="margin: 4 0 4 0" readOnly></td> 
					<td><input type="button" id="path" onclick="sample4_execDaumPostcode()" style="width:80pt; height:20pt;" value="주소 찾기"></td>
					<td><input class="inp" type="text" id="sample4_postcode" placeholder="우편번호" style="margin: 4 0 4 0"></td>
					<td><input class="inp" type="text" id="sample4_jibunAddress" placeholder="지번주소" style="margin: 4 0 4 0"></td>
					<td><span class="inp" id="guide" style="color: #999"></span></td>
				</tr>
			</table>					
			<input type="button" onclick="joinChk()" id="joinBtn" value="가입하기"/>
		</form>
	</body>
	<script>
		var idChk = 0;
		var pwChk = 0;
		var emailChk = 0;
		
		var joinMsg = "${joinMsg}";
		
		
		function joinChk(){
			if($("#nameConfirm").val() == ""){
				$("#nameConfirm").focus();
				alert("이름을 적어주세요.");
			} else if($("#idConfirm").val() == ""){
				$("#idConfirm").focus();
				alert("아이디를 적어주세요.");
			} else if(idChk == 0){
				$("#idConfirm").focus();
				alert("중복확인을 해주세요.");
			} else if($("#pwConfirm").val() == ""){
				$("#pwConfirm").focus();
				alert("비밀번호를 적어주세요.");
			} else if(pwChk == 0){
				$("#pwChkConfirm").focus();
				alert("비밀번호를 확인해주세요.");
			} else if($("#emailConfirm1").val() == ""){
				$("#emailConfirm1").focus();
				alert("이메일을 적어주세요.");
			} else if($("#emailConfirm2").val() == ""){
				$("#emailConfirm2").focus();
				alert("이메일을 적어주세요.");
			} else if($("#emailConfirmNum").val() == ""){
				$("#emailConfirmNum").focus();
				alert("인증번호를 입력해주세요.");
			} else if(emailChk == 0){
				alert("인증번호를 다시 확인해주세요");
			} else if($("#phoneConfirm").val() == ""){
				$("#phoneConfirm").focus();
				alert("휴대폰번호를 적어주세요.");
			} else if($("#sample4_roadAddress").val() == ""){
				$("#sample4_roadAddress").focus();
				alert("주소를 적어주세요.");
			} else{
				$("#joinConfirm").submit();
				alert(joinMsg);
			}
		}
		
		$(function() {
		    $("#pwChkPage").click(function() { 
		    	console.log($("#pwConfirm").val());
				console.log($("#pwChkPage").val());
				
				if($("#pwConfirm").val() == $("#pwChkConfirm").val()){
					alert("비밀번호을 확인했습니다.");
					pwChk = 1;
					$('#pwConfirm').prop('readonly', true);
					$('#pwChkConfirm').prop('readonly', true);
				} else{
					alert("비밀번호가 같지 않습니다. 다시 적어주세요.");
				}
		    });
		});
		
		function sample4_execDaumPostcode() {
			new daum.Postcode({
				oncomplete : function(data) {
					// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
					// 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
					// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
					var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
					var extraRoadAddr = ''; // 도로명 조합형 주소 변수
					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraRoadAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
					}
					// 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
					if (extraRoadAddr !== '') {
						extraRoadAddr = ' (' + extraRoadAddr + ')';
					}
					// 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
					if (fullRoadAddr !== '') {
						fullRoadAddr += extraRoadAddr;
					}
					// 우편번호와 주소 정보를 해당 필드에 넣는다.
					document.getElementById('sample4_postcode').value = data.zonecode; //5자리 새우편번호 사용
					document.getElementById('sample4_roadAddress').value = fullRoadAddr;
					document.getElementById('sample4_jibunAddress').value = data.jibunAddress;
					// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
					if (data.autoRoadAddress) {
						//예상되는 도로명 주소에 조합형 주소를 추가한다.
						var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
						document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
					} else if (data.autoJibunAddress) {
						var expJibunAddr = data.autoJibunAddress;
						document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
					} else {
						document.getElementById('guide').innerHTML = '';
					}
				}
			}).open();
		}
	
		$(function() {
		    $("#idChkPage").click(function() {
		  
		        var userId=  $("#idConfirm").val(); 
		        
		        $.ajax({
		            async: true,
		            type : 'POST',
		            data : userId,
		            url : "idChkPage",
		            dataType : "json",
		            contentType: "application/json; charset=UTF-8",
		            success : function(data) {
		            	 if (data.cnt > 0) {
		                     alert("아이디가 존재합니다. 다른 아이디를 입력해주세요.");
		                     $("#idConfirm").focus();
		                 } else {
		                     alert("사용가능한 아이디입니다.");
		                     $("#pwConfirm").focus();
		                     $('#idConfirm').prop('readonly', true);
		                     idChk = 1;
		                 }
		            },
		            error : function(error) {
		                alert("입력해주세요.");
		            }
		        });
		    });
		});
		
		$(function() {
		    $("#emailSend").click(function() {
		    	var emailName = $("#emailConfirm1").val();
				var emailAddr = $("#emailConfirm2").val();
				var email = emailName+"@"+emailAddr;
				
				$.ajax({
		            async: true,
		            type : 'POST',
		            data : email,
		            url : "emailChkPage",
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
		
		$(function() {
		    $("#emailConfirm").click(function() { 
		   		var confirmNum = $("#emailConfirmNum").val();
				
		    	$.ajax({
		            async: true,
		            type : 'POST',
		            data : confirmNum,
		            url : "confirmNumChkPage",
		            dataType : "json",
		            contentType: "application/json; charset=UTF-8",
		            success : function(data) {
		            	 if (data.cnt > 0) {
		                     alert("인증이 완료되었습니다.");
		                     $("#phoneConfirm").focus();
		                     $('#emailConfirmNum').prop('readonly', true);
		                     emailChk = 1;
		                 } else {
		                	 alert("인증번호를 다시 확인해주세요.");
		                     $("#emailConfirmNum").focus();
		                 }
		            },
		            error : function(error) {
		            	alert("인증번호를 다시 확인해주세요.");
		            }
		        });
		    });
		});
	</script>
</html>










