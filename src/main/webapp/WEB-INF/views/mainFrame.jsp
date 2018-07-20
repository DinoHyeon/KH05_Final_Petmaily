<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
   <head>
         <link rel="stylesheet" href="resources/plugIn/jquery-ui.css">
        <link rel="stylesheet" href="resources/plugIn/jquery-ui.theme.css">
        <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
         <script src="resources/plugIn/jquery-ui.js"></script>
       <script src="resources/js/zer0boxPaging.js" type="text/javascript"></script>
      <link rel="icon" href="resources/icon.jpg"/>
      <title>Petmily</title>
      <style>
      .navi #frame1{/* 1번째프레임 */
         position:absolute;
         background-color:white;
         top:0;
         width:99%;
      }
      .navi #frame1 img{/* 1번 프레임 이미지 전부*/
          position:absolute;
      }
      .navi #petmily{/* 팻밀리로고 */
         left:3%;
         width:11%;
      }
      .navi #frame2{/* 2번째프레임 */
         background-color: #28977B;
         position:absolute;
         top:7.3%;   
         width:99.2%;
         height:4.3%;
         margin-left:0;
      }
      .navi #frame3{/* 3번째프레임 */
         position:absolute;
         background-color: #217D65;
         top:10.7%;
         width:99.2%;
         height:1.8%;
      }
      .navi a{/* 1번프레임 a태그 */
         text-decoration:none;
         color:white;
         cursor:pointer;
      }
      .navi #lostProtect{/* 1번프레임보호실종 */
         margin-top:1.2%;
         left:20%;
      }
      .navi #adopt{/* 1번프레임입양 */
         margin-top:1.2%;
         left:35%;
      }
      .navi #save{/* 1번프레임구조 */
         margin-top:1.2%;
         left:50%;
      }
      .navi #quiz{/* 1번프레임정보 */
         margin-top:1.2%;      
         left:65%;
      }
      .navi #login{/* 로그인 */
         margin-top:0.3%;
         left:85%;
      }
      .navi #join{/* 회원가입 */
         margin-top:0.3%;
         left:89%;
      }
      .navi .classBtn1,.classBtn2,.classBtn3,.classBtn4{/* 2번프레임a태그전부 */
         display:none; 
         position:absolute;
         font-family:"나눔고딕 보통";
         font-weight:600;
         font-size:18px;
         top:7.5%;
      }
      .navi #frame2lost{/* 실종 */
         left:20.6%;
      }
      .navi #sl1{/* / */
         left:22.9%;
      }
      .navi #frame2protect{/* 보호 */
         left:23.4%;
      }
      .navi #frame2lostAni{/* 유기동물공고 */
         left:30%;
      }
      .navi #sl2{/* / */
         left:37%;
      }
      .navi #frame2adopt{/* 입양 */
         left:37.5%;   
      }
      .navi #frame2save{/* 구조후기 */
         left:47.2%;   
      }
      .navi #sl3{/* / */
         left:51.8%;
      }
      .navi #frame2fund{/* 모금 */
         left:52.5%;
      }
      .navi #frame2center{/* 보호센터 찾기 */
         left:57%;
      }
      .navi #sl4_1{/* / */
         left:64.3%;
      }
      .navi #frame2quiz{/* 퀴즈 */
         left:64.8%;
      }
      .navi #sl4_2{/* / */
         left:67.3%;
      }
      .navi #frame2disease{/* 질병 */
         left:67.8%;
      }
      .navi #sl4_3{/* / */
         left:70.2%;
      }
      .navi #frame2community{/* 커뮤니티 */
         left:70.8%;
      }
      </style>
   </head>
   <body>
      <div class="navi">
         <div id="frame3"></div>
         <div id="frame2"></div>
         <div id="frame1">
            <a href="./"><img alt="로고" id="petmily" src="resources/petmily.jpg"></a>
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
   </body>
   <script>
      //로그인 아이디 세션체크
      var loginId = "${sessionScope.loginId}";
      if(loginId!=""){
         $("#login").attr("src","resources/mypage.jpg");
         $("#join").attr("src","resources/logout.jpg");
         //종현이랑 합친 후에 a href 수정하고 테스트해보기
      }
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