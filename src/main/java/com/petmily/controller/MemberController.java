package com.petmily.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.petmily.service.MemberService;

@Controller
public class MemberController {
	@Autowired
	MemberService service;
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@RequestMapping(value = "/joinPage")
	public String joinPage(Model model) {
		logger.info("회원가입");
		return "joinPage";
	}

	@RequestMapping(value = "/loginPage")
	public String loginPage(Model model) {
		logger.info("로그인");
		return "loginPage";
	}

	@RequestMapping(value = "/loginSearchPage")
	public String loginSearchPage(Model model) {
		logger.info("ID/PW 찾기");
		return "loginSearchPage";
	}

	@RequestMapping(value = "/loginConfirmPage")
	public ModelAndView loginConfirmPage(@RequestParam HashMap<String, String> params, HttpSession session) {
		logger.info("로그인 확인");
		return service.loginConfirmPage(params, session);
	}

	@RequestMapping(value = "/joinConfirmPage")
	public ModelAndView joinConfirmPage(@RequestParam HashMap<String, String> params, HttpSession session) {
		logger.info("회원가입");
		return service.joinConfirmPage(params, session);
	}

	@RequestMapping("/idChkPage")
	@ResponseBody
	public Map<Object, Object> idcheck(@RequestBody String userid) {
		logger.info("아이디 중복확인");
		int count = 0;
		Map<Object, Object> map = new HashMap<Object, Object>();
		count = service.idChkPage(userid);
		map.put("cnt", count);
		return map;
	}
	
	@RequestMapping("/pwConfirmNum")
	public Map<Object, Object> pwConfirmNum(@RequestParam HashMap<String, String> params, HttpSession session) {
		logger.info("비밀번호 인증번호 확인");
		int count = 0;
		String num = params.get("pwConfirmNum");
		Map<Object, Object> map = new HashMap<Object, Object>();
		count = service.pwConfirmNum(num, session);
		map.put("cnt", count);
		return map;
	}
	
	@RequestMapping("/confirmNumChkPage")
	@ResponseBody
	public Map<Object, Object> confirmNumChkPage(@RequestBody String chkNum, HttpSession session) {
		logger.info("인증번호 확인");
		int count = 0;
		Map<Object, Object> map = new HashMap<Object, Object>();
		count = service.confirmNumChkPage(chkNum, session);
		map.put("cnt", count);
		return map;
	}
	
	@RequestMapping(value="/idSearchPage")
	public @ResponseBody HashMap<String, String> idSearchPage(@RequestParam HashMap<String, String> params) {
		logger.info("아이디 찾기");
		logger.info(params.get("name"));
		logger.info(params.get("email"));
		logger.info(params.get("phone"));
		
		String allData[] = {params.get("name"), params.get("email"), params.get("phone")};
		String findId = null;
		HashMap<String, String> map = new HashMap<String, String>();
		findId = service.idSearchPage(allData);
		map.put("findId", findId);
		return map;
	}
	
	@RequestMapping(value="/pwSearchPage")
	public @ResponseBody HashMap<String, String> pwSearchPage(@RequestParam HashMap<String, String> params) {
		logger.info("비밀번호 찾기");
		return null;
	}
	
	
	/////////////////////////////////////////////////////////////소현////////////////////////////////////////////////////////
	
	
	/*소현 : 관리자페이지 멤버추방*/
	@RequestMapping(value = "getmemberList")
	public @ResponseBody HashMap<String, Object> getmemberList(@RequestParam HashMap<String, String> params) {
		logger.info("멤버 리스트 호출");
		return service.getmemberList(params);
	}
	
	//소현 : 관리자 페이지 회원 추방(회원 상태 리스트)
	@RequestMapping(value="changeState")
	public @ResponseBody int changeState(@RequestParam ("idx") String idx) {
		logger.info("나의 모금 리스트 삭제 ");
		return service.changeState(idx);
	}

	
    //소현 : 관리자 페이지 회원 상태 리스트 페이지 접근
	@RequestMapping(value = "memberlist")
	public String memberlist () {
		logger.info("나의 회원 리스트 페이지 접근");
		return "memberlist";
	}
}