package com.petmily.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class ReplyController {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());


	@RequestMapping(value = "reply", method = RequestMethod.GET)
	public String board (Model model) {
		logger.info("reply");
		return "home";
	}
}