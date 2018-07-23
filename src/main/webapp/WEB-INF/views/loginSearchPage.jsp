<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri ="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>
		<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
		<title>ID/PW 찾기</title>		
		<style>
		     /* 타이틀 회원가입 텍스트 */
      #title h1 {
            top: 17%;
            margin: 50px 0px 40px 0px;
            text-align: center;
            color: gray;
            font-weight: 700;
            font-size: 30;
            position: absolute;
         }
      /* 페이지 안내 문구 */
      #title h5 {
            top:32%;
            text-align: right;
            color: gray;
            font-weight: 700;
            font-size: 14;
            position: absolute;
         }
         
         .LSP hr{
            border:none;
               border:1px solid gray;
               color:gray;    /* IE */
             border-color: gray;  /* 사파리 */
                background-color: gray;   /* 크롬, 모질라 등, 기타 브라우저 */
                position: absolute;
         }
         
         .LSP table{
            position: absolute;
            border:none;
            border-collapse : collapse;
            padding : 7px 15px;
            margin: auto auto 150px auto;
         }
         .LSP tr {
            border: none;
            border-collapse: collapse;
            padding: 7px 15px;
         }
         
         .LSP th {
            border: none;
            border-collapse: collapse;
            margin: auto 20px auto auto;
            padding: 7px 15px;
            text-align: left;
            color: black;
            opacity: 0.9;
            font-weight: 700;
            width: 100px;
            font-size: 18;
         }
         
         .LSP td {
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
      <div class="LSP">
      
      <div id="title">
         <h1 style="font-size: 50; left: 22%;">아이디 찾기</h1>
         <h5 style="left: 28%;">이름, 이메일, 전화번호를 통해 아이디를 찾습니다</h5>
         <h1 style="font-size: 50; left: 60%;">비밀번호 찾기</h1>
         <h5 style="left: 73%;">아이디, 이메일을 통해 비밀번호를 찾습니다</h5>
      </div>
      
      <hr style= "width:1300px; left:9%; top:40%;"/>
      <form action="" method="post">
         <table id="idTable" style="left:18%; top:55%;">
            <tr>
               <th>이름</th>
               <td><input type="text" class="inp" id="nameSearch" name="name" placeholder="이름 입력" maxlength="20" /></td>
            </tr>
            <tr>
               <th>이메일</th>
               <td><input type="text" class="inp" id="emailSearch" name="email" placeholder="아메일 입력" maxlength="20" /></td>
            </tr>
            <tr>
               <th>전화번호</th>
               <td><input type="text" class="inp" id="phoneSearch" name="phone" placeholder="휴대폰번호 입력" maxlength="20" /></td>
            </tr>
            <tr>
               <td colspan="2"><input type="button" class="btn" id="idSearchBtn" value="아이디 찾기" style="left:38%; width:180px; margin:50px auto auto auto;"/></td>
            </tr>
         </table>
      </form>
      
         <hr style="width:1px; top:44%; height:48%; left:50%;"/>
      
      <form action="" method="post">
         <table id="pwTable" style="left:55%;  top:55%;">
            <tr>
               <th>아이디</th>
               <td><input type="text" class="inp" id="idSearch" name="id" placeholder="아이디 입력" maxlength="20" /></td>
            </tr>
            <tr>
               <th>이메일</th>
               <td><input type="text" class="inp" id="pwEmailSearch" name="pwEmail" placeholder="아메일 입력" maxlength="20" /></td>
               <td><input type="button" class="btn" id="emailSend" value="인증번호 발송"/></td>
            </tr>
            <tr>
               <th>인증번호</th>
               <td><input type="text" class="inp"  name="pwEmailNumSearch" placeholder="인증번호 입력" maxlength="20" /></td>
               <td><input type="button" class="btn" id="emailNumConfirm" value="인증번호 확인"/></td>
            </tr>
            <tr>
               <td colspan="2"><input type="button" class="btn" id="pwSearchBtn" value="비밀번호 찾기" style="left:42%; width:180px; margin:50px auto auto auto;"/></td>
            </tr>
         </table>
      </form>
      
      </div>

	</body>
	<script>
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
		                	alert("다시 작성해주세요.");
		            	}
		        	});
				}
			});
		});
		
		$(function() {
			$("#pwSearchEmailSend").click(function() {
				var email = $("#pwSearchEmail").val();

				$.ajax({
					async : true,
					type : 'POST',
					data : email,
					url : "pwSearchEmailSendPage",
					dataType : "json",
					contentType : "application/json; charset=UTF-8",
					success : function(data) {
						alert(data.msg);
					},
					error : function(error) {
						alert("다시 작성해주세요.");
					}
				});
			});
		});
		
		var pwSearchChk = 0;
		$(function() {
			$("#pwSearchEmailConfirm").click(function() {
				var pwSearchNum = $("#pwSearchEmailChk").val();

				$.ajax({	  
					type : 'get',
					url : "pwSearchConfirmPage",
					data : {"pwSearchNum": pwSearchNum},	
					dataType : "json",
					contentType : "application/json; charset=UTF-8",
					success : function(data) {
						if (data.pwEmailChkCnt == 1) {
							alert("인증이 완료되었습니다.");
							$('#pwSearchEmailChk').prop('readonly', true);
							pwSearchChk = 1;
						} else {
							alert("인증번호를 다시 확인해주세요.");
							$("#pwSearchEmailChk").focus();
						}
					},
					error : function(error) {
						alert("인증번호를 다시 확인해주세요.");
					}
				});
			});
		});
		
		$(function() {
			$("#pwSearchBtn").click(function() {
				if ($("#pwSearchId").val() == "") {
					$("#pwSearchId").focus();
					alert("아이디를 적어주세요.");
				} else if ($("#pwSearchEmail").val() == "") {
					$("#pwSearchEmail").focus();
					alert("이메일을 적어주세요.");
				} else if ($("#pwSearchEmailChk").val() == "") {
					$("#pwSearchEmailChk").focus();
					alert("인증번호를 적어주세요.");
				} else if (pwSearchChk == 0) {
					alert("인증번호를 확인해주세요.");
				} else {
					$("#pwChange").submit();
				}
			});
		});
		
		var msg = "${msg}";
		var changeMsg = "${changeMsg}";
		
		if(msg=="fail"){
			var searchFail = document.getElementById("searchFail");
			
			searchFail.style.display = "block";
			
			var aaa = document.getElementById("aaa");
			
			aaa.style.display = "none";
		}
		
		if(changeMsg=="success"){
			alert("변경을 완료했습니다.");
		}
	</script>
</html>










