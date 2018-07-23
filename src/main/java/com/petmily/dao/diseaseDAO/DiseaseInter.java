package com.petmily.dao.diseaseDAO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.petmily.dto.DiseaseDTO;

public interface DiseaseInter {
	
	ArrayList<DiseaseDTO> diseaseSearchListPage(HashMap<String, String> params); //질병 직접 검색 

	ArrayList<DiseaseDTO> diseaseKeywordListPage(List<String> values); //질병 키워드 검색
}
