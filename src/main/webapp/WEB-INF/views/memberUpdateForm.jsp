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
#title h1 {
   top: 17%;
   left: 13%;
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
   left: 82%;
   text-align: right;
   color: black;
   font-weight: 700;
   font-size: 14;
   position: absolute;
}
/* hr 선 설정 */
.join hr {
   border: none;
   width: 1300px;
   border: 1px solid gray;
   color: gray; /* IE */
   border-color: gray; /* 사파리 */
   background-color: gray; /* 크롬, 모질라 등, 기타 브라우저 */
   position: absolute;
   left: 10%;
   top: 33%;
}

#update {
   border: none;
   border-collapse: collapse;
   padding: 7px 15px;
   position: absolute;
   margin: auto auto 150px auto;
   width: 1000px;
   left: 28%;
   top: 40%;
}

#update tr {
   border: none;
   border-collapse: collapse;
   padding: 7px 15px;
}

#update th {
   border: none;
   border-collapse: collapse;
   margin: auto 20px auto auto;
   padding: 7px 15px;
   text-align: right;
   color: black;
   opacity: 0.9;
   font-weight: 700;
   width: 150px;
}

#update td {
   border: none;
   border-collapse: collapse;
   padding: 7px 1px;
   text-align: left;
}
/* input박스 스타일 */
.inp {
   width: 400px;
   height: 40px;
}
/* 버튼 스타일 */
.btn {
   height: 45px;
   width: 120px;
   font-weight: 800;
   font-size: 14;
   text-align: center;
   margin: auto 10px auto 10px;
   padding: 5px 0 5px 0;
   border: 2.5px solid white;
   background-color: #28977B;
   color: white;
   cursor: pointer;
}

.inp2 {
   display: none;
}

#loginFail {
   color: red;
   display: none;
}

#btn2 {
    position: absolute;
    top: 85%;
    left: 46%;
}

#btn3 {
   position: absolute;
    top: 85%;
    left: 54%;
}
		</style>
	</head>
	<body>
   <div class="join">
      <jsp:include page="mainFrame.jsp" />
<div id="sideFrame"></div>
   <jsp:include page="sideMenu.jsp" />
   <div id="contentFrame">
      <div id="title">
         <h1 style="font-size: 50">회원 정보 수정</h1>
         <h5>회원 정보를 등록합니다</h5>
      </div>
      <hr>


      <form id="memberUpdateFinal" action="memberUpdatePage" method="post">
         <table id="update">
            <c:forEach items="${memberInfo}" var="dto">
               <tr>
                  <th>이름</th>
                  <td>${dto.member_name}</td>
               </tr>
               <tr>
                  <th>ID</th>
                  <td>${dto.member_id}</td>
               </tr>
               <tr>
                  <th>PW</th>
                  <td><input type="password" id="joinPw" name="pw" class="inp"
                     placeholder="비밀번호 입력" maxlength="20" /></td>
               </tr>
               <tr>
                  <th>PW&nbsp;CHECK</th>
                  <td><input type="password" id="joinPwChk" name="pwChk"
                     class="inp" placeholder="비밀번호 확인" maxlength="20" /> <input
                     type="button" id="pwChk" class="btn" value="비밀번호확인"></td>
               </tr>
               <tr>
                  <th>E-MAIL</th>
                  <td>${dto.member_email}</td>
               </tr>
               <tr>
                  <th>PHONE</th>
                  <td><input type="text" id="joinPhone" name="phone"
                     class="inp" placeholder="휴대폰번호 입력" maxlength="20" /></td>
               </tr>
               <tr>
                  <th>ADDRESS</th>
                  <td><input type="text" name="address" id="joinAddress"
                     class="inp" placeholder="주소 입력" style="margin: 4 0 4 0" readOnly>
                     <input type="button" id="path" class="btn"
                     onclick="sample4_execDaumPostcode()" value="주소 찾기"> <input
                     class="inp2" type="text" id="sample4_postcode" placeholder="우편번호"
                     style="margin: 4 0 4 0"> <input class="inp2" type="text"
                     id="sample4_jibunAddress" placeholder="지번주소"
                     style="margin: 4 0 4 0"> <span class="inp2" id="guide"
                     style="color: #999"></span></td>
               </tr>
            </c:forEach>
         </table>
         <input type="button" class="btn" id="btn2" onclick="joinChk()"
            id="joinBtn" value="수정하기" />
      </form>
      <form action="deleteUpdate" method="post">
         <input type="submit" class="btn" id="btn3" id="deleteBtn"
            value="탈퇴하기" />
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










