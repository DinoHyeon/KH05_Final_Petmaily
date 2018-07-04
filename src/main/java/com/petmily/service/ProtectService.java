package com.petmily.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.petmily.dao.boardDAO.BoardInter;
import com.petmily.dto.BoardDTO;

@Service
public class ProtectService {
	@Autowired SqlSession sqlSession;
	BoardInter inter;
	
	/*보호 게시판 리스트*/
	public ModelAndView protectList(HashMap<String, Object> map) {
		inter = sqlSession.getMapper(BoardInter.class); //DB 사용
		
		ArrayList<BoardDTO> protectList = inter.protectList(map); //BoardDTO 형태의 ArrayList 선언 -> map을 protectList란 변수에 담아오기
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("protectList", protectList); //보여줄 내용
		mav.setViewName("protectList");//보여질 페이지
		return mav;
	}

	/*보호 게시판 상세보기*/
	public ModelAndView protectDetail(int board_idx) {
		ModelAndView mav = new ModelAndView();
		
		inter = sqlSession.getMapper(BoardInter.class);

		mav.addObject("protectDetail", inter.protectDetail(board_idx));
		mav.setViewName("protectDetail");
		return mav;
	}
}
