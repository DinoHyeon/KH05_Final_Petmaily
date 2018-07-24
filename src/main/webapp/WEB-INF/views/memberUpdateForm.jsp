<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri ="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
		<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
		<title>회원정보 수정</title>		
		<style>
		#contentFrame {
   position: absolute;
   left: 15.52%;
   top: 12.5%;
   width: 82.95%;
   height: 95%;
   background: white;
}

#sideFrame {
	position: absolute;
	left: 0.52%;
	top: 12.4%;
	width: 14.7%;
	height: 150%;
	border-right: 1px solid gray;
	border-left: 1px solid gray;
}
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
				padding: 20px 600px 5px 740px;
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
			
			#joinEmailName{
				width: 100px;
			}
			
			#joinEmailAddr{
				width: 110px;
			}
		</style>
	</head>
	<body>
		<jsp:include page="mainFrame.jsp" />
		<div id="sideFrame"></div>
   <jsp:include page="sideMenu.jsp" />
   <div id="contentFrame">
		<h3>회원정보 수정</h3>
		<hr>
	
		<form id="memberUpdateFinal" action="memberUpdatePage" method="post">
			<table>
			<c:forEach items = "${memberInfo}" var = "dto">
				<tr>
					<th>이름</th>
					<td colspan="3">${dto.member_name}</td>
				</tr>
				<tr>
					<th>ID</th>
					<td>${dto.member_id}</td>
				</tr>
				<tr>
					<th>PW</th>
					<td colspan="3"><input type="password" id="joinPw" name="pw" placeholder="비밀번호 입력" maxlength="20" /></td>
				</tr>
				<tr>
					<th>PW&nbsp;CHECK</th>
					<td><input type="password" id="joinPwChk" name="pwChk" placeholder="비밀번호 확인" maxlength="20" /></td>
					<td><input type="button" id="pwChk" style="width:80pt; height:20pt;" value="비밀번호확인"></td>
				</tr>
				<tr>
					<th>E-MAIL</th>
					<td>${dto.member_email}</td>
				</tr>
				<tr>
					<th>PHONE</th>
					<td colspan="3"><input type="text" id="joinPhone" name="phone" placeholder="휴대폰번호 입력" maxlength="20" /></td>
				</tr>
				<tr>
					<th>ADDRESS</th>
					<td><input type="text" name="address" id="joinAddress" placeholder="주소 입력" style="margin: 4 0 4 0" readOnly></td> 
					<td><input type="button" id="path" onclick="sample4_execDaumPostcode()" style="width:80pt; height:20pt;" value="주소 찾기"></td>
					<td><input class="inp" type="text" id="sample4_postcode" placeholder="우편번호" style="margin: 4 0 4 0"></td>
					<td><input class="inp" type="text" id="sample4_jibunAddress" placeholder="지번주소" style="margin: 4 0 4 0"></td>
					<td><span class="inp" id="guide" style="color: #999"></span></td>
				</tr>
				</c:forEach>
			</table>					
			<input type="button" onclick="joinChk()" id="joinBtn" value="수정하기"/>
		</form>
		</div>
	</body>
	<script>
	var menuName = {
			'내정보' : 'memberUpdateForm',
			'내가작성한모금게시글' : 'mylist',
			'즐겨찾기' : 'likelist'
		};
		var idChk = 0;
		var pwChk = 0;
		var emailChk = 0;
		
		$(document).ready(function() {

			var content = "";
			for ( var key in menuName) {
				console.log(key);
				content += "<div class='menuName'";
				content += "style='"
				if (key == '내정보') {
					content += "background:#28977B;color:white;font-weight: 600;";
				}
				content += "cursor: pointer'";
				content += "onclick='pageMove(this)' id=" + menuName[key] + ">";
				content += key;
				content += "</div>";
			}
			;

			$("#sideMenu").empty();
			$("#sideMenu").append(content);
		});

		function pageMove(e) {
			console.log($(e).attr("id"));
			location.href = "./" + $(e).attr("id");
		};
		
		function joinChk(){
			if(pwChk == 0){
				$("#joinPwChk").focus();
				alert("비밀번호를 확인해주세요.");
			} else{ 
				$("#memberUpdateFinal").submit();
				alert("수정이 완료되었습니다.");
			}
		}
		
		$(function() {
		    $("#pwChk").click(function() { 
				if($("#joinPw").val() == $("#joinPwChk").val()){
					alert("비밀번호을 확인했습니다.");
					$('#joinPw').prop('readonly', true);
					$('#joinPwChk').prop('readonly', true);
					pwChk = 1;
				} else{
					alert("비밀번호가 같지 않습니다. 다시 적어주세요.");
				}
		    });
		});
		
		function sample4_execDaumPostcode() {
			new daum.Postcode({
				oncomplete : function(data) {
					var fullRoadAddr = data.roadAddress; 
					var extraRoadAddr = ''; 
					
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraRoadAddr += data.bname;
					}
					
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
					}
					
					if (extraRoadAddr !== '') {
						extraRoadAddr = ' (' + extraRoadAddr + ')';
					}
					
					if (fullRoadAddr !== '') {
						fullRoadAddr += extraRoadAddr;
					}
					
					document.getElementById('sample4_postcode').value = data.zonecode; 
					document.getElementById('joinAddress').value = fullRoadAddr;
					document.getElementById('sample4_jibunAddress').value = data.jibunAddress;
					
					if (data.autoRoadAddress) {
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
	</script>
</html>










