<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
<title>회원정보 수정 확인</title>
<style>
#updateBtn {
   position: absolute;
   top : 50.2%;
   left : 58%;
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
.updatePw hr {
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

#updateTable {
   border: none;
   border-collapse: collapse;
   padding: 7px 15px;
   position: absolute;
   margin: auto auto 150px auto;
   width: 600px;
   left: 27%;
   top: 50%;
}

#updateTable tr {
   border: none;
   border-collapse: collapse;
   padding: 7px 15px;
}

#updateTable th {
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

#updateTable td {
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
   <div class="updatePw">
      <div id="title">
         <h1 style="font-size: 50">마이페이지로 이동합니다.</h1>
         <h5>비밀번호를 확인해주세요.</h5>
      </div>
      <hr />

      <form action="">
         <table id="updateTable">
            <tr>
               <th style="font-size: 20">PW</th>
               <td><input type="password" class="inp" id="confirmPw" name="pw"
                  placeholder="비밀번호 입력" maxlength="20" /></td>
            </tr>
         </table>
         <input type="button" id="updateBtn" class="btn" value="비밀번호 확인" />
      </form>
   </div>
</body>
<script>
   $(function() {
      $("#updateBtn").click(function() {
         if ($("#confirmPw").val() == "") {
            $("#confirmPw").focus();
            alert("비밀번호를 적어주세요.");
         } else {
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
                     location.href = 'memberUpdateForm'
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









