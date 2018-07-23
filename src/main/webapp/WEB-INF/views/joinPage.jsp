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
      <h3>JOIN</h3>
      <hr>

      <form id="joinConfirm" action="joinConfirmPage" method="post">
         <table>
            <tr>
               <th>이름</th>
               <td colspan="3"><input type="text" id="joinName" name="name" placeholder="이름 입력" maxlength="20" /></td>
            </tr>
            <tr>
               <th>ID</th>
               <td><input type="text" id="joinId" name="id" placeholder="아이디 입력" maxlength="20" /></td>
               <td><input type="button" id="idChk" style="width:80pt; height:20pt;" value="중복확인"></td>
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
               <td>
                  <input type="text" id="joinEmailName" name="emailName" placeholder="이메일 입력" maxlength="20" />&nbsp;&nbsp;@&nbsp;
                  <input type="text" id="joinEmailAddr" name="emailAddr" placeholder="이메일 주소 입력" maxlength="20" />
               </td>
               <td colspan="2"><input type="button" id="joinEmailSend" style="width:80pt; height:20pt;" value="인증번호 발송"></td>
            </tr>
            <tr>
               <th></th>
               <td><input type="text" id="joinEmailChk" name="emailChk" placeholder="인증번호 입력" maxlength="20" /></td>
               <td colspan="2"><input type="button" id="joinEmailConfirm" style="width:80pt; height:20pt;" value="인증번호 확인"></td>
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
         </table>               
         <input type="button" onclick="joinChk()" id="joinBtn" value="가입하기"/>
      </form>
   </body>
   <script>
      var idChk = 0;
      var pwChk = 0;
      var emailChk = 0;
      
      function joinChk(){
         if($("#joinName").val() == ""){
            $("#joinName").focus();
            alert("이름을 적어주세요.");
         } else if($("#joinId").val() == ""){
            $("#joinId").focus();
            alert("아이디를 적어주세요.");
         } else if(idChk == 0){
            $("#joinId").focus();
            alert("중복확인을 해주세요.");
         } else if($("#joinPw").val() == ""){
            $("#joinPw").focus();
            alert("비밀번호를 적어주세요.");
         } else if(pwChk == 0){
            $("#joinPwChk").focus();
            alert("비밀번호를 확인해주세요.");
         } else if($("#joinEmailName").val() == ""){
            $("#joinEmailName").focus();
            alert("이메일을 적어주세요.");
         } else if($("#joinEmailAddr").val() == ""){
            $("#joinEmailAddr").focus();
            alert("이메일을 적어주세요.");
         } else if($("#joinEmailChk").val() == ""){
            $("#joinEmailChk").focus();
            alert("인증번호를 입력해주세요.");
         } else if(emailChk == 0){
            $("#joinEmailChk").focus();
            alert("인증번호를 다시 확인해주세요");
         } else if($("#joinPhone").val() == ""){
            $("#joinPhone").focus();
            alert("휴대폰번호를 적어주세요.");
         } else if($("#joinAddress").val() == ""){
            $("#joinAddress").focus();
            alert("주소를 적어주세요.");
         } else{
            $("#joinConfirm").submit();
            alert("회원가입이 완료되었습니다.");
         }
      }
      
      $(function() {
          $("#idChk").click(function() {
              var joinId=  $("#joinId").val(); 
              
              $.ajax({
                  async: true,
                  type : 'POST',
                  data : joinId,
                  url : "idChkPage",
                  dataType : "json",
                  contentType: "application/json; charset=UTF-8",
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
      
      $(function() {
          $("#joinEmailSend").click(function() {
             var emailName = $("#joinEmailName").val();
            var emailAddr = $("#joinEmailAddr").val();
            var email = emailName+"@"+emailAddr;
            
            $.ajax({
                  async: true,
                  type : 'POST',
                  data : email,
                  url : "./joinEmailSendPage",
                  dataType : "json",
                  contentType: "application/json; charset=UTF-8",
                  success : function(data) {
                     alert(data.msg);
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
                  async: true,
                  type : 'POST',
                  data : confirmNum,
                  url : "joinEmailConfirmPage",
                  dataType : "json",
                  contentType: "application/json; charset=UTF-8",
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









