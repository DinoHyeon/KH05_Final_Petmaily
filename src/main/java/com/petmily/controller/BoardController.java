package com.petmily.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.petmily.service.AdoptService;
import com.petmily.service.CommunityService;
import com.petmily.service.FundService;
import com.petmily.service.MemberService;
import com.petmily.service.MissingService;
import com.petmily.service.ProtectService;
import com.petmily.service.SaveService;

@Controller
public class BoardController {
	@Autowired AdoptService Adopt;
	@Autowired CommunityService Community;
	@Autowired FundService fund;
	@Autowired MissingService missing;
	@Autowired ProtectService protect;
	@Autowired SaveService save;
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@RequestMapping(value = "board", method = RequestMethod.GET)
	public String board (Model model) {
		logger.info("board");
		return "home";
	}
	
}