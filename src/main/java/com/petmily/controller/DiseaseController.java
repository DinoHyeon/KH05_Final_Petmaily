package com.petmily.controller;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.petmily.service.DiseaseService;

@Controller
public class DiseaseController {

	@Autowired
	DiseaseService service;
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	// 질병 페이지
	@RequestMapping(value = "diseaseMain")
	public String diseaseMain(@RequestParam HashMap<String, String> params) {
		logger.info("질병 메인페이지");
		return "diseaseMainPage";
	}

	// 질병 직접 검색
	@RequestMapping(value = "diseaseSearchListPage")
	public ModelAndView diseaseSearchListPage(@RequestParam HashMap<String, String> params) {
		logger.info("질병 직접 검색");
		return service.diseaseSearchListPage(params);
	}

	// 질병 키워드 검색
	@RequestMapping(value = "diseaseKeywordListPage")
	public ModelAndView diseaseKeywordListPage(@RequestParam(value = "arrKey", required = true) List<String> values) {
		logger.info("질병 키워드 검색");
		return service.diseaseKeywordListPage(values);
	}
}