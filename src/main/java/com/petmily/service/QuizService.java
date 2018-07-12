package com.petmily.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Param;
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

	ArrayList<QuizDTO> list = new ArrayList<QuizDTO>();
	int quizNum = 0;

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

	public HashMap<String, Object> getQuizList(HashMap<String, String> params) {
		inter = sqlSession.getMapper(QuizInter.class);

		// 전체 게시글 수 구하기
		int allCnt = inter.getAllCnt(params);
		// 생성 가능한 페이지 수 구하기
		int pageCnt = allCnt % 10 > 0 ? Math.round(allCnt / 10) + 1 : allCnt / 10;
		// 리턴을 위한 맵 생성
		HashMap<String, Object> QuizList = new HashMap<String, Object>();

		logger.info("전체 글 수 : "+allCnt);
		
		int page = Integer.parseInt(params.get("showPageNum"));

		// 클라이언트가 원한 페이지가 최종 페이지보다 높은 경우..
		if (page > pageCnt) {
			page = pageCnt;
		}

		int end = 10 * page;
		int start = end - 10 + 1;

		params.put("start", String.valueOf(start));
		params.put("end", String.valueOf(end));

		QuizList.put("list", inter.getQuizList(params));
		// 생성 페이지의 수
		QuizList.put("range", pageCnt);
		// 현재 페이지 번호
		QuizList.put("currPage", page);

		return QuizList;
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

		String page = "redirect:/quizUpdatePage?idx=" + dto.getQuiz_idx();
		String msg = "수정을 실패했습니다.";
		if (success == 1) {
			page = "redirect:/quizDetailPage?idx=" + dto.getQuiz_idx();
			msg = "수정을 성공했습니다.";
		}

		mav.setViewName(page);

		return mav;
	}

	public ModelAndView quizDelete(int idx) {
		ModelAndView mav = new ModelAndView();

		inter = sqlSession.getMapper(QuizInter.class);
		int success = inter.quizDelete(idx);

		String page = "redirect:/quizDetailPage?idx=" + idx;
		if (success == 1) {
			page = "redirect:/quizMain";
		}

		mav.setViewName(page);

		return mav;
	}

	public ModelAndView quizSetting(HashMap<String, String> params) {
		list.clear();
		ModelAndView mav = new ModelAndView();
		inter = sqlSession.getMapper(QuizInter.class);

		String animal = params.get("animal");
		String category = params.get("category");
		String quizNum = params.get("quizNum");

		System.out.println("동물 종류 : " + animal);
		System.out.println("카테고리 종류: " + category);
		System.out.println("문제 개수: " + quizNum);

		// 퀴즈 목록 반환
		list = inter.quizSetting(params);

		mav.setViewName("quiz");
		mav.addObject("animal", animal);
		mav.addObject("category",category);
		mav.addObject("quizNum", quizNum);

		return mav;
	}

	public HashMap<String, Object> nextQuiz() {

		HashMap<String, Object> map = new HashMap<String, Object>();
		
		QuizDTO quiz = new QuizDTO();

		if (quizNum == list.size()) {
			quiz = null;
		} else {
			map.put("currQuizNum", quizNum);
			quiz.setQuiz_ask(list.get(quizNum).getQuiz_ask());
			quiz.setQuiz_answer(list.get(quizNum).getQuiz_answer());
			quiz.setQuiz_content(list.get(quizNum).getQuiz_content());
			
			map.put("quiz", quiz);
			
			quizNum++;
		}
		
		return map;
	}

	public void cleanQuiz() {
		quizNum = 0;
	}

	public Boolean QuizSettingChk(HashMap<String, String> params) {
		
		logger.info("퀴즈 설정 확인");
		
		inter = sqlSession.getMapper(QuizInter.class);
		int reqQuizNum = Integer.parseInt(params.get("quiz_num"));
		int resQuizNum = inter.getAllCnt(params);
		boolean quizSettingResult = true;
		
		logger.info(reqQuizNum + "/" + resQuizNum);
		
		if(reqQuizNum>resQuizNum) {
			logger.info("문제 부족");
			quizSettingResult = false;
		}
		
		return quizSettingResult;
	}
}
