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
   
   HashMap<String, String> inputInfo = new HashMap<String, String>();//입력검색
   List<String> keyList = null;//클릭한 키워드 값 넣음
   HashMap<String, String> keyInfo = new HashMap<String, String>();//클릭검색
   
   //질병 직접 검색 요청 서비스1
   public ModelAndView diseaseSearchListPage(HashMap<String, String> params) {
      logger.info("질병 직접 검색 요청");
      inter = sqlSession.getMapper(DiseaseInter.class);
      inputInfo.clear();
      inputInfo = params;
      
      ArrayList<DiseaseDTO> allSearchList = inter.diseaseAllSearchListPage(params);
      int listCnt = allSearchList.size();
      logger.info("검색된 크기 "+listCnt);
      int range = listCnt % 15 > 0 ? Math.round(listCnt / 15) + 1 : listCnt / 15;
      HashMap<String, Object> sList = new HashMap<String, Object>();
      int page =1;
      logger.info("검색페이지값 "+page);
      if (page > range) { 
         page = range; 
      }
      int end = 15 * page;
      int start = end - 15 + 1;
      params.put("start", String.valueOf(start));
      params.put("end", String.valueOf(end));
      ArrayList<DiseaseDTO> SearchList = inter.diseaseSearchListPage(params);

      logger.info("하이"+range);
      
      ModelAndView mav = new ModelAndView();
      mav.addObject("SearchList", SearchList);
      mav.addObject("range", range);
      mav.addObject("currPage", page);
      mav.addObject("title", "search");
      mav.setViewName("diseaseListPage");      
      
      return mav;
   }

   //질병 키워드 검색 요청 서비스1
   public ModelAndView diseaseKeywordListPage(List<String> values) {
	   logger.info("질병 키워드 검색 요청");
	      inter = sqlSession.getMapper(DiseaseInter.class);
	      keyInfo.clear();
	      keyList = values;
	      ArrayList<DiseaseDTO> allSearchList = inter.diseaseAllKeywordListPage(values);
	      int listCnt = allSearchList.size();
	      logger.info("검색된 크기 "+listCnt);
	      int range = listCnt % 15 > 0 ? Math.round(listCnt / 15) + 1 : listCnt / 15;
	      int page =1;
	      logger.info("검색페이지값 "+page);
	      if (page > range) { 
	         page = range; 
	      }
	      int end = 15 * page;
	      int start = end - 15 + 1;
	      HashMap<String, Object> paging = new HashMap<>();
	      paging.put("val",values);
	      paging.put("start", start);
	      paging.put("end",end);
	      ArrayList<DiseaseDTO> SearchList = inter.diseaseKeywordListPage(paging);

	      ModelAndView mav = new ModelAndView();
	      mav.addObject("SearchList", SearchList);
	      mav.addObject("range", range);
	      mav.addObject("currPage", page);
	      mav.addObject("title", "key");
	      mav.setViewName("diseaseListPage");      
	      
	      return mav;
   }
   
   
   //질병 키워드 검색 요청 서비스2
   public HashMap<String, Object> diseaseKeywordListPage2(int num) {
	   logger.info("질병 키워드 검색 요청2");
	      inter = sqlSession.getMapper(DiseaseInter.class);
	      ArrayList<DiseaseDTO> allSearchList = inter.diseaseAllKeywordListPage(keyList);
	      int listCnt = allSearchList.size();
	      logger.info("검색된 크기 "+listCnt);
	      int range = listCnt % 15 > 0 ? Math.round(listCnt / 15) + 1 : listCnt / 15;
	      logger.info("검색페이지값 "+num);
	      if (num > range) { 
	    	  num = range; 
	      }
	      int end = 15 * num;
	      int start = end - 15 + 1;
	      HashMap<String, Object> paging = new HashMap<>();
	      paging.put("val",keyList);
	      paging.put("start", start);
	      paging.put("end",end);
	      ArrayList<DiseaseDTO> SearchList = inter.diseaseKeywordListPage(paging);
	      HashMap<String, Object> sList = new HashMap<String, Object>();   
	      sList.put("SearchList",SearchList);
	      sList.put("range", range);
	      sList.put("currPage", num); 
	      sList.put("title", "search");     
	      
	      return sList;
    
   }
   
   
   //질병 직접 검색 요청 서비스2
      public HashMap<String, Object> diseaseSearchListPage2(int num) {
         logger.info("질병 직접 검색 요청2");
         inter = sqlSession.getMapper(DiseaseInter.class);
         
         ArrayList<DiseaseDTO> allSearchList = inter.diseaseAllSearchListPage(inputInfo);
         int listCnt = allSearchList.size();
         logger.info("검색된 크기 "+listCnt);
         int range = listCnt % 15 > 0 ? Math.round(listCnt / 15) + 1 : listCnt / 15;
         HashMap<String, Object> sList = new HashMap<String, Object>();   
         logger.info("검색페이지값 "+num);
         if (num > range) { 
            num = range; 
         }
         int end = 15 * num;
         int start = end - 15 + 1;
         inputInfo.put("start", String.valueOf(start));
         inputInfo.put("end", String.valueOf(end));
         ArrayList<DiseaseDTO> SearchList = inter.diseaseSearchListPage(inputInfo);
         sList.put("SearchList",SearchList);
         sList.put("range", range);
         sList.put("currPage", num); 
         sList.put("title", "search");

         return sList;
      }
}