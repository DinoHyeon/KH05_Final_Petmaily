package com.petmily.controller;

import java.net.InetAddress;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
	
	/* 보호 게시판 리스트 */
	@RequestMapping(value = "/protectList")
	public String protectList() {
		logger.info("protectList 페이지 접근");
		return "protectList";
	}
	
	/* 보호 게시판 리스트 요청*/
	@RequestMapping(value = "/getProtectList")
	public @ResponseBody HashMap<String, Object> getProtectList(@RequestParam HashMap<String, String> map) {
		logger.info("getProtectList 요청");
		return protect.protectList(map);
	}

	/* 보호 게시판 상세보기 */
	@RequestMapping(value = "/protectDetail")
	public ModelAndView protectDetail(@RequestParam int board_idx) { // board_idx값을 이용하여 해당 게시판 글 추출
		logger.info("protectDetail 요청");
		return protect.protectDetail(board_idx);
	}

	/* 보호 게시판 글작성 페이지 */
	@RequestMapping(value = "/protectWriteForm")
	public String protectWriteForm() {
		logger.info("protectWriteForm 요청");
		return "protectWriteForm";
	}

	/* 첨부파일 업로드 페이지 */
	@RequestMapping(value = "/puploadForm")
	public String puploadForm() {
		logger.info("보호_uploadForm 요청");
		return "puploadForm";
	}
	
	/* 보호_첨부파일 업로드 */
	@RequestMapping(value = "/pupload")
	// 파일은 request 형태로 받지 않고 MultipartFile로 받아야함
	public ModelAndView pupload(MultipartFile file, HttpSession session) {
		logger.info("실종_file upload 요청");
		// root = 파일 업로드할 폴더의 물리적 경로 추출(현재 내가 실행시키는 프로젝트의 경로안에 upload 파일 속해있을경우)
		String root = session.getServletContext().getRealPath("/");	
		return protect.pupload(file, root);

	}

	/* 보호 게시판 글작성 */
	@RequestMapping(value = "/protectWrite")
	public ModelAndView protectWrite(@RequestParam HashMap<String, String> map, HttpSession session) {

		// 비회원 글작성시 추가할 ip값 추출
		String ipAddr = null;
		try {
			InetAddress ip = InetAddress.getLocalHost();
			ipAddr = ip.getHostAddress();
		} catch (Exception e) {
			e.printStackTrace();
		}

		/*
		 * if(ip == null) { ip = request.getRemoteAddr(); }
		 */
		logger.info("protectWrite 요청");
		return protect.protectWrite(map, ipAddr);
	}
	
	/* 보호_파일 체크 여부 */
	  @RequestMapping(value="pcheckphoto")
	   public @ResponseBody boolean pcheckphoto() {
	   logger.info("파일 유무 확인 요청");
	   
	   return protect.pcheckphoto();
	   }
	
	/* 보호 게시판 파일 삭제 */
	@RequestMapping(value = "/pFileDel")
	//파일 삭제 위한 파일이름과 경로 가져오기
	public @ResponseBody HashMap<String, Integer> pFileDel(@RequestParam("fileName") String fileName, HttpSession session){
		String root = session.getServletContext().getRealPath("/"); //파일 경로
		logger.info("보호_ pFileDel 요청");
		logger.info(root);
		return protect.pFileDel(root, fileName);
		
	}
	/* 보호 게시글 삭제 */
	@RequestMapping(value = "/protectDelete")
	public ModelAndView protectDelete(Model model, HttpServletRequest request) {
		logger.info("protectDelete 요청");
		logger.info("protect_delete 요청 게시글 번호 : " +request);
		model.addAttribute("request", request);
		
		return protect.protectDelete(model);
	}
	
	/* 보호 글 수정 페이지 */
	@RequestMapping(value = "/.protectUpdateForm")
	public ModelAndView protectUpdateForm(@RequestParam int board_idx) {
		logger.info("protectUpdateForm 요청");
		logger.info("protect_update 요청 게시글 번호 : " +board_idx);
		return protect.protectUpdateForm(board_idx);
	}
	
	/* 보호 글 수정 */
	@RequestMapping(value = "/protectUpdate")
	public ModelAndView protectUpdate(@RequestParam HashMap<String, String> map) {
		logger.info("protectUpdate 요청");
		return protect.protectUpdate(map);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	/* 실종 게시판 이동 */
	@RequestMapping(value = "/missingList")
	public String missingList() {
		logger.info("missingList 페이지 접근");
		return "missingList";
	}
	/* 실종 게시판 리스트 요청*/
	@RequestMapping(value = "/getMissingList")
	public @ResponseBody HashMap<String, Object> getMissingList(@RequestParam HashMap<String, String> map) {
		logger.info("getMissingList 요청");
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

	/* 첨부파일 업로드 페이지 */
	@RequestMapping(value = "/muploadForm")
	public String uploadForm() {
		logger.info("uploadForm 요청");
		return "muploadForm";
	}
	
	/* 실종_첨부파일 업로드 */
	@RequestMapping(value = "/mupload")
	// 파일은 request 형태로 받지 않고 MultipartFile로 받아야함
	public ModelAndView upload(MultipartFile file, HttpSession session) {
		logger.info("실종_file upload 요청");
		// root = 파일 업로드할 폴더의 물리적 경로 추출(현재 내가 실행시키는 프로젝트의 경로안에 upload 파일 속해있을경우)
		String root = session.getServletContext().getRealPath("/");	
		return missing.mupload(file, root);

	}
	
	/* 실종 게시판 글작성 */
	@RequestMapping(value = "/missingWrite")
	public ModelAndView missingWrite(@RequestParam HashMap<String, String> map, HttpSession session) {

		// 비회원 글작성시 추가할 ip값 추출
		String ipAddr = null;
		try {
			InetAddress ip = InetAddress.getLocalHost();
			ipAddr = ip.getHostAddress();
		} catch (Exception e) {
			e.printStackTrace();
		}

		logger.info("missingWrite 요청");
		return missing.missingWrite(map, ipAddr);
	}
	
	/* 실종_파일 체크 여부 */
	  @RequestMapping(value="mcheckphoto")
	   public @ResponseBody boolean mcheckphoto() {
	   logger.info("파일 유무 확인 요청");
	   
	   return missing.mcheckphoto();
	   }
	
	/* 실종 게시판 파일 삭제 */
	@RequestMapping(value = "/mFileDel")
	//파일 삭제 위한 파일이름과 경로 가져오기
	public @ResponseBody HashMap<String, Integer> mFileDel(@RequestParam("fileName") String fileName, HttpSession session){
		String root = session.getServletContext().getRealPath("/"); //파일 경로
		logger.info("실종_ mFileDel 요청");
		return missing.mFileDel(root, fileName);
		
	}
	
	/* 실종 게시글 삭제 */
	@RequestMapping(value = "/missingDelete")
	public ModelAndView missingDelete(Model model, HttpServletRequest request) {
		logger.info("missingDelete 요청");
		model.addAttribute("request", request);
		
		return missing.missingDelete(model);
	}
	

	/* 실종 글 수정 페이지 */
	@RequestMapping(value = "/missingUpdateForm")
	public ModelAndView missingUpdateForm(@RequestParam int board_idx) {
		logger.info("missingUpdateForm 요청");
		logger.info("missing_update 요청 게시글 번호 : " +board_idx);
		return missing.missingUpdateForm(board_idx);
	}
	
	/* 실종 글 수정 */
	@RequestMapping(value = "/missingUpdate")
	public ModelAndView missingUpdate(@RequestParam HashMap<String, String> map) {
		logger.info("missingUpdate 요청");
		return missing.missingUpdate(map);
	}
	
	

}