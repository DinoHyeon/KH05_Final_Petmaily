<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri ="http://java.sun.com/jsp/jstl/core"%>
<html>
   <head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   <script src ="https://code.jquery.com/jquery-3.1.0.min.js"></script>
   <title>Insert title here</title>
   <style>
      #conDiv{
         position:absolute;
         width:100%;
         height:100%;
         top:16%;
         text-align:center;
      }
      #showDiv1,#showDiv2,#showDiv3{
         height:31%;
         letter-spacing : 2px;
         font-family:"나눔고딕 보통";
         text-align:center;
      }
      #showDiv1{
         font-size:35px;
      }
      #spanId1{
         background-color:black;
         font-size:38px;
         color:white;
         font-weight:600;
         padding: 5px;
      }
      #spanId1_1{
         font-weight:600;
      }
      #showDiv2{
         font-weight:600;
         font-size:25px;
      }
      #spanId2{
         background-color:darkgreen;
         font-size:36px;
         color:white;
      }
      #spanId2_1{
         font-size:35px;
         color:navy;
      }
      .btnCls{
           background-color : #28977B;
            border : 0;
            outline : 0;
            font-weight : 600;
            padding:5 10 5 10;
            font-size : 17px;
            color:white;
            cursor:pointer;
      }
      #spanId3_1,#spanId3_2,#spanId3_3{
         color:white;
         font-weight:600;
         padding:5px;
      }
      #spanId3_1{
         background-color:blue;
         padding: 2px;
         margin-top:10px;
      }
      #spanId3_2{
         background-color:yellowgreen;
         padding: 2px;
         margin-top:10px;
      }
      #spanId3_3{
         background-color:orange;
         padding: 2px;
         margin-top:10px;
      }
      #showDiv3{
         font-size:28px;
         letter-spacing : 2px;
         line-height:1.6em;
         font-weight:600;
      }
      #imgDiv{
         position:absolute;
         top:27%;
         left:68%;
         text-align:right;
         width:150px;
      }
      #imgDiv img{
         width:16px;
         height:16px;
      }
      #bottomDiv{
         text-align:center;
      }
      .bottomTitle{
         font-family:"나눔고딕 보통";
         font-size:25px;
         font-weight:600;
         color:black;
      }
      #bottomDiv hr{
         width:285px;
          height: 3px;
          background-color: #28977B; 
          border:0;
      }
      #bottomF{
         font-family:"나눔고딕 보통";
         font-size:25px;
         font-weight:600;
         color:#28977B;
      }
      .listImg{
         width:130px;
         height:130px;
         margin : 2 15 2 15;
         padding:5px;
         border:1px solid black;
      }
      .prevnext{
         margin : 2 10 2 10;
         top:-50px;
         cursor:pointer;
      }
      #lastDiv{
         text-align:center;
      }
      #lastDiv img{
         width:80px;
         height:120px;
         margin : 0 30 0 30;
      }
      #lastSpan{
         font-family:"나눔고딕 보통";
         font-size:25px;
         font-weight:600;
         color:#28977B;
      }
   </style>
   </head>
   <body>
      <jsp:include page="mainFrame.jsp"/>
      <div id="conDiv">
      <div id="showDiv1">
         지금,<br/><br/><span id="spanId1"></span><span id="spanId1_1">  마리가 주인을 찾고 있습니다.</span>
      </div>
      <div id="showDiv2">
         <span id="spanId2_1"></span><span id="bgndeSpan"></span>~<span id="enddeSpan"></span>에<br/>유기된 동물은 <br/>
         총 <span id="spanId2"></span> 마리 입니다.
         <br/>
         <br/>
         <input class="btnCls" type="button" onclick="prevDate()" value="◀이전기간"/>
         &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
         &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
         <input class="btnCls" type="button" onclick="nextDate()" value="다음기간▶"/> 
      </div>
      <div id="showDiv3">
         2018년, <br/>
         <span style='color:blue'>자연사 </span><span id="spanId3_1"></span><span style='color:black'>마리</span><br/>
         <span style='color:yellowgreen'>안락사 </span><span id="spanId3_2"></span><span style='color:black'>마리</span><br/>
         <span style='color:black'>그리고 </span><span id="spanId3_3"></span><span style='color:black'>마리가 </span>
         <span style='color:orange'>입양</span><span style='color:black'> 되었습니다.</span>
      </div>
      <div id="imgDiv">
      <img alt="버튼" id="sBtn1" onclick="fn_getFindHome()" src="resources/greyBtn.jpg"><!-- getFindHome -->
      <img alt="버튼" id="sBtn2" onclick="fn_cntDate()" src="resources/greyBtn.jpg"><!-- getTotalCount -->
      <img alt="버튼" id="sBtn3" onclick="fn_getAnimalCnt()" src="resources/greyBtn.jpg"><!-- getAnimalCnt -->
      </div>
      <hr/>
      <br/>
      <div id="bottomDiv">
      <span class="bottomTitle">새로운 </span><span id="bottomF">가족</span><span class="bottomTitle">을 찾습니다</span>
      <hr/>
      <br/>
      <img alt="이전버튼" class="prevnext" onclick="fn_listM()" src="resources/prev.jpg">
      <span id="listSpan"></span>
      <img alt="다음버튼" class="prevnext" onclick="fn_listP()" src="resources/next.jpg">
      </div>
      <br/><hr/>
      <div id="lastDiv">
      <br/><span id="lastSpan">서비스 바로가기</span><br/><br/>
      <a href="./searchShelter"><img alt="보호센터찾기" src="resources/pCenter.jpg"></a>
      <a href="./missingList"><img alt="실종신고" src="resources/missing.jpg"></a>
      <a href="./protectList"><img alt="목격보호신고" src="resources/find.jpg"></a>
      </div>
      </div>
   </body>
   <script>
   var findHome=0;//보호중(주인을 찾고있습니다.) 변수
   var today = 0;//오늘 날짜 담을 변수
   var oDay = 0;//15일전 날짜 담을 변수
   var cntDate=3;//기간별 유기동물 계산시 날짜 범위 count하는 변수
   var bgnde=20180101;//시작일(url에넣을) 변수
   var endde=20180630;//종료일(url에넣을) 변수
   var showPage = 1;
   var pageCnt = "";
   $(document).ready(function() {
      fn_getToday();
      fn_getFindHome();//getFindHome
      fn_getList();//아래쪽리스트
   });
   //divHide 한번에
   function divHide(){
      $("#showDiv1").hide();
      $("#showDiv2").hide();
      $("#showDiv3").hide();
   }
   //오늘 날짜 구하기
   function fn_getToday(){
       var date = new Date();
       console.log("풀2",date);
       var year = date.getFullYear(); //년도
       var month = date.getMonth()+1; //월
       var day = date.getDate(); //일
       if ((day+"").length < 2) {       // 일이 한자리 수인 경우 앞에 0을 붙여주기 위해
           day = "0" + day;
       }else if ((month+"").length < 2) {       // 월이 한자리 수인 경우 앞에 0을 붙여주기 위해
          month = "0" + month;
       }
       today = String(year)+month+day; // 오늘 날짜 (20180101)
       console.log("today:",today);
       
       
       //15일전 계산
       var agoDay = new Date(date-(3600000*24*15));
       var ayear = agoDay.getFullYear(); //년도
       var amonth = agoDay.getMonth()+1; //월
       var aday = agoDay.getDate(); //일
       if ((aday+"").length < 2) {       // 일이 한자리 수인 경우 앞에 0을 붙여주기 위해
           aday = "0" + aday;
       }//아래를 else if 넣었더니 조건문이 안돌아서 if로 따로 뺌
       if ((amonth+"").length < 2) {       // 월이 한자리 수인 경우 앞에 0을 붙여주기 위해
          amonth = "0" + amonth;
       }
       oDay = String(year)+amonth+aday; // 15일전 날짜 (20180101)
       console.log("oldDay:",oDay);
   }
   function prevDate(){
      if(cntDate==1){
         alert("2017년 상반기 까지의 기록만 확인하실 수 있습니다.");
      }else{
         cntDate--;
         fn_cntDate();
      }
      console.log("cntDate",cntDate);
   }
   function nextDate(){
      if(cntDate==3){
         alert("2018년 하반기 기록은 준비중입니다.");
      }else{
         cntDate++;
         fn_cntDate();
      }
      console.log("cntDate",cntDate);
   }
   //분기 날짜 설정
   function fn_cntDate(){
      if(cntDate==1){
         bgnde=20170101;
         endde=20170630;
         $("#spanId2_1").html("2017년 상반기");
      }else if(cntDate==2){
         bgnde=20170701;
         endde=20171231;
         $("#spanId2_1").html("2017년 하반기");
      }else if(cntDate==3){
         bgnde=20180101;
         endde=20180630;
         $("#spanId2_1").html("2018년 상반기");
      }
      $("#span2_3").html("2018년 상반기");
      $("#bgndeSpan").html("("+bgnde);//시작일 span에 넣어줌
      $("#enddeSpan").html(endde+")");//종료일 span에 넣어줌
      fn_getTotalCount();
   }
   //getFindHome
   function fn_getFindHome(btn) {
      $("#sBtn1").attr("src","resources/greenBtn.jpg");
      $("#sBtn2").attr("src","resources/greyBtn.jpg");
      $("#sBtn3").attr("src","resources/greyBtn.jpg");
      divHide();
      $("#showDiv1").show();
      wrapWindowByMask();
      console.log("getFindHome함수 시작");
      $.ajax({
         url : "./getFindHome",
         type : "get",
         data : {
            "bgnde" : 20180101,
            "endde" : today
            },
         success : function(data) {
            $("#spanId1").html(data);
            $("#showDiv1").show();
            $('#mask, #loadingImg').hide();
              $('#mask, #loadingImg').remove(); 
         },
         error : function(e) {
            console.log(e);
         }
      });
   }
   //분기별 총 유기동물 수
   function fn_getTotalCount() {
      $("#sBtn2").attr("src","resources/greenBtn.jpg");
      $("#sBtn1").attr("src","resources/greyBtn.jpg");
      $("#sBtn3").attr("src","resources/greyBtn.jpg");
      wrapWindowByMask();
      console.log("getTotalCount함수 시작");
      $.ajax({
         url : "./getTotalCount",
         type : "get",
         data : {
            "bgnde" : bgnde,
            "endde" : endde
            },
         success : function(data) {
            $('#mask, #loadingImg').hide();
              $('#mask, #loadingImg').remove(); 
            $("#spanId2").html(data);
            divHide();
            $("#showDiv2").show();
         },
         error : function(e) {
            console.log(e);
         }
      });
   }
   //유기동물 상태
   function fn_getAnimalCnt() {
      $("#sBtn3").attr("src","resources/greenBtn.jpg");
      $("#sBtn1").attr("src","resources/greyBtn.jpg");
      $("#sBtn2").attr("src","resources/greyBtn.jpg");
      wrapWindowByMask();
      console.log("getAnimalCnt함수 시작");
      $.ajax({
         url : "./getAnimalCnt",
         type : "get",
         data : {
            "bgnde" : 20180412,
            "endde" : today
            },
         success : function(data) {
            var nDie = data.nDie;
            var ret = data.ret
            var adpt = data.adpt;
            var bDie = data.bDie;
            var give = data.give;
            var netu = data.netu;
            console.log(nDie);//종료(자연사)
            console.log(ret);//종료(반환)
            console.log(adpt);//종료(입양)
            console.log(bDie);//종료(안락사)
            console.log(give);//종료(기증)
            console.log(netu);//종료(방사)
            var content="";
            
            $('#mask, #loadingImg').hide();
              $('#mask, #loadingImg').remove(); 
            $("#spanId3_1").html(nDie);
            $("#spanId3_2").html(bDie);
            $("#spanId3_3").html(adpt);
            divHide();
            $("#showDiv3").show();
         },
         error : function(e) {
            console.log(e);
         }
      });
   }
   //로딩중
   function wrapWindowByMask() {
        //화면의 높이와 너비를 구한다.
        var maskHeight = $(document).height(); 
//      var maskWidth = $(document).width();
        var maskWidth = window.document.body.clientWidth;
         
        var mask = "<div id='mask' style='position:absolute; z-index:9000; background-color:#000000; display:none; left:0; top:0;'></div>";
        var loadingImg = '';
         
        loadingImg += "<div id='loadingImg' style='position:absolute; left:50%; top:40%; display:none; z-index:10000;'>";
        loadingImg += " <img src='resources/loading.gif'/>";
        loadingImg += "</div>";  
     
        //화면에 레이어 추가
        $('body')
            .append(mask)
            .append(loadingImg)
           
        //마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
        $('#mask').css({
                'width' : maskWidth
                , 'height': maskHeight
                , 'opacity' : '0.1'
        }); 
     
        //마스크 표시
        $('#mask').show();   
     
        //로딩중 이미지 표시
        $('#loadingImg').show();
    }
   
   /////////////////////////////////////////아래////////////////////////////////////////
   //getFindHome
   function fn_getList() {
      var content="";
      var idx="";
      console.log("getList함수 시작");
      $.ajax({
         url : "./getMainList",
         type : "get",
         data : {
            "showPageNum" : showPage,
            "bgnde" : oDay,
            "endde" : oDay
            },
         success : function(data) {
            console.log("fn_getList",data);
            pageCnt = data.pageCnt;
             for(var i=0; i<data.list.length; i++){
                content+="<a href='./noticeDetail?idx="+data.list[i].noticeNo+"'>";
               content+="<img class='listImg' src='"+data.list[i].fileName+"'></a>";
            } 
            console.log(content);
            $("#listSpan").html(content);
         },
         error : function(e) {
            console.log(e);
         }
      });
   }
   
   
   function fn_listM(){
      if(showPage>1){
         showPage--;
         console.log("showPage",showPage);   
         fn_getList();
      }else{
         alert("첫번째 목록입니다.");
      }
      
   }
   function fn_listP(){
      if(showPage<pageCnt){
         showPage++;
         console.log("showPage",showPage);
         fn_getList();
      }else{
         alert("마지막 목록입니다.");
      }

   }
   </script>
</html>