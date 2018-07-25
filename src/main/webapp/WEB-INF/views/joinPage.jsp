<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<title>회원가입</title>
<style>
/* 타이틀 회원가입 텍스트 */
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

#joinTable {
   border: none;
   border-collapse: collapse;
   padding: 7px 15px;
   position: absolute;
   margin: auto auto 150px auto;
   width: 1000px;
   left: 20%;
   top: 48%;
}

#joinTable tr {
   border: none;
   border-collapse: collapse;
   padding: 7px 15px;
}

#joinTable th {
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

#joinTable td {
   border: none;
   border-collapse: collapse;
   padding: 7px 15px;
   text-align: left;
}
/* input박스 스타일 */
.inp {
   width: 200px;
   height: 40px;
}

.inp2 {
   display: none;
}
/* 버튼 스타일 */

.btn {
   position: relative;
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

#loginFail {
   color: red;
   display: none;
}

.inp3 {
   width: 300px;
   height: 40px;
}
</style>
</head>
<body>

   <div class="join">
      <jsp:include page="mainFrame.jsp" />
      <div id="title">
         <h1 style="font-size: 50">회원 가입</h1>
         <h5>회원 정보를 등록합니다</h5>
      </div>
      <hr>

      <form id="joinConfirm" action="joinConfirmPage" method="post">
         <table id="joinTable">
            <tr>
               <th>이름</th>
               <td><input type="text" class="inp" id="joinName" name="name"
                  placeholder="이름 입력" maxlength="20" /></td>
            </tr>
            <tr>
               <th>아이디</th>
               <td><input type="text" class="inp" id="joinId" name="id"
                  placeholder="아이디 입력" maxlength="20" /> <input type="button"
                  class="btn" id="idChk" style="margin: auto auto auto 33px"
                  value="중복확인"></td>
            </tr>
            <tr>
               <th>비밀번호</th>
               <td><input type="password" class="inp" id="joinPw" name="pw"
                  placeholder="비밀번호 입력" maxlength="20" /></td>
            </tr>
            <tr>
               <th>비밀번호 확인</th>
               <td><input type="password" class="inp" id="joinPwChk"
                  name="pwChk" placeholder="비밀번호 확인" maxlength="20" /> <input
                  type="button" class="btn" id="pwChk"
                  style="margin: auto auto auto 33px" value="비밀번호확인"></td>
            </tr>
            <tr>
               <th>이메일</th>
               <td><input type="text" class="inp" id="joinEmailName"
                  name="emailName" placeholder="이메일 입력" maxlength="20" />&nbsp;&nbsp;@&nbsp;
                  <input type="text" class="inp" id="joinEmailAddr" name="emailAddr"
                  placeholder="이메일 주소 입력" maxlength="20" /> <input type="button"
                  class="btn" id="joinEmailSend" value="인증번호 발송"></td>
            </tr>
            <tr>
               <th>이메일 인증</th>
               <td><input type="text" class="inp" id="joinEmailChk"
                  name="emailChk" placeholder="인증번호 입력" maxlength="20"
                  style="margin: auto auto auto 238px" /> <input type="button"
                  class="btn" id="joinEmailConfirm" value="인증번호 확인"></td>
            </tr>
            <tr>
               <th>전화번호</th>
               <td><input type="text" class="inp" id="joinPhone" name="phone"
                  placeholder="'-'없이 번호만 입력" maxlength="20" /></td>
            </tr>
            <tr style="margin: auto auto 20px auto">
               <th>주소</th>
               <td><input type="text" class="inp3" name="address"
                  id="joinAddress" placeholder="주소 입력" style="margin: 4 0 4 0"
                  readOnly> <input class="inp" type="text"
                  name="addressDetail" placeholder="상세주소 입력" style="margin: 4 0 4 0">
                  <input class="inp2" type="text" id="sample4_postcode"
                  placeholder="우편번호" style="margin: 4 0 4 0" readOnly> <input
                  class="inp2" type="text" id="sample4_jibunAddress"
                  placeholder="지번주소" style="margin: 4 0 4 0" readOnly> <input
                  type="button" class="btn" id="path"
                  onclick="sample4_execDaumPostcode()"
                  style="width: 80pt; height: 35pt;" value="주소 찾기"> <span
                  class="inp" id="guide" style="color: #999"></span></td>
            </tr>
            <tr>
               <td colspan="2"><input type="button" class="btn"
                  onclick="joinChk()" id="joinBtn" value="가입하기"
                  style="left: 84%; margin: 60px auto auto auto;" /> <input
                  type="button" class="btn" onclick="location.href='./' " value="취소"
                  style="left: 57%; margin: 60px auto auto auto;" /></td>
            </tr>
         </table>
      </form>
   </div>
</body>
<script>
   var idChk = 0;
   var pwChk = 0;
   var emailChk = 0;

   function joinChk() {
      if ($("#joinName").val() == "") {
         $("#joinName").focus();
         alert("이름을 적어주세요.");
      } else if ($("#joinId").val() == "") {
         $("#joinId").focus();
         alert("아이디를 적어주세요.");
      } else if (idChk == 0) {
         $("#joinId").focus();
         alert("중복확인을 해주세요.");
      } else if ($("#joinPw").val() == "") {
         $("#joinPw").focus();
         alert("비밀번호를 적어주세요.");
      } else if (pwChk == 0) {
         $("#joinPwChk").focus();
         alert("비밀번호를 확인해주세요.");
      } else if ($("#joinEmailName").val() == "") {
         $("#joinEmailName").focus();
         alert("이메일을 적어주세요.");
      } else if ($("#joinEmailAddr").val() == "") {
         $("#joinEmailAddr").focus();
         alert("이메일을 적어주세요.");
      } else if ($("#joinEmailChk").val() == "") {
         $("#joinEmailChk").focus();
         alert("인증번호를 입력해주세요.");
      } else if (emailChk == 0) {
         $("#joinEmailChk").focus();
         alert("인증번호를 다시 확인해주세요");
      } else if ($("#joinPhone").val() == "") {
         $("#joinPhone").focus();
         alert("휴대폰번호를 적어주세요.");
      } else if ($("#joinAddress").val() == "") {
         $("#joinAddress").focus();
         alert("주소를 적어주세요.");
      } else {
         $("#joinConfirm").submit();
         alert("회원가입이 완료되었습니다.");
      }
   }

   $(function() {
      $("#idChk").click(function() {
         var joinId = $("#joinId").val();
         $.ajax({
            async : true,
            type : 'POST',
            data : joinId,
            url : "idChkPage",
            dataType : "json",
            contentType : "application/json; charset=UTF-8",
            success : function(data) {
               if (data.idChkCnt == 1) {
                  alert("아이디가 존재합니다. 다른 아이디를 입력해주세요.");
                  $("#joinId").focus();
               } else {
                  alert("사용가능한 아이디입니다.");
                  $("#joinPw").focus();
                  $('#joinId').prop('readonly', true);
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
      $("#pwChk").click(function() {
         if ($("#joinPw").val() == $("#joinPwChk").val()) {
            alert("비밀번호를 확인했습니다.");
            $('#joinPw').prop('readonly', true);
            $('#joinPwChk').prop('readonly', true);
            pwChk = 1;
         } else {
            alert("비밀번호가 같지 않습니다. 다시 적어주세요.");
         }
      });
   });

   $(function() {
      $("#joinEmailSend").click(function() {
         var emailName = $("#joinEmailName").val();
         var emailAddr = $("#joinEmailAddr").val();
         var email = emailName + "@" + emailAddr;

         $.ajax({
            async : true,
            type : 'POST',
            data : email,
            url : "./joinEmailSendPage",
            dataType : "json",
            contentType : "application/json; charset=UTF-8",
            success : function(data) {
               alert(data.msg);
               $('#joinEmailName').prop('readonly', true);
               $('#joinEmailConfirm').prop('readonly', true);
            },
            error : function(error) {
               alert("다시 발송해주세요.");
            }
         });
      });
   });

   $(function() {
      $("#joinEmailConfirm").click(function() {
         var confirmNum = $("#joinEmailChk").val();

         $.ajax({
            async : true,
            type : 'POST',
            data : confirmNum,
            url : "joinEmailConfirmPage",
            dataType : "json",
            contentType : "application/json; charset=UTF-8",
            success : function(data) {
               if (data.emailChkCnt == 1) {
                  alert("인증이 완료되었습니다.");
                  $("#joinPhone").focus();
                  $('#joinEmailChk').prop('readonly', true);
                  emailChk = 1;
               } else {
                  alert("인증번호를 다시 확인해주세요.");
                  $("#joinEmailChk").focus();
               }
            },
            error : function(error) {
               alert("인증번호를 다시 확인해주세요.");
            }
         });
      });
   });

   function sample4_execDaumPostcode() {
      new daum.Postcode(
            {
               oncomplete : function(data) {
                  var fullRoadAddr = data.roadAddress;
                  var extraRoadAddr = '';

                  if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                     extraRoadAddr += data.bname;
                  }

                  if (data.buildingName !== '' && data.apartment === 'Y') {
                     extraRoadAddr += (extraRoadAddr !== '' ? ', '
                           + data.buildingName : data.buildingName);
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
                     var expRoadAddr = data.autoRoadAddress
                           + extraRoadAddr;
                     document.getElementById('guide').innerHTML = '(예상 도로명 주소 : '
                           + expRoadAddr + ')';
                  } else if (data.autoJibunAddress) {
                     var expJibunAddr = data.autoJibunAddress;
                     document.getElementById('guide').innerHTML = '(예상 지번 주소 : '
                           + expJibunAddr + ')';
                  } else {
                     document.getElementById('guide').innerHTML = '';
                  }
               }
            }).open();
   }
</script>
</html>






