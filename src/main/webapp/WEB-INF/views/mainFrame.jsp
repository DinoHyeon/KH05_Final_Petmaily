<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="icon" href="resources/icon.jpg"/>
	<script src ="https://code.jquery.com/jquery-3.1.0.min.js"></script>
	<title>Petmily</title>
		<style>
		
		
		
		#frame2{/* 2번째프레임 */
			background-color: #28977B;
			position:fixed;
			top:55px;	
			width:98%;
			height:26px;
			
			
			margin-left:0;
		}
		#frame3{/* 3번째프레임 */
			background-color: #217D65;
			top:81px;
			position:fixed;		
			width:98%;
			height:10px;
		}
		#frame1{/* 1번째프레임 */
			background-color:white;
			position:fixed;
			width:98%;
		}
		#frame1 img{/* 1번 프레임 이미지 전부*/
			position:fixed;
		}
		a{/* a태그 */
			text-decoration:none;
			color:white;
			cursor:pointer;
		}
  		#petmily{/* 팻밀리로고 */
			top:3px;
			left:100px;
			width:160px;
			height:50px;
		}
		#lostProtect{/* 1번프레임보호실종 */
			top:15px;
			left:450px;
		}
		#adopt{/* 1번프레임입양 */
			top:15px;
			left:700px;
		}
		#save{/* 1번프레임구조 */
			top:15px;
			left:900px;
		}
		#quiz{/* 1번프레임정보 */
			top:15px;
			left:1100px;
		}
		#login{/* 로그인 */
			top:5px;
			left:1350px;
		}
		#join{/* 회원가입 */
			top:5px;
			left:1420px;
		}
		.classBtn1,.classBtn2,.classBtn3,.classBtn4{/* 2번프레임a태그전부 */
			position:fixed;
			display:none;
			font-family:"나눔고딕 보통";
	        font-weight:600;
	        font-size:18px;
		}
		#frame2lost{/* 실종 */
			left:457px;
		}
		#sl1{/* / */
			left:492px;
		}
		#frame2protect{/* 보호 */
			left:499px;
		}
		#frame2lostAni{/* 유기동물공고 */
			left:620px;
		}
		#sl2{/* / */
			left:728px;
		}
		#frame2adopt{/* 입양 */
			left:737px;	
		}
		#frame2save{/* 구조후기 */
			left:860px;	
		}
		#sl3{/* / */
			left:931px;
		}
		#frame2fund{/* 모금 */
			left:939px;
		}
		#frame2center{/* 보호센터 찾기 */
			left:1000px;
		}
		#sl4_1{/* / */
			left:1113px;
		}
		#frame2quiz{/* 퀴즈 */
			left:1122px;
		}
		#sl4_2{/* / */
			left:1161px;
		}
		#frame2disease{/* 질병 */
			left:1170px;
		}
		#sl4_3{/* / */
			left:1205px;
		}
		#frame2community{/* 커뮤니티 */
			left:1215px;
		}
		</style>
	</head>
	<body>
		<div id="frame3">
			<div id="frame2">
				<div id="frame1">
					<a href="./mainFrame">
						<img alt="로고" id="petmily" src="resources/petmily.jpg">
					</a>
					<a onclick="javascript:void(0)">
						<img alt="실종/보호" id="lostProtect" width="90px" height="35px" src="resources/lostProtect.jpg">
						<img alt="입양" id="adopt" width="60px" height="35px" src="resources/adopt.jpg">
						<img alt="구조" id="save" width="60px" height="35px" src="resources/save.jpg">
						<img alt="정보" id="quiz" width="60px" height="35px" src="resources/quiz.jpg">
					</a>
					<a href="./loginPage">
						<img alt="로그인" id="login" onclick="fn_login()" width="35px" height="45px" src="resources/login.jpg">
					</a>
					<a href="./joinPage">
						<img alt="회원가입" id="join" onclick="fn_join()" width="45px" height="45px" src="resources/join.jpg">
					</a>
				</div>
				<a href="./missingList" class="classBtn1" id="frame2lost">실종</a>
				<a class="classBtn1" id="sl1" onclick="javascript:void(0)">/</a>
				<a href="./protectList" class="classBtn1" id="frame2protect">보호</a>
				
				<a href="./lostAnimalMain" class="classBtn2" id="frame2lostAni">유기동물공고</a>
				<a class="classBtn2" id="sl2" onclick="javascript:void(0)">/</a>
				<a href="./adoptMain" class="classBtn2" id="frame2adopt">입양후기</a>
				
				<a href="./saveMain" class="classBtn3" id="frame2save">구조후기</a>
				<a class="classBtn3" id="sl3" onclick="javascript:void(0)">/</a>
				<a href="./fundMain" class="classBtn3" id="frame2fund">모금</a>
				
				<a href="./centerMain" class="classBtn4" id="frame2center">보호센터 찾기</a>
				<a class="classBtn4" id="sl4_1" onclick="javascript:void(0)">/</a>
				<a href="./quizMain" class="classBtn4" id="frame2quiz">퀴즈</a>
				<a class="classBtn4" id="sl4_2" onclick="javascript:void(0)">/</a>
				<a href="./diseaseMain" class="classBtn4" id="frame2disease">질병</a>
				<a class="classBtn4" id="sl4_3" onclick="javascript:void(0)">/</a>
				<a href="./communityMain" class="classBtn4" id="frame2community">커뮤니티</a>
			</div>
		</div>
	</body>
	<script>
	$("#lostProtect").click(function(){//실종/보호버튼 클릭시
		//클릭 항목 색 변경, 아래 부분 띄우기
		console.log("lostProtect클릭");
		$("#lostProtect").attr("src","resources/lostProtect1.jpg");
		$("#adopt").attr("src","resources/adopt.jpg");
		$("#save").attr("src","resources/save.jpg");
		$("#quiz").attr("src","resources/quiz.jpg");
		$(".classBtn1").slideToggle("slow");
		$(".classBtn2").hide();
		$(".classBtn3").hide();
		$(".classBtn4").hide();
	});
	$("#adopt").click(function(){//입양버튼 클릭시
		//클릭 항목 색 변경, 아래 부분 띄우기
		console.log("adopt클릭");
		$("#lostProtect").attr("src","resources/lostProtect.jpg");
		$("#adopt").attr("src","resources/adopt1.jpg");
		$("#save").attr("src","resources/save.jpg");
		$("#quiz").attr("src","resources/quiz.jpg");
		$(".classBtn2").slideToggle("slow");
		$(".classBtn1").hide();
		$(".classBtn3").hide();
		$(".classBtn4").hide();
	});
	$("#save").click(function(){//구조버튼 클릭시
		//클릭 항목 색 변경, 아래 부분 띄우기
		console.log("save클릭");		
		$("#lostProtect").attr("src","resources/lostProtect.jpg");
		$("#adopt").attr("src","resources/adopt.jpg");
		$("#save").attr("src","resources/save1.jpg");
		$("#quiz").attr("src","resources/quiz.jpg");
		$(".classBtn3").slideToggle("slow");
		$(".classBtn1").hide();
		$(".classBtn2").hide();
		$(".classBtn4").hide();
	});
	$("#quiz").click(function(){//퀴즈버튼 클릭시
		//클릭 항목 색 변경, 아래 부분 띄우기		
		console.log("quiz클릭");
		$("#lostProtect").attr("src","resources/lostProtect.jpg");
		$("#adopt").attr("src","resources/adopt.jpg");
		$("#save").attr("src","resources/save.jpg");
		$("#quiz").attr("src","resources/quiz1.jpg");
		$(".classBtn4").slideToggle("slow");
		$(".classBtn1").hide();
		$(".classBtn2").hide();
		$(".classBtn3").hide();
	});
	$(".classBtn1").hover(function() {
		   $(this).css("color", "yellowgreen");
		   $("#sl1").css("color", "yellowgreen");
		}, function(){
		    $(this).css("color", "white");
		    $("#sl1").css("color", "white");
		});
	$(".classBtn2").hover(function() {
		   $(this).css("color", "yellowgreen");
		   $("#sl2").css("color", "yellowgreen");
		}, function(){
		    $(this).css("color", "white");
		    $("#sl2").css("color", "white");
		});
	$(".classBtn3").hover(function() {
		   $(this).css("color", "yellowgreen");
		   $("#sl3").css("color", "yellowgreen");
		}, function(){
		    $(this).css("color", "white");
		    $("#sl3").css("color", "white");
		});
	$("#frame2center").hover(function() {
		   $(this).css("color", "yellowgreen");
		   $("#sl4_1").css("color", "yellowgreen");
		}, function(){
		    $(this).css("color", "white");
		    $("#sl4_1").css("color", "white");
		});
	$("#frame2quiz").hover(function() {
		   $(this).css("color", "yellowgreen");
		   $("#sl4_1").css("color", "yellowgreen");
		}, function(){
		    $(this).css("color", "white");
		    $("#sl4_1").css("color", "white");
		});
	$("#frame2disease").hover(function() {
		   $(this).css("color", "yellowgreen");
		   $("#sl4_3").css("color", "yellowgreen");
		}, function(){
		    $(this).css("color", "white");
		    $("#sl4_3").css("color", "white");
		});
	$("#frame2community").hover(function() {
		   $(this).css("color", "yellowgreen");
		   $("#sl4_3").css("color", "yellowgreen");
		}, function(){
		    $(this).css("color", "white");
		    $("#sl4_3").css("color", "white");
		});
	</script>
</html>