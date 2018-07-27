package com.petmily.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.petmily.dao.memberDAO.MemberInter;

@Controller
public class MailController {

	@Autowired
	private JavaMailSender mailSender;

	MemberInter inter;

	@Autowired
	SqlSession sqlSession;

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	/* 회원가입 인증 메일 발송 */
	@RequestMapping(value = "/joinEmailSendPage")
	@ResponseBody
	public Map<Object, Object> mailSending(@RequestBody String email, HttpSession session) {
		logger.info("회원가입 인증 메일 발송");

		int confirmNum = new Random().nextInt(100000) + 10000;

		String ranResult = Integer.toString(confirmNum);

		session.setAttribute("emailConfirmNum", ranResult);

		String msg = null;

		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

			messageHelper.setFrom("doecc336@gmail.com");
			messageHelper.setTo(email);
			messageHelper.setSubject("petMily 회원가입 인증번호 발송");
			messageHelper.setText("인증번호: " + ranResult);

			mailSender.send(message);

			msg = "인증번호를 발송했습니다.";
		} catch (Exception e) {
			System.out.println(e);
			msg = "인증번호 발송에 실패했습니다.";
		}

		Map<Object, Object> map = new HashMap<Object, Object>();
		map.put("msg", msg);
		return map;
	}

	/* 비밀번호 찾기 인증 메일 발송 */
	@RequestMapping(value = "/pwSearchEmailSendPage")

	public @ResponseBody Map<Object, Object> pwSearchEmailSendPage(@RequestParam HashMap<String, String> params,
			HttpSession session) {

		String email = params.get("email");
		String id = params.get("id");

		logger.info("비밀번호 인증 메일 발송");

		inter = sqlSession.getMapper(MemberInter.class);

		String result = inter.ChkPwEmail(id, email);

		int pwSearchNum = new Random().nextInt(100000) + 10000;

		String pwSearchResult = Integer.toString(pwSearchNum);

		session.setAttribute("pwSearchConfirmNum", pwSearchResult);

		String msg = "존재하지 않는 아이디 입니다.";

		if (result != null) {
			try {
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

				messageHelper.setFrom("doecc336@gmail.com");
				messageHelper.setTo(email);
				messageHelper.setSubject("petMily 비밀번호 찾기 인증번호 발송");
				messageHelper.setText("인증번호: " + pwSearchNum);

				mailSender.send(message);

				msg = "인증번호를 발송했습니다.";
			} catch (Exception e) {
				System.out.println(e);

				msg = "인증번호 발송에 실패했습니다.";
			}
		}

		Map<Object, Object> map = new HashMap<Object, Object>();
		map.put("msg", msg);
		return map;
	}
}