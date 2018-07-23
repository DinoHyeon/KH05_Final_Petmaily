package com.petmily.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.petmily.service.MemberService;

@Controller
public class MemberController {

	@Autowired
	MemberService service;
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	/* 회원가입 */
	@RequestMapping(value = "/joinPage")
	public String joinPage(Model model) {
		logger.info("회원가입");
		return "joinPage";
	}

	/* 로그인 페이지 이동 */
	@RequestMapping(value = "/loginPage")
	public String loginPage(Model model) {
		logger.info("로그인");
		return "loginPage";
	}

	/* 로그인 체크 */
	@RequestMapping(value = "/loginConfirmPage")
	public ModelAndView loginConfirmPage(@RequestParam("pw") String pass, @RequestParam HashMap<String, String> params,
			HttpSession session) {
		logger.info("로그인 체크");
		return service.loginConfirmPage(pass, params, session);
	}

	/* 로그아웃 */
	@RequestMapping(value = "/logoutPage")
	public ModelAndView logoutPage(@RequestParam HashMap<String, String> params, HttpSession session) {
		logger.info("로그아웃");
		return service.logoutPage(params, session);
	}

	/* 회원정보 수정을 위한 비밀번호 확인 */
	@RequestMapping(value = "/memberUpdatePwConfirmPage")
	public String memberUpdatePwConfirmPage(Model model) {
		logger.info("회원정보 수정을 위한 비밀번호 확인");
		return "memberUpdatePwConfirmPage";
	}

	/* 회원정보 수정을 위한 비밀번호 확인 요청 */
	@RequestMapping("/memberUpdateConfirm")
	@ResponseBody
	public Map<Object, Object> memberUpdateConfirm(@RequestBody String userPw, HttpSession session) {
		logger.info("회원정보 수정을 위한 비밀번호 확인 요청");
		int pwChkCnt = 0;
		Map<Object, Object> map = new HashMap<Object, Object>();
		pwChkCnt = service.memberUpdateConfirm(userPw, session);
		map.put("pwChkCnt", pwChkCnt);
		return map;
	}

	/* 회원정보 수정 페이지 */
	@RequestMapping(value = "/memberUpdateForm")
	public ModelAndView memberUpdateForm(@RequestParam HashMap<String, String> params, HttpSession session) {
		logger.info("회원정보 수정 페이지");
		return service.memberUpdateFormPage(params, session);
	}

	/* 회원정보 수정 요청 */
	@RequestMapping(value = "/memberUpdatePage")
	public ModelAndView memberUpdatePage(@RequestParam("pw") String pass, @RequestParam HashMap<String, String> params,
			HttpSession session) {
		logger.info("회원정보 수정 요청");

		String hash = "";

		logger.info("등록 요청 : " + pass);
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		hash = encoder.encode(pass);
		logger.info("암호문 : " + hash);

		return service.memberUpdatePage(params, hash, session);
	}

	/* 회원 탈퇴 요청 */
	@RequestMapping(value = "/deleteUpdate")
	public ModelAndView deleteUpdate(@RequestParam HashMap<String, String> params, HttpSession session) {
		logger.info("회원 탈퇴 요청");
		return service.deleteUpdate(params, session);
	}

	/* 회원가입 요청 */
	@RequestMapping(value = "/joinConfirmPage")
	public ModelAndView joinConfirmPage(@RequestParam("pw") String pass, @RequestParam HashMap<String, String> params,
			HttpSession session) {
		logger.info("회원가입 요청");

		String hash = "";

		logger.info("등록 요청 : " + pass);
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		hash = encoder.encode(pass);
		logger.info("암호문 : " + hash);

		return service.joinConfirmPage(hash, params, session);
	}

	/* 아이디 중복확인 */
	@RequestMapping("/idChkPage")
	@ResponseBody
	public Map<Object, Object> idChkPage(@RequestBody String userid) {
		logger.info("아이디 중복확인");
		int idChkCnt = 0;
		Map<Object, Object> map = new HashMap<Object, Object>();
		idChkCnt = service.idChkPage(userid);
		map.put("idChkCnt", idChkCnt);
		return map;
	}

	/* 회원가입 인증번호 확인 */
	@RequestMapping("/joinEmailConfirmPage")
	@ResponseBody
	public Map<Object, Object> joinEmailConfirmPage(@RequestBody String chkNum, HttpSession session) {
		logger.info("회원가입 인증번호 확인");
		int emailChkCnt = 0;
		Map<Object, Object> map = new HashMap<Object, Object>();
		emailChkCnt = service.joinEmailConfirmPage(chkNum, session);
		map.put("emailChkCnt", emailChkCnt);
		return map;
	}

	/* ID/PW 찾기 */
	@RequestMapping(value = "/loginSearchPage")
	public String loginSearchPage(Model model) {
		logger.info("ID/PW 찾기");
		return "loginSearchPage";
	}

	/* 아이디 찾기 */
	@RequestMapping(value = "/idSearchPage")
	public @ResponseBody HashMap<String, String> idSearchPage(@RequestParam HashMap<String, String> params) {
		logger.info("아이디 찾기");
		String allData[] = { params.get("name"), params.get("email"), params.get("phone") };
		String findId = null;
		HashMap<String, String> map = new HashMap<String, String>();
		findId = service.idSearchPage(allData);
		map.put("findId", findId);
		return map;
	}

	/* 비밀번호 인증번호 확인 */
	@RequestMapping("/pwSearchConfirmPage")
	public @ResponseBody HashMap<String, Integer> pwSearchConfirmPage(@RequestParam HashMap<String, String> params,
			HttpSession session) {
		logger.info("비밀번호 인증번호 확인");
		int pwEmailChkCnt = 0;
		String num = params.get("pwSearchNum");

		HashMap<String, Integer> map = new HashMap<String, Integer>();
		pwEmailChkCnt = service.pwSearchConfirmPage(num, session);
		map.put("pwEmailChkCnt", pwEmailChkCnt);
		return map;
	}

	/* 비밀번호 찾기 */
	@RequestMapping(value = "/pwChangePage")
	public ModelAndView pwSearchPage(@RequestParam HashMap<String, String> params) {
		logger.info("비밀번호 찾기");

		String id = params.get("pwId");
		String email = params.get("pwEmail");

		return service.pwChangeChkPage(id, email);
	}

	/* 비밀번호 변경 */
	@RequestMapping(value = "/changePwPage")
	public ModelAndView changePwPage(@RequestParam("pw") String pass, @RequestParam("changeId") String id,
			@RequestParam("pw") String pw, HttpSession session) {
		logger.info("비밀번호 변경");
		logger.info("적용" + id + "/" + pw);

		String hash = "";

		logger.info("등록 요청 : " + pass);
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		hash = encoder.encode(pass);
		logger.info("암호문 : " + hash);

		logger.info(pw + "/" + id + "여기다");

		return service.changePwPage(id, hash, session);
	}
	
	
	//////////////////////////////////////소현///////////////////////////////////////////////
	
	
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