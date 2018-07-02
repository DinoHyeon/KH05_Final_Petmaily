package com.petmily.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

import com.petmily.dao.quizDAO.QuizInter;
import com.petmily.dto.QuizDTO;

@Service
public class QuizService {
	@Autowired
	SqlSession sqlSession;
	QuizInter inter;

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	public ArrayList<String> AnimalList() {
		ArrayList<String> animalList = new ArrayList<String>();
		inter = sqlSession.getMapper(QuizInter.class);
		animalList = inter.getAnimalList();
		return animalList;
	}

	public int registQuiz(HashMap<String, String> params) {
		QuizDTO dto = new QuizDTO();
		dto.setAnimal_idx(params.get("animal"));
		dto.setQuiz_category(params.get("category"));
		dto.setQuiz_ask(params.get("ask"));
		dto.setQuiz_answer(params.get("answer"));
		dto.setQuiz_content(params.get("content"));

		inter = sqlSession.getMapper(QuizInter.class);

		return inter.registQuiz(dto);
	}

	public ArrayList<QuizDTO> getQuizList() {
		inter = sqlSession.getMapper(QuizInter.class);
		return inter.getQuizList();
	}

	public ModelAndView quizDetail(String idx) {
		ModelAndView mav = new ModelAndView();
		inter = sqlSession.getMapper(QuizInter.class);
		mav.addObject("dto", inter.quizDetail(Integer.parseInt(idx)));
		mav.setViewName("quizDetail");
		return mav;
	}

	public ModelAndView quizUpdateView(String idx) {
		ModelAndView mav = new ModelAndView();
		inter = sqlSession.getMapper(QuizInter.class);
		mav.addObject("dto", inter.quizUpdateView(Integer.parseInt(idx)));
		mav.setViewName("quizUpdate");
		return mav;
	}

	public ModelAndView quizUpdate(HashMap<String, String> params) {
		ModelAndView mav = new ModelAndView();
		
		QuizDTO dto = new QuizDTO();
		dto.setQuiz_idx(Integer.parseInt(params.get("quiz_idx")));
		dto.setAnimal_idx(params.get("aniamlList"));
		dto.setQuiz_category(params.get("category"));
		dto.setQuiz_ask(params.get("ask"));
		dto.setQuiz_answer(params.get("answer"));
		dto.setQuiz_content(params.get("content"));
		
		inter = sqlSession.getMapper(QuizInter.class);
		int success = inter.quizUpdate(dto);
		
		String page = "redirect:/quizUpdatePage?idx="+dto.getQuiz_idx();
		String msg = "수정을 실패했습니다.";
		if(success==1) {
			page = "redirect:/quizDetailPage?idx="+dto.getQuiz_idx();
			msg = "수정을 성공했습니다.";
		}
		
		mav.setViewName(page);
		
		return mav;
	}

	public ModelAndView quizDelete(int idx) {
		ModelAndView mav = new ModelAndView();
		
		inter = sqlSession.getMapper(QuizInter.class);
		int success = inter.quizDelete(idx);
		
		String page = "redirect:/quizDetailPage?idx="+idx;
		if(success==1) {
			page = "redirect:/quizMain";
		}
		
		mav.setViewName(page);
		
		return mav;
	}

	public ArrayList<String> quizSearch(HashMap<String, String> params) {
		String animal = params.get("searchAnimal");
		String category = params.get("searchCategory");
		String word = params.get("searchWord");
		
		logger.info(animal+"/"+category+"/"+word);
		return null;
	}
}
