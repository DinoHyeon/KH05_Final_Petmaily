package com.petmily.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.petmily.dto.QuizDTO;
import com.petmily.service.QuizService;

@Controller
public class QuizController {

	@Autowired
	QuizService service;

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@RequestMapping(value = "quizMain", method = RequestMethod.GET)
	public String board() {
		logger.info("퀴즈 등록(관리) 페이지 접근");
		return "quizMain";
	}

	@RequestMapping(value = "getAnimalList")
	public @ResponseBody ArrayList<String> getAnimalList() {
		logger.info("동물 리스트 출력");
		return service.AnimalList();
	}

	@RequestMapping(value = "registQuiz")
	public @ResponseBody int registQuiz(@RequestParam HashMap<String, String> params) {
		logger.info("문제 등록");
		return service.registQuiz(params);
	}

	@RequestMapping(value = "getQuizList")
	public @ResponseBody HashMap<String, Object> getQuizList(@RequestParam HashMap<String, String> params) {
		logger.info("문제 리스트 호출");
		return service.getQuizList(params);
	}

	@RequestMapping(value = "quizDetailPage")
	public ModelAndView quizDetail(@RequestParam("idx") String idx) {
		logger.info("문제 상세보기 요청: {}번글", idx);
		return service.quizDetail(idx);
	}

	@RequestMapping(value = "quizUpdatePage")
	public ModelAndView quizUpdateView(@RequestParam("idx") String idx) {
		logger.info("문제 수정 페이지 요청: {}번글", idx);
		return service.quizUpdateView(idx);
	}

	@RequestMapping(value = "quizUpdate")
	public ModelAndView quizUpdate(@RequestParam HashMap<String, String> params) {
		logger.info("문제 수정  요청");
		return service.quizUpdate(params);
	}

	@RequestMapping(value = "quizDelete")
	public ModelAndView quizDelete(@RequestParam("idx") int idx) {
		logger.info("문제 삭제  요청");
		return service.quizDelete(idx);
	}

	@RequestMapping(value = "quizSetting")
	public String quizPlayPage() {
		logger.info("퀴즈 페이지 접근");
		return "quizSetting";
	}

	@RequestMapping(value = "quizPlaySetting")
	public ModelAndView quizPlaySetting(@RequestParam HashMap<String, String> params) {
		logger.info("퀴즈 셋팅");
		return service.quizSetting(params);
	}

	@RequestMapping(value = "cleanQuiz")
	public @ResponseBody void cleanQuiz() {
		logger.info("퀴즈 초기화");
		service.cleanQuiz(); 
	}

	@RequestMapping(value = "nextQuiz")
	public @ResponseBody HashMap<String, Object> nextQuiz () {
		logger.info("퀴즈 풀이");
		return service.nextQuiz();
	}
	
	@RequestMapping(value = "knowledge")
	public String knowledge() {
		logger.info("지식 페이지 접근");
		return "knowledge";
	}
	
	@RequestMapping(value = "QuizSettingChk")
	public @ResponseBody Boolean QuizSettingChk(@RequestParam HashMap<String, String> params) {
		return service.QuizSettingChk(params);
	}
	
}