package com.petmily.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.petmily.dao.diseaseDAO.DiseaseInter;
import com.petmily.dto.DiseaseDTO;

@Service
public class DiseaseService {
	@Autowired
	SqlSession sqlSession;

	DiseaseInter inter;

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	// 질병 직접 검색 요청 서비스
	public ModelAndView diseaseSearchListPage(HashMap<String, String> params) {
		logger.info("질병 직접 검색 요청");

		inter = sqlSession.getMapper(DiseaseInter.class);

		ArrayList<DiseaseDTO> SearchList = inter.diseaseSearchListPage(params);

		ModelAndView mav = new ModelAndView();
		mav.addObject("SearchList", SearchList);
		mav.setViewName("diseaseListPage");

		return mav;
	}

	// 질병 키워드 검색 요청 서비스
	public ModelAndView diseaseKeywordListPage(List<String> values) {
		logger.info("질병 키워드 검색 요청");

		inter = sqlSession.getMapper(DiseaseInter.class);

		for (int i = 0; i < values.size(); i++) {
			logger.info(values.get(i));
		}

		ArrayList<DiseaseDTO> SearchList = inter.diseaseKeywordListPage(values);

		ModelAndView mav = new ModelAndView();
		mav.addObject("SearchList", SearchList);
		mav.setViewName("diseaseListPage");

		return mav;
	}
}
