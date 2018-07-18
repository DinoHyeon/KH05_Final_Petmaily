<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
table{
		
		border : 1px solid black;
		border-collapse: collapse;
        position: absolute;
        width : 70%;
        top : 10%;
        left : 10%;
	}
	
td{
	border : 1px solid black;
	border-collapse: collapse;
	padding : 20px;

}
.heart {
  width: 100px;
  height: 100px;
  position: absolute;
  left: 93%;
  top: 22%;
  transform: translate(-50%, -50%);
  background: url("resources/img/heart.png") repeat;  
  
  
  cursor: pointer;
  
}
.heart-blast {
  background-position: -2800px 0;
  transition: background 1s steps(28);
}

#contentFrame {
   position: absolute;
   left: 15.52%;
   top: 12.5%;
   width: 82.95%;
   height: 150%;
   background: white;
}

#sideFrame{
   position: absolute;
   left: 0.52%;
   top: 11.4%;
   width: 15%;
   height: 150%;
   background: black;
}

#buttonArea{
	 position: absolute;
	 top : 44%;
	 left : 38%;
}

#d_title{
	 text-align: center;
	 width : 45%;
}
#d_writer{
	 text-align: center;
	 width : 20%;
}
#d_hit{
	text-align: center;
	width : 10%;
}
#d_reg{
	text-align: center;
}

</style>
</head>
<body>
<jsp:include page="mainFrame.jsp"/>
<div id="sideFrame"></div>
<div id="contentFrame">
<div id="missingNonmemberChk" title="비회원">
	<div>
		<h1>비밀번호를 입력해주세요.</h1>
		<input id="pass" type="password">
	</div>
</div>
	<table>
		<tr>
			<td id="d_title">${missingDetail.board_title}</td>
			<td id="d_writer"><span id="writer"></span></td>
			<td id="d_hit">${missingDetail.board_hit}</td>
		</tr>
		<tr>
			<td id="d_animal">동물종 : [ ${missingDetail.animal_idx} ]</td>
			<td id="d_animal">품종 : [ ${missingDetail.animal_type} ]</td>
			<td><div id="favorite" class="heart"></div></td>
		</tr>
		<tr>
			<td colspan="2">실종 위치 : ${missingDetail.missing_loc}</td>
			<td id="d_reg">${missingDetail.board_regDate}</td>
		</tr>
		<tr>
			<td colspan="3">${missingDetail.board_content}</td>
		</tr>
	</table>
	
	
	<%-- <jsp:include page="reply.jsp"/> --%>
	
	
	<div id="buttonArea">
	<input type="button" onclick="missingList()" value="리스트"/>
	<input type="button" id="modi" onclick="missingNonmemberChk('modi')" value="수정"/>
	<input type="button" id="del" onclick="missingNonmemberChk('del')" value="삭제"/>
	</div>
	</div>
</body>
<script>
	var writer;
	var request;
	var favorite=0;

	$(document).ready(function() {
		favorite = "${favorite}";
		if(1==${favorite}){
			$("#favorite").toggleClass("heart-blast");
		}
		
		writer = "${missingDetail.board_writer}";
		//ip처리를 위해 usbstr메서드를 통해 비회원과 아이디 영역을 나눈다.
		var pre = writer.substr(0,3);
		var ip = writer.substr(4,15);
		var ipArr = ip.split(".");
		
		//비회원이 작성한 글이라면
		if(writer.indexOf("비회원")!=-1){
			//ip처리
			$("#writer").html(pre+ipArr[0]+"."+ipArr[1]+".*.*");	
		}else{
			//아니라면 그냥 출력
			$("#writer").html(writer);
		}
		
		$( "#missingNonmemberChk" ).dialog({
			autoOpen: false,
	     	resizable: false,
		    height: "auto",
		    width: 400,
		    modal: true,
		    buttons: {
		    	"확인": function() {
		    		PassChk();
		        },
		   }
		});
	});
	
	 $("#favorite").on("click", function() {
		 $(this).toggleClass("heart-blast");
		 if(favorite!=1){
			 $.ajax({
					type : "get",
					url : "./favoriteRegist",
					data : {
						"idx": '${missingDetail.board_idx}',
						"id": '${sessionScope.login}'
					},
					success : function(data) {
						favorite=1;
					},
					error : function(e) {
						console.log(e);
					}
			});
		 }else{
			 $.ajax({
					type : "get",
					url : "./favoriteDel",
					data : {
						"idx": '${missingDetail.board_idx}',
						"id": '${sessionScope.login}'
					},
					success : function(data) {
						favorite=0;
					},
					error : function(e) {
						console.log(e);
					}
			});
		 }
 	 });
	
	//비회원 체크 후 비밀번호 확인
	function missingNonmemberChk(req) {
		request=req;
		 if(writer.indexOf("비회원")!=-1){
			$( "#missingNonmemberChk" ).dialog( "open" );
		}else{
			console.log(request);
			if(request="modi"){
				missingUpdate();
			}if(request="del"){
				missingDelete();
			}
		}
	}


	//리스트보기
	function missingList(){
		location.href="./missingList";
	}

	//수정하기
	function missingUpdate(){
		location.href="./missingUpdateForm?board_idx=${missingDetail.board_idx}";
	}
	
	//삭제
	function missingDelete(){
		var del = confirm("해당 글을 삭제하시겠습니까?");
		if(del){
			location.href="./missingDelete?board_idx=${missingDetail.board_idx}";
		}
	}
	
	//비밀번호 확인
	function PassChk() {
		$.ajax({
			type : "get",
			url : "./passChk",
			data : {
				"requestPage": "실종",
				"idx": '${missingDetail.board_idx}',
				"pass": $("#pass").val()
			},
			success : function(data) {
				console.log(data);
				if(data){
					$("div#missingNonmemberChk.ui-dialog-content.ui-widget-content").dialog( "close" );
					if(request=='del'){
						missingDelete();
					}else{
						missingUpdate();
					}
				}else{
					alert("비밀번호가 일치하지않습니다.");
					$("#pass").val("");
				}
			},
			error : function(e) {
				console.log(e);
			}
		});
	}
</script>
</html>