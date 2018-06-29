package com.petmily.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.petmily.dao.boardDAO.BoardInter;

@Service
public class FundService {
	@Autowired SqlSession sqlSession;
	BoardInter inter;
}
