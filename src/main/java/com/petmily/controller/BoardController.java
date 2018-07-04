package com.petmily.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.petmily.service.AdoptService;
import com.petmily.service.CommunityService;
import com.petmily.service.FundService;
import com.petmily.service.MissingService;
import com.petmily.service.ProtectService;
import com.petmily.service.SaveService;

@Controller
public class BoardController {
	@Autowired
	AdoptService Adopt;
	@Autowired
	CommunityService Community;
	@Autowired
	FundService fund;
	@Autowired
	MissingService missing;
	@Autowired
	ProtectService protect;
	@Autowired
	SaveService save;

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@RequestMapping(value = "board", method = RequestMethod.GET)
	public String board(Model model) {
		logger.info("board");
		return "home";
	}

	
	// 윤영   ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	/* 보호 게시판 리스트 */
	@RequestMapping(value = "/protectList")
	public ModelAndView protectList(@RequestParam HashMap<String, Object> map) { // 담아 올 값이 많아서 HashMap 이용
		logger.info("protectList 요청");
		return protect.protectList(map);
	}

	/* 보호 게시판 상세보기 */
	@RequestMapping(value = "/protectDetail")
	public ModelAndView protectDetail(@RequestParam int board_idx) { // board_idx값을 이용하여 해당 게시판 글 추출
		logger.info("protectDetail 요청");
		return protect.protectDetail(board_idx);
	}

	/* 실종 게시판 리스트 */
	@RequestMapping(value = "/missingList")
	public ModelAndView missingList(@RequestParam HashMap<String, Object> map) {
		logger.info("missingList 요청");
		return missing.missingList(map);
	}

	/* 실종 게시판 상세보기 */
	@RequestMapping(value = "/missingDetail")
	public ModelAndView missingDetail(@RequestParam int board_idx) {
		logger.info("missingDetail 요청");
		return missing.missingDetail(board_idx);
	}

	/* 실종 게시판 글작성 페이지 */
	@RequestMapping(value = "/missingWriteForm")
	public String missingWriteForm() {
		logger.info("missingWriteForm 요청");
		return "missingWriteForm";
	}

	/* 실종 게시판 글작성 */
	@RequestMapping(value = "/missingWrite")
	public ModelAndView missingWrite(@RequestParam HashMap<String, String> map) {
		logger.info("missingWrite 요청");
		return missing.missingWrite(map);
	}

	/* 첨부파일 업로드 페이지 */
	@RequestMapping(value = "/uploadForm")
	public String uploadForm() {
		logger.info("uploadForm 요청");
		return "uploadForm";
	}

	/* 첨부파일 업로드 */
	@RequestMapping(value = "/upload")
	// 파일은 request 형태로 받지 않고 MultipartFile로 받아야함
	public ModelAndView upload(MultipartFile file, HttpSession session) {
		logger.info("file upload 요청");
		// root = 파일 업로드할 폴더의 물리적 경로 추출(현재 내가 실행시키는 프로젝트의 경로안에 upload 파일 속해있을경우)
		String root = session.getServletContext().getRealPath("/");	
		return missing.upload(file, root);

	}
	
	// 윤영   ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}