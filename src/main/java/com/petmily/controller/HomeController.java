package com.petmily.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		logger.info("Fetmily 실행");
		return "main";
	}

	@RequestMapping(value = "/mainFrame", method = RequestMethod.GET)
	public String mainFrame(Model model) {
		return "mainFrame";
	}

}
