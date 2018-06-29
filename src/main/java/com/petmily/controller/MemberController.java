package com.petmily.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.petmily.service.MemberService;

@Controller
public class MemberController {
	@Autowired MemberService service;
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@RequestMapping(value = "member", method = RequestMethod.GET)
	public String board (Model model) {
		logger.info("member");
		return "home";
	}
}