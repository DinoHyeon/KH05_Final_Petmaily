package com.petmily.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.petmily.dao.memberDAO.MemberInter;
import com.petmily.dto.MemberDTO;

@Service
public class MemberService {
   
   @Autowired 
   SqlSession sqlSession;
   
   MemberInter inter;
   
   private Logger logger = LoggerFactory.getLogger(this.getClass());
   
   /*로그인 체크 서비스*/
   public ModelAndView loginConfirmPage(String pass, HashMap<String, String> params, HttpSession session) {
      logger.info("로그인 체크 실행");
      
      inter = sqlSession.getMapper(MemberInter.class);
      
      String id = params.get("id");
      
      String hash = inter.protectPwChk(id);
      
      BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
      boolean success = encoder.matches(pass, hash);
      logger.info("일치 여부 : "+success);

      MemberDTO loginChkResult = null;
      if(success == true) {
         loginChkResult = inter.loginConfirmPage(id);
      } 
      String stateChk = "";//상태체크변수
      String page = "main"; 
      String msg = "success"; 
      String loginId = null;
      
      if(loginChkResult != null) {//로그인 정보 있을 경우
    	  stateChk = loginChkResult.getMember_state();//상태 체크
    	  System.out.println("뽀테스트상태"+stateChk);
    	  if(stateChk.equals("불량회원")){//추방 사용자일 경우
         	  System.out.println("보네-추방회원");
         	  page="loginPage";
         	  msg = "out";
           }else {//추방아닌 사용자일경우
    	  session.setAttribute("loginId", id);
          session.setAttribute("state", stateChk);
          loginId = (String)session.getAttribute("loginId"); 
          System.out.println("보네-로그인됨");
           }
      }else if(loginChkResult == null) {//로그인 정보 안맞을 경우
    	  System.out.println("보네-로그인정보안맞음");
         page = "loginPage";
         msg = "fail";
       }
      ModelAndView mav = new ModelAndView();
      mav.addObject("loginId", loginId);
      mav.addObject("msg", msg); 
      mav.setViewName(page); 
      
      return mav;
   }
   
   /*로그아웃 서비스*/
   public ModelAndView logoutPage(HashMap<String, String> params, HttpSession session) {
      logger.info("로그아웃");
      
      session.removeAttribute("loginId");
      
      String loginId = (String)session.getAttribute("loginId"); 
      
      ModelAndView mav = new ModelAndView();
      mav.addObject("loginId", loginId);
      mav.addObject("msg", "logout"); 
      mav.setViewName("loginPage"); 
      
      return mav;
   }
   
   /*회원가입 요청 서비스*/
   public ModelAndView joinConfirmPage(String hash, HashMap<String, String> map, HttpSession session) {
      logger.info("회원가입 요청 실행");
      
      inter = sqlSession.getMapper(MemberInter.class);

      MemberDTO dto = new MemberDTO();
      dto.setMember_name(map.get("name"));
      dto.setMember_id(map.get("id"));
      dto.setMember_pw(hash);
      dto.setMember_email(map.get("emailName")+"@"+map.get("emailAddr"));
      dto.setMember_phone(map.get("phone"));
      dto.setMember_addr(map.get("address")+" "+map.get("addressDetail"));
      
      int success =  0;
      success = inter.joinConfirmPage(dto);
      
      String page = "joinPage";
      
      if(success == 1) {
         page = "loginPage";
      }

      ModelAndView mav = new ModelAndView();
      mav.setViewName(page);
      
      return mav;
   }

   /*아이디 중복확인 요청 서비스*/
   public int idChkPage(String userid) {
      logger.info("아이디 중복확인 요청");
      
      inter = sqlSession.getMapper(MemberInter.class);
      
      int success = 0;
      String result = inter.idChkPage(userid);

      if(result != null) {
         success = 1;
      }

      return success;
   }
   
   /*회원가입 인증번호 확인 서비스*/
   public int joinEmailConfirmPage(String num, HttpSession session) {
      logger.info("인증번호 확인 요청");
      
      String chkNum = (String) session.getAttribute("emailConfirmNum");

      int success = 0;
      
      if(num.equals(chkNum)) {
         success = 1;
      }
      
      return success;
   }

   /*아이디 찾기 요청 서비스*/
   public String idSearchPage(String[] allData) {
      logger.info("아이디 찾기 요청");
      
      inter = sqlSession.getMapper(MemberInter.class);
      
      String name = allData[0]; 
      String email = allData[1]; 
      String phone = allData[2]; 
      
      String result = inter.idSearchPage(name, email, phone); 
      
      String success = "아이디가 존재하지 않습니다.";
      
      if(result != null) {
         success = "찾으시는 아이디는 ' "+result+" ' 입니다.";
      }

      return success;
   }
   
   /*비밀번호 인증번호 확인 요청 서비스*/
   public int pwSearchConfirmPage(String num, HttpSession session) {
      logger.info("비밀번호 인증번호 확인 요청");
      
      String pwChkNum = (String) session.getAttribute("pwSearchConfirmNum");

      int success = 0;
      
      if(num.equals(pwChkNum)) {
         success = 1;
      }
      
      return success;
   }

   /*비밀번호 찾기 요청 서비스*/
   public ModelAndView pwChangeChkPage(String id, String email) {
      logger.info("비밀번호 찾기 요청");

      inter = sqlSession.getMapper(MemberInter.class);
   
      String result = inter.pwSearchPage(id, email); 
      
      String msg = "fail";
      
      String page = "loginSearchPage";
      
      logger.info(result);
      
      if(result != null) {
         msg = id;
         page = "pwChangePage";
      }

      ModelAndView mav = new ModelAndView();
      mav.addObject("msg", msg);
      mav.setViewName(page);
      
      return mav;
   }
   
   /*비밀번호 변경 요청 서비스*/
   public ModelAndView changePwPage(String id,String hash, HttpSession session ) {
      logger.info("비밀번호 변경 요청");
      
      //logger.info(params.get("changePw")+"/"+params.get("findId")+"넘어왔으");
      
      inter = sqlSession.getMapper(MemberInter.class);
      
      
      int result = inter.changePwPage(id,hash); 
      System.out.println(result+"값은?");
      
      String changeMsg = "fail";
      String page = "pwChangePage";
      
      if(result == 1) {
         session.removeAttribute("loginId");
         changeMsg = "success";
         page = "loginPage";
      }
      
      ModelAndView mav = new ModelAndView();
      mav.addObject("msg", changeMsg);
      mav.setViewName(page);
      
      return mav;
   }
   
   //회원 정보 수정 페이지
   public ModelAndView memberUpdateFormPage(HashMap<String, String> params, HttpSession session) {
      logger.info("회원 정보 수정 페이지");
      
      inter = sqlSession.getMapper(MemberInter.class);
      
      String loginId = (String)session.getAttribute("loginId"); 
      
      ArrayList<MemberDTO> memberInfo= inter.memberUpdateForm(loginId);
      
      ModelAndView mav = new ModelAndView();
      
      mav.addObject("memberInfo", memberInfo);
      mav.setViewName("memberUpdateForm");      
      return mav;
   }
   
   /*회원정보 수정을 위한 비밀번호 확인 요청 서비스*/
   public int memberUpdateConfirm(String userPw, HttpSession session) {
      logger.info("회원정보 수정을 위한 비밀번호 확인 요청");      
      
      inter = sqlSession.getMapper(MemberInter.class);
      
      String loginId = (String)session.getAttribute("loginId"); 
      
      String hash = inter.protectPwChk(loginId);
      
      BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
      boolean success = encoder.matches(userPw, hash);
      logger.info("일치 여부 : "+success);
      
      int success1 = 0;
      String result = null;
      
      if(success) {
         result = inter.memberUpdateConfirm(loginId, hash);
      }

      if(result != null) {
         success1 = 1;
      }

      return success1;
   }

   /*회원정보 수정 요청 실행 서비스*/   
   public ModelAndView memberUpdatePage(HashMap<String, String> params, String hash, HttpSession session) {
      logger.info("회원정보 수정 요청 실행");
      
      inter = sqlSession.getMapper(MemberInter.class);

      String loginId = (String)session.getAttribute("loginId"); 
      
      MemberDTO dto = new MemberDTO();
      dto.setMember_id(loginId);
      dto.setMember_pw(hash);
      dto.setMember_phone(params.get("phone"));
      dto.setMember_addr(params.get("address"));
      
      int success =  0;
      success = inter.memberUpdatePage(dto);
      
      String page = "joinPage";
      
      if(success == 1) {
         session.removeAttribute("loginId");
         page = "loginPage";
      }

      ModelAndView mav = new ModelAndView();
      mav.setViewName(page);
      
      return mav;
   }

   /*회원정보 탈퇴 요청 실행*/
   public ModelAndView deleteUpdate(HashMap<String, String> params, HttpSession session) {
      logger.info("회원정보 탈퇴요청 실행");
      
      inter = sqlSession.getMapper(MemberInter.class);

      String loginId = (String)session.getAttribute("loginId"); 
      
      int success =  0;
      success = inter.deleteUpdatePage(loginId);
      
      String page = "memberUpdateForm";
      
      if(success == 1) {
         page = "loginPage";
      }

      ModelAndView mav = new ModelAndView();
      mav.setViewName(page);
      
      return mav;
   }
   
   //회원정보 자동 삭제
   int min = 0;
   @Scheduled(fixedRate=5000)
   public void loop() {
      logger.info("탈퇴확인중...");
      inter = sqlSession.getMapper(MemberInter.class);
      
      int nYear;
       int nMonth;
       int nDay;
        
       // 현재 날짜 구하기
       Calendar calendar = new GregorianCalendar(Locale.KOREA);
       nYear = calendar.get(Calendar.YEAR);
       nMonth = calendar.get(Calendar.MONTH) + 1;
       calendar.add(Calendar.DAY_OF_MONTH, 7);   
       nDay = calendar.get(Calendar.DAY_OF_MONTH);
       
      //String date1 = nYear+"-0"+nMonth+"-"+nDay;
       
      String state = "leave";
      
      //ArrayList<String> deleteConfirm = inter.deleteConfirm(state);
      
      if(min < 12) {
         min++;
         System.out.println("초: "+min);
      }
      
      if(min == 12) {
         inter.deleteFinish(state);
      }
      //만약 주석 풀면 7일로 설정됨(지금은 시연을 위해 짧게 기간 잡음)
/*      for(int i=0; i<deleteConfirm.size(); i++) {
         String[] resultDate = deleteConfirm.get(i).split(" ");
         
          if(date1.compareTo(resultDate[0]) == 0){
             logger.info("7일이 경과하면 삭제처리");
          }
      }*/
   }

	/////////////////////////////////////////////////////////// 소현//////////////////////////////////////////////////////////

	public HashMap<String, Object> getmemberList(HashMap<String, String> params) {
		inter = sqlSession.getMapper(MemberInter.class);
		int allCnt = inter.memberallCount(params);
		// 생성 가능한 페이지 수 구하기
		int pageCnt = allCnt % 10 > 0 ? Math.round(allCnt / 10) + 1 : allCnt / 10;
		// 리턴을 위한 맵 생성
		HashMap<String, Object> memberList = new HashMap<String, Object>();
		int page = Integer.parseInt(params.get("showPageNum"));

		// 클라이언트가 원한 페이지가 최종 페이지보다 높은 경우..
		if (page > pageCnt) {
			page = pageCnt;
		}

		int end = 10 * page;
		int start = end - 10 + 1;

		params.put("start", String.valueOf(start));
		params.put("end", String.valueOf(end));

		memberList.put("list", inter.getmemberList(params));
		// 생성 페이지의 수
		memberList.put("range", pageCnt);
		// 현재 페이지 번호
		memberList.put("currPage", page);

		return memberList;

	}

	// 소현 : 관리자 페이지 회원 추방(회원 상태 리스트)
	public int changeState(String idx) {
		inter = sqlSession.getMapper(MemberInter.class);
		int success = inter.getchangeState(idx);
		return success;
	}

}
