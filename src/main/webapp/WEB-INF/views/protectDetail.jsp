<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
table, tr, td{
		width : 800px;
		border : 1px solid black;
		border-collapse: collapse;
        padding: 5px 10px; 
	}
	
.heart {
  width: 100px;
  height: 100px;
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
  background: url("resources/img/heart.png") repeat;  
  
  
  cursor: pointer;
  
}
.heart-blast {
  background-position: -2800px 0;
  transition: background 1s steps(28);
}	
</style>
</head>
<body>
<jsp:include page="mainFrame.jsp"/>
<!-- dialog가 될 div 영역! -->
<div id="protectNonmemberChk" title="비회원">
	<div>
		<h1>비밀번호를 입력해주세요.</h1>
		<input id="pass" type="password">
	</div>
</div>
	<table>
		<tr>
			<td>${protectDetail.board_title}</td>
			<!-- 비회원이 작성한 글인 경우 아이피 처리때문에 span태그 사용했어~ -->
			<td><span id="writer"></span></td>
			<td>${protectDetail.board_hit}</td>
		</tr>
		<tr>
			<td>동물종 : ${protectDetail.animal_idx}</td>
			<td>품종 : ${protectDetail.animal_type}</td>
			<td>즐겨찾기 <div id="favorite" class="heart"></div></td>
		</tr>
		<tr>
			<td colspan="2">위치 : ${protectDetail.protect_loc}</td>
			<td>작성일 : ${protectDetail.board_regDate}</td>
		</tr>
		<tr>
			<td colspan="3">${protectDetail.board_content}</td>
		</tr>
	</table>
	
	
	<%-- <jsp:include page="reply.jsp"/> --%>
	
	
	<input type="button" onclick="protectList()" value="리스트"/>
	<input type="button" id="modi" onclick="protectNonmemberChk('modi')" value="수정"/>
	<input type="button" id="del" onclick="protectNonmemberChk('del')" value="삭제"/>
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
		
		writer = "${protectDetail.board_writer}"
		//ip처리를 위해 usbstr메서드를 통해 비회원과 아이디 영역을 나눈다.
		var pre = writer.substr(0,3);
		var ip = writer.substr(4,15);
		var ipArr = ip.split(".");
		//비회원이 작성한 글이라면
		if(writer.indexOf("비회원")!=-1){
			//ip처리한 값을 span에 넣는다.
			$("#writer").html(pre+ipArr[0]+"."+ipArr[1]+".*.*");	
		}else{
			//아니라면 그냥 출력
			$("#writer").html(writer);
		}
		
		//dialog 플러그인 사용
		$( "#protectNonmemberChk" ).dialog({
			autoOpen: false,
	     	resizable: false,
		    height: "auto",
		    width: 400,
		    modal: true,
		    buttons: {
		    	"확인": function() {//확인 버튼을 클릭하면 PassChk(비밀번호 체크 )함수 실행
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
						"idx": '${protectDetail.board_idx}',
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
	function protectNonmemberChk(req) {
		request=req;
		 if(writer.indexOf("비회원")!=-1){
			$( "#protectNonmemberChk" ).dialog( "open" );
		}else{
			console.log(request);
			if(request="modi"){
				protectUpdate();
			}if(request="del"){
				protectDelete();
			}
		}
	}

	//리스트보기
	function protectList(){
		location.href="./protectList";
	}

	//수정하기
	function protectUpdate(){
		location.href="./protectUpdateForm?board_idx=${protectDetail.board_idx}";
	}
	
	//삭제
	function protectDelete(){
		var del = confirm("해당 글을 삭제하시겠습니까?");
		if(del){
			location.href="./protectDelete?board_idx=${protectDetail.board_idx}";
		}
	}
	
	//비밀번호 확인
	function PassChk() {
		$.ajax({
			type : "get",
			url : "./passChk",
			data : {
				/* 보내는 데이터는 현재 페이지를 구분할 수 있는 requestPage(메서드 하나로 처리하려고,,), 해당 글번호, 사용자가 입력한 비밀번호 */
				"requestPage": "보호",
				"idx": '${protectDetail.board_idx}',
				"pass": $("#pass").val()
			},
			success : function(data) {
				console.log(data);
				//리턴한 값이 true (=비밀번호 일치)라면
				if(data){
					//dialog창 닫고
					$("div#protectNonmemberChk.ui-dialog-content.ui-widget-content").dialog( "close" );
					//입력한 버튼의 id값에 따른 함수 처리
					if(request=='del'){
						protectDelete();
					}else{
						protectUpdate();
					}
				}else{
					//리턴 값이 false라면 경고창 출력
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