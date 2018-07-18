package com.petmily.service;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.petmily.dao.memberDAO.MemberInter;
import com.petmily.dto.MemberDTO;

@Service
public class MemberService {
	@Autowired SqlSession sqlSession;
	
	MemberInter inter;
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public ModelAndView loginConfirmPage(HashMap<String, String> params, HttpSession session) {
		logger.info("로그인 체크 요청");
		inter = sqlSession.getMapper(MemberInter.class);

		String id = params.get("id"); 
		String pw = params.get("pw"); 
		String result = inter.loginConfirmPage(id, pw); 
		
		session.setAttribute("loginId", id); 

		String page = "testMain"; 
		String msg = id; 
		
		if(result == null) {
			page = "loginPage";
			msg = "fail";
		}
		
		String loginId = (String)session.getAttribute("loginId"); 
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("loginId", loginId);
		mav.addObject("msg", msg); 
		mav.setViewName(page); 
		
		return mav;
	}
	
	public ModelAndView joinConfirmPage(HashMap<String, String> map, HttpSession session) {
		logger.info("회원가입 요청");
		inter = sqlSession.getMapper(MemberInter.class);

		MemberDTO dto = new MemberDTO();
		dto.setMember_name(map.get("name"));
		dto.setMember_id(map.get("id"));
		dto.setMember_pw(map.get("pw"));
		dto.setMember_email(map.get("emailName")+"@"+map.get("emailAddr"));
		dto.setMember_phone(map.get("phone"));
		dto.setMember_addr(map.get("address"));
		
		int success = inter.joinConfirmPage(dto);
		
		logger.info("결과값: {}", success);
		
		String page = "joinPage";
		String joinMsg = "회원가입에 성공했습니다.";
		
		if(success == 1) {
			page = "loginPage";
		}

		ModelAndView mav = new ModelAndView();
		mav.addObject("joinMsg", joinMsg);
		mav.setViewName(page);
		
		return mav;
	}

	public int idChkPage(String userid) {
		logger.info("아이디 중복확인 요청");
		inter = sqlSession.getMapper(MemberInter.class);
		
		String result = inter.idChkPage(userid);

		int success = 1;
		
		if(result == null) {
			success = 0;
		}

		return success;
	}
	
	public int confirmNumChkPage(String num, HttpSession session) {
		logger.info("인증번호 확인 요청");
		
		String chkNum = (String) session.getAttribute("emailConfirmNum");

		int success = 0;
		
		if(num.equals(chkNum)) {
			success = 1;
		}
		
		return success;
	}
	
	public int pwConfirmNum(String num, HttpSession session) {
		logger.info("비밀번호 찾기 인증번호 확인 요청");
		
		String pwChkNum = (String) session.getAttribute("pwSearchConfirmNum");

		int success = 0;
		
		if(num.equals(pwChkNum)) {
			success = 1;
		}
		
		return success;
	}

	public String idSearchPage(String[] allData) {
		logger.info("아이디 찾기 요청");
		inter = sqlSession.getMapper(MemberInter.class);
		
		String name = allData[0]; 
		String email = allData[1]; 
		String phone = allData[2]; 
		
		logger.info(name);
		logger.info(email);
		logger.info(phone);
		
		String result = inter.idSearchPage(name, email, phone); 
		
		System.out.println(result);

		String success = "아이디가 존재하지 않습니다.";
		
		if(result != null) {
			success = "찾으시는 아이디는 ' "+result+" ' 입니다.";
		}

		return success;
	}
	
	
	
	///////////////////////////////////////////////////////////소현//////////////////////////////////////////////////////////
	
	
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
	//소현 : 관리자 페이지 회원 추방(회원 상태 리스트)
	public int changeState(String idx) {
		inter = sqlSession.getMapper(MemberInter.class);
		int success = inter.getchangeState(idx);
		return success;
   }
}
