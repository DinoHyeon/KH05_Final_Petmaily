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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	
	
	/*//////////////////////////////////////////////////윤영/////////////////////////////////////////////////*/
	
	/* 비밀번호 확인 */
	@RequestMapping(value = "passChk")
	public @ResponseBody boolean PassChk(@RequestParam HashMap<String, String> param) {
		logger.info("board");
		return missing.passChk(param);
	}

	/* 즐겨 찾기 등록 */
	@RequestMapping(value = "/favoriteRegist")
	public @ResponseBody int favoriteRegist(@RequestParam HashMap<String, String> map, HttpSession session) {
		logger.info("즐겨찾기 등록");
		return missing.favoriteRegist(map,session);
	}

	/* 즐겨 찾기 삭제 */
	@RequestMapping(value = "/favoriteDel")
	public @ResponseBody int favoriteDel(@RequestParam HashMap<String, String> map, HttpSession session) {
		logger.info("즐겨찾기 삭제");
		return missing.favoriteDel(map,session);
	}

	/* 보호 게시판 리스트 */
	@RequestMapping(value = "/protectList")
	public String protectList() {
		logger.info("protectList 페이지 접근");
		return "protectList";
	}

	/* 보호 게시판 리스트 요청 */
	@RequestMapping(value = "/getProtectList")
	public @ResponseBody HashMap<String, Object> getProtectList(@RequestParam HashMap<String, String> map) {
		logger.info("getProtectList 요청");
		return protect.protectList(map);
	}

	/* 보호 게시판 상세보기 */
	@RequestMapping(value = "/protectDetail")
	public ModelAndView protectDetail(@RequestParam int board_idx, HttpSession session) { // board_idx값을 이용하여 해당 게시판 글추출
		logger.info("protectDetail 요청");
		return protect.protectDetail(board_idx, session);
	}

	/* 보호 게시판 글작성 페이지 */
	@RequestMapping(value = "/protectWriteForm")
	public String protectWriteForm() {
		logger.info("protectWriteForm 요청");
		protect.photoClear();
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

		// 회원 : session / 비회원 : ipAddr
		// 비회원 글작성시 추가할 ip값 추출
		String ipAddr = "";
		try {
			InetAddress ip = InetAddress.getLocalHost();
			ipAddr = ip.getHostAddress();
		} catch (Exception e) {
			e.printStackTrace();
		}

		logger.info("protectWrite 요청");
		return protect.protectWrite(map, ipAddr, session);
	}

	/* 보호_파일 체크 여부 */
	@RequestMapping(value = "pcheckphoto")
	public @ResponseBody boolean pcheckphoto() {
		logger.info("파일 유무 확인 요청");

		return protect.pcheckphoto();
	}

	/* 보호 게시판 파일 삭제 */
	@RequestMapping(value = "/pFileDel")
	// 파일 삭제 위한 파일이름과 경로 가져오기
	public @ResponseBody HashMap<String, Integer> pFileDel(@RequestParam("fileName") String fileName,
			HttpSession session) {
		String root = session.getServletContext().getRealPath("/"); // 파일 경로
		logger.info("보호_ pFileDel 요청");
		return protect.pFileDel(root, fileName);
	}

	/* 보호 게시글 삭제 */
	@RequestMapping(value = "/protectDelete")
	public ModelAndView protectDelete(Model model, HttpServletRequest request) {
		logger.info("protectDelete 요청");
		model.addAttribute("request", request);

		return protect.protectDelete(model);
	}

	/* 보호 글 수정 페이지 */
	@RequestMapping(value = "/protectUpdateForm")
	public ModelAndView protectUpdateForm(@RequestParam int board_idx) {
		logger.info("protectUpdateForm 요청");
		logger.info("protect_update 요청 게시글 번호 : " + board_idx);
		return protect.protectUpdateForm(board_idx);
	}

	/* 보호 글 수정 */
	@RequestMapping(value = "/protectUpdate")
	public ModelAndView protectUpdate(@RequestParam HashMap<String, String> map) {
		logger.info("protectUpdate 요청");
		return protect.protectUpdate(map);
	}

	/* 실종 게시판 이동 */
	@RequestMapping(value = "/missingList")
	public String missingList() {
		logger.info("missingList 페이지 접근");
		return "missingList";
	}

	/* 실종 게시판 리스트 요청 */
	@RequestMapping(value = "/getMissingList")
	public @ResponseBody HashMap<String, Object> getMissingList(@RequestParam HashMap<String, String> map) {
		logger.info("getMissingList 요청");
		return missing.missingList(map);
	}

	/* 실종 게시판 상세보기 */
	@RequestMapping(value = "/missingDetail")
	public ModelAndView missingDetail(@RequestParam int board_idx, HttpSession session) {
		logger.info("missingDetail 요청");
		return missing.missingDetail(board_idx, session);
	}

	/* 실종 게시판 글작성 페이지 */
	@RequestMapping(value = "/missingWriteForm")
	public String missingWriteForm() {
		logger.info("missingWriteForm 요청");
		missing.photoClear();
		return "missingWriteForm";
	}

	/* 첨부파일 업로드 페이지 */
	@RequestMapping(value = "/muploadForm")
	public String muploadForm() {
		logger.info("uploadForm 요청");
		return "muploadForm";
	}

	/* 실종_첨부파일 업로드 */
	@RequestMapping(value = "/mupload")
	// 파일은 request 형태로 받지 않고 MultipartFile로 받아야함
	public ModelAndView mupload(MultipartFile file, HttpSession session) {
		logger.info("실종_file upload 요청");
		// root = 파일 업로드할 폴더의 물리적 경로 추출(현재 내가 실행시키는 프로젝트의 경로안에 upload 파일 속해있을경우)
		String root = session.getServletContext().getRealPath("/");
		return missing.mupload(file, root);
	}

	/* 실종 게시판 글작성 */
	@RequestMapping(value = "/missingWrite")
	public ModelAndView missingWrite(@RequestParam HashMap<String, String> map, HttpSession session) {
		// 회원 : session / 비회원 : ipAddr
		// 비회원 글작성시 추가할 ip값 추출
		String ipAddr = "";
		try {
			InetAddress ip = InetAddress.getLocalHost();
			ipAddr = ip.getHostAddress();
		} catch (Exception e) {
			e.printStackTrace();
		}

		logger.info("missingWrite 요청");
		return missing.missingWrite(map, ipAddr, session);
	}

	/* 실종_파일 체크 여부 */
	@RequestMapping(value = "mcheckphoto")
	public @ResponseBody boolean mcheckphoto() {
		logger.info("파일 유무 확인 요청");

		return missing.mcheckphoto();
	}

	/* 실종 게시판 파일 삭제 */
	@RequestMapping(value = "/mFileDel")
	// 파일 삭제 위한 파일이름과 경로 가져오기
	public @ResponseBody HashMap<String, Integer> mFileDel(@RequestParam("fileName") String fileName,
			HttpSession session) {
		String root = session.getServletContext().getRealPath("/"); // 파일 경로
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
		logger.info("missing_update 요청 게시글 번호 : " + board_idx);
		return missing.missingUpdateForm(board_idx);
	}

	/* 실종 글 수정 */
	@RequestMapping(value = "/missingUpdate")
	public ModelAndView missingUpdate(@RequestParam HashMap<String, String> map) {
		logger.info("missingUpdate 요청");
		return missing.missingUpdate(map);
	}

	/*//////////////////////////////////////////////////소현/////////////////////////////////////////////////*/

	// 소현: 나의 모금리스트페이지(마이페이지)
	@RequestMapping(value = "mylist")
	public String mylist() {
		logger.info("나의 모금 리스트 페이지 접근");
		return "mylist";
	}

	// 소현: getmyList(마이리스트 페이징 처리 list 호출)
	@RequestMapping(value = "getmyList")
	public @ResponseBody HashMap<String, Object> getmyList(@RequestParam HashMap<String, String> params,
			HttpSession session) {
		logger.info("마이 모금 리스트 호출");
		System.out.println("로긘아뒤 :" + session.getAttribute("loginId"));
		return fund.getmyList(params, session);
	}

	// 소현: 나의 모금 리스트 삭제
	@RequestMapping(value = "delMylist")
	public @ResponseBody int delMylist(@RequestParam("idx") int idx) {
		logger.info("나의 모금 리스트 삭제 ");
		return fund.delMylist(idx);
	}

	/* 소현: 나의 모금 리스트 사유보기 */
	@RequestMapping(value = "reason", produces = "application/text; charset=utf8")
	public @ResponseBody String reason(@RequestParam("idx") int idx) {
		logger.info("나의 모금 리스트 사유보기 ");
		return fund.reason(idx);
	}

	// 소현 모금게시판 리스트 페이지
	@RequestMapping(value = "fundMain")
	public String fundMain() {
		logger.info("나의 모금 리스트 페이지 접근");
		return "fundMain";
	}

	// *소현: 모금 게시판 리스트
	@RequestMapping(value = "getfundList")
	public @ResponseBody HashMap<String, Object> getfundList(@RequestParam HashMap<String, String> params) {
		logger.info("모금 게시판 리스트 호출");
		return fund.getfundList(params);
	}

	/* 소현 : 글 작성 폼 요청 */
	@RequestMapping(value = "fundWrite")
	public String list() {
		logger.info("글 작성 페이지");
		return "fundWrite"; // 글 작성 페이지(writeForm.jsp)
	}

	// 소현: 글 등록
	@RequestMapping(value = "writefundbbs")
	public ModelAndView write(@RequestParam HashMap<String, String> params, RedirectAttributes redirectAtt) {
		System.out.println(params.get("board_type"));
		logger.info("글등록 요청");

		return fund.writefundbbs(params, redirectAtt);
	}

	// 소현 : 동물 사진 파일 삭제시(글등록)
	@RequestMapping(value = "/fileDel")
	public @ResponseBody HashMap<String, Integer> fileDel(@RequestParam("fileName") String fileName,
			HttpSession session) {
		logger.info("file delete 요청");
		String root = session.getServletContext().getRealPath("/");
		return fund.fileDel(root, fileName);
	}

	// 소현: 영수증 사진 파일 삭제시(글등록)
	@RequestMapping(value = "/filetwoDel")
	public @ResponseBody HashMap<String, Integer> filetwoDel(@RequestParam("fileName") String fileName,
			HttpSession session) {
		logger.info("file delete 요청");
		String root = session.getServletContext().getRealPath("/");
		return fund.filetwoDel(root, fileName);
	}

	// 소현: 파일 유무확인
	@RequestMapping(value = "checkphoto")
	public @ResponseBody int checkphoto() {
		logger.info("파일 유무 확인 요청");

		return fund.checkphoto();
	}

	// 소현: 동물,영수증 파일 유무확인
	@RequestMapping(value = "checkonephoto")
	public @ResponseBody boolean checkonephoto() {
		logger.info("파일 갯수 확인 요청");

		return fund.checkonephoto();
	}

	// 파일 업로드 창
	@RequestMapping(value = "animalupload")
	public String uploadForm() {
		logger.info("파일 업로드 페이지 이동");
		return "animalupload";
	}

	// 파일 업로드 창
	@RequestMapping(value = "receiptUpload")
	public String receiptUpload() {
		logger.info("파일 업로드 페이지 이동");
		return "receiptUpload";
	}

	// 소현 : 동물 파일 업로드 게시글에 등록
	@RequestMapping(value = "/upload")
	public ModelAndView upload(MultipartFile file, HttpSession session) {
		logger.info("file upload 요청");
		String root = session.getServletContext().getRealPath("/");
		return fund.upload(file, root);
	}

	// 소현 : 영수증 파일 업로드 게시글에 등록
	@RequestMapping(value = "/Photoupload")
	public ModelAndView Photoupload(MultipartFile file, HttpSession session) {
		logger.info("file upload2 요청");
		String root = session.getServletContext().getRealPath("/");
		return fund.Photoupload(file, root);
	}

	// 소현: 게시판 상세보기 요청
	@RequestMapping(value = "funddetail")
	public ModelAndView funddetail(@RequestParam String idx) {
		logger.info("상세보기 요청");
		return fund.funddetail(idx);
	}

	// 수정페이지
	@RequestMapping(value = "fundupdateForm")
	public ModelAndView updateForm(Model model, HttpServletRequest request) {
		logger.info("수정 폼 요청");
		model.addAttribute("request", request);// 는 request 로 넘어온 값들을 model 로 저장을 합니다
		return fund.fundupdateForm(model);
	}

	// 소현 수정 등록시
	@RequestMapping(value = "/fundupdate")
	public ModelAndView undupdate(@RequestParam HashMap<String, String> params) {
		logger.info("수정 요청");
		// 1. 글 수정(Update)
		// 2. fileList 처리(기존 files 테이블의 데이터와 fileList 의 데이터 동기화)
		return fund.fundupdate(params);
	}

	// 소현 : getagreeList(관리자 승인 대기 list호출 페이징 처리)
	@RequestMapping(value = "getagreeList")
	public @ResponseBody HashMap<String, Object> getagreeList(@RequestParam HashMap<String, String> params) {
		logger.info("관리자 리스트 호출");
		return fund.getagreeList(params);
	}

	// 소현 : 관리자페이지 승인대기 리스트 페이지 접근
	@RequestMapping(value = "agreeAdmin")
	public String agreeAdmin() {
		logger.info("나의 승인대기 리스트 페이지 접근");
		return "agreeAdmin";
	}

	// 소현: 관리자 페이지 승인 리스트 승인 버튼 클릭시 승인
	@RequestMapping(value = "agreeAd")
	public @ResponseBody int agreeAd(@RequestParam("idx") int idx) {
		logger.info("관리자페이지 승인 ");
		return fund.agreeAd(idx);
	}

	// 소현: 관리자 페이지 승인 리스트 거부 버튼 클릭시 승인거부
	@RequestMapping(value = "sendno")
	public @ResponseBody int sendno(@RequestParam("idx") int idx) {
		logger.info("관리자페이지 승인 ");
		return fund.sendno(idx);
	}

	// 소현: 관리자 페이지 승인 리스트 거부 버튼 클릭시 거절사유 전송
	@RequestMapping(value = "sendreason")
	public @ResponseBody int sendreason(@RequestParam("idx") int idx, @RequestParam("reason") String reason) {
		logger.info("관리자페이지 승인 ");
		return fund.sendreason(idx, reason);
	}

	// 소현 :나의 즐겨찾기 리스트 페이지 접근
	@RequestMapping(value = "likelist")
	public String likelist() {
		logger.info("나의 즐겨찾기 리스트 페이지 접근");
		return "likelist";
	}

	// 소현 : 즐겨찾기 리스트 페이징 처리
	@RequestMapping(value = "getlikeList")
	public @ResponseBody HashMap<String, Object> getlikeList(@RequestParam HashMap<String, String> params,HttpSession session) {
		logger.info("즐겨찾기 리스트 호출");
		return fund.getlikeList(params,session);
	}

	// 소현 : 나의 즐겨찾기 리스트 삭제
	@RequestMapping(value = "delLikelist")
	public @ResponseBody int delLikelist(@RequestParam("idx") int idx) {
		logger.info("나의 즐겨찾기 리스트 삭제 ");
		return fund.delLikelist(idx);
	}

	// 소현 : 게시글 삭제
	@RequestMapping(value = "/funddelete")
	public ModelAndView funddelete(Model model, HttpServletRequest request) {
		logger.info("삭제  요청");
		model.addAttribute("request", request);// 는 request 로 넘어온 값들을 model 로 저장을 합니다
		return fund.funddelete(model);
	}

	
	/*//////////////////////////////////////////////////보네/////////////////////////////////////////////////*/

	// 보네 - (커뮤니티) 작성 폼 이동
	@RequestMapping(value = "/communityForm")
	public String communityForm() {
		logger.info("communityForm 이동-controller");
		return "communityForm";
	}

	// 보네 - (커뮤니티) 파일 업로드 폼 이동
	@RequestMapping(value = "/cFileUploadForm")
	public String cFileUploadForm() {
		logger.info("파일 업로드 페이지 이동");
		return "cFileUploadForm";
	}

	// 보네 - (커뮤니티) 파일 업로드
	@RequestMapping(value = "/cFileUpload")
	public ModelAndView cFileUpload(MultipartFile file, HttpSession session) {
		logger.info("cFileUpload 요청");
		String root = session.getServletContext().getRealPath("/");
		return Community.cFileUpload(file, root);
	}

	// 보네 - (커뮤니티) 글 작성 중 파일 삭제
	@RequestMapping(value = "/cFileDel")
	public @ResponseBody HashMap<String, Integer> cFileDel(@RequestParam("fileName") String fileName,
			HttpSession session) {
		// RequestParam을 통해 fileName을, Session을 통해 경로를 뽑아온다.
		String root = session.getServletContext().getRealPath("/");
		logger.info("cFileDel 요청");
		return Community.cFileDel(root, fileName);
	}

	// 보네 - (커뮤니티) 글쓰기
	@RequestMapping(value = "/communityWrite")
	public ModelAndView communityWrite(@RequestParam HashMap<String, String> map) {
		logger.info("communityWrite 요청");
		return Community.communityWrite(map);
	}

	// 보네 - (커뮤니티) 메인
	@RequestMapping(value = "/communityMain")
	public String communityMain() {
		return "communityMain";
	}

	// 보네 - (커뮤니티) 리스트
	@RequestMapping(value = "/communityList")
	public @ResponseBody HashMap<String, Object> communityList(@RequestParam HashMap<String, String> map) {
		logger.info("커뮤니티 리스트 요청");
		return Community.communityList(map);
	}

	// 보네 - (커뮤니티) 상세 글 보기
	@RequestMapping(value = "/communityDetail")
	public ModelAndView communityDetail(@RequestParam("board_idx") String board_idx) {
		logger.info("커뮤니티 상세보기 : " + board_idx);
		return Community.communityDetail(board_idx);
	}

	// 보네 - (커뮤니티) 글 삭제
	@RequestMapping(value = "/communityDelete")
	public String communityDelete(@RequestParam("board_idx") String board_idx) {
		logger.info("커뮤니티 글 삭제 : " + board_idx);
		return Community.communityDelete(board_idx);
	}

	// 보네 - (커뮤니티) 글 수정 폼
	@RequestMapping(value = "/communityUpdateForm")
	public ModelAndView communityUpdateForm(@RequestParam("board_idx") String board_idx) {
		logger.info("커뮤니티 수정 폼 : " + board_idx);
		return Community.communityUpdateForm(board_idx);
	}

	// 보네 - (커뮤니티) 글 수정
	@RequestMapping(value = "/communityUpdate")
	public ModelAndView communityUpdate(@RequestParam HashMap<String, String> map) {
		logger.info("communityUpdate 요청");
		return Community.communityUpdate(map);
	}

	
	/*//////////////////////////////////////////////////용진/////////////////////////////////////////////////*/

	// 구조 후기 리스트 요청
	@RequestMapping(value = "saveMain")
	public String saveMain() {
		return "saveMain";
	}

	@RequestMapping(value = "/saveList")
	public @ResponseBody HashMap<String, Object> saveList(@RequestParam HashMap<String, String> map) {
		logger.info("구조 후기 글 리스트 요청");
		return save.saveList(map);
	}

	// 구조후기 글 작성 폼
	@RequestMapping(value = "/saveForm")
	public String saveForm(Model model) {
		logger.info("구조 후기 글 작성 폼 이동");
		return "saveForm";
	}

	// 구조후기 글 작성 요청
	@RequestMapping(value = "/saveWrite")
	public ModelAndView saveWrite(@RequestParam HashMap<String, String> params) {
		logger.info("구조 후기 글 작성 요청");
		return save.saveWrite(params);
	}

	// 구조후기 사진(파일) 등록 폼
	@RequestMapping(value = "/savePhotoWriteForm")
	public String savePhotoWriteForm() {
		logger.info("구조 후기 사진 등록 폼 이동");
		return "savePhotoWriteForm";
	}

	// 구조후기 사진 등록 요청
	@RequestMapping(value = "/savePhotoWrite")
	public ModelAndView savePhotoWrite(MultipartFile file, HttpSession session) {
		logger.info("구조 후기 사진 등록 요청");
		String root = session.getServletContext().getRealPath("/");
		return save.savePhotoWrite(file, root);
	}

	// 구조후기 글 작성 중 파일 삭제
	@RequestMapping(value = "/savePhotoDelete")
	public @ResponseBody HashMap<String, Integer> savePhotoDelete(@RequestParam("fileName") String fileName,
			HttpSession session) {
		// RequestParam을 통해 fileName을, Session을 통해 경로를 뽑아옴
		String root = session.getServletContext().getRealPath("/");
		logger.info("구조 후기 사진 삭제 요청");
		return save.savePhotoDelete(root, fileName);
	}

	// 구조후기 글 상세보기 요청
	@RequestMapping(value = "/saveDetail")
	public ModelAndView saveDetail(@RequestParam("board_idx") String board_idx) {
		logger.info("구조 후기 {}번 글 상세보기 요청 ", board_idx);
		return save.saveDetail(board_idx);
	}

	// 구조후기 글 삭제 요청
	@RequestMapping(value = "/saveDelete")
	public String saveDelete(@RequestParam("board_idx") String board_idx) {
		logger.info("구조 후기 {}번 글 삭제 요청" + board_idx);
		return save.saveDelete(board_idx);
	}

	// 구조후기 글 수정 폼
	@RequestMapping(value = "/saveUpdateForm")
	public ModelAndView saveUpdateForm(@RequestParam("board_idx") String board_idx) {
		logger.info("구조 후기 글 수정 폼 이동");
		return save.saveUpdateForm(board_idx);
	}

	// 구조후기 글 수정 요청
	@RequestMapping(value = "/saveUpdate")
	public ModelAndView saveUpdate(@RequestParam HashMap<String, String> map) {
		logger.info("구조 후기 글 수정 요청");
		return save.saveUpdate(map);
	}

	/* 입양후기 */
	// 입양 후기 리스트 요청v
	@RequestMapping(value = "adoptMain")
	public String adoptMain() {
		return "adoptMain";
	}

	@RequestMapping(value = "/adoptList")
	public @ResponseBody HashMap<String, Object> adoptList(@RequestParam HashMap<String, String> map) {
		logger.info("입양후기 글 리스트 요청");
		return Adopt.adoptList(map);
	}

	// 입양후기 글 작성 폼
	@RequestMapping(value = "/adoptForm")
	public String adoptForm(Model model) {
		logger.info("입양후기 글 작성 폼 이동");
		return "adoptForm";
	}

	// 입양후기 글 작성 요청
	@RequestMapping(value = "/adoptWrite")
	public ModelAndView adoptWrite(@RequestParam HashMap<String, String> params) {
		logger.info("입양후기 글 작성 요청");
		return Adopt.adoptWrite(params);
	}

	// 입양후기 사진(파일) 등록 폼
	@RequestMapping(value = "/adoptPhotoWriteForm")
	public String adoptPhotoWriteForm() {
		logger.info("입양후기 사진 등록 폼 이동");
		return "adoptPhotoWriteForm";
	}

	// 입양후기 사진 등록 요청
	@RequestMapping(value = "/adoptPhotoWrite")
	public ModelAndView adoptPhotoWrite(MultipartFile file, HttpSession session) {
		logger.info("입양후기 사진 등록 요청");
		String root = session.getServletContext().getRealPath("/");
		return Adopt.adoptPhotoWrite(file, root);
	}

	// 입양후기 글 작성 중 파일 삭제
	@RequestMapping(value = "/adoptPhotoDelete")
	public @ResponseBody HashMap<String, Integer> adoptPhotoDelete(@RequestParam("fileName") String fileName,
			HttpSession session) {
		// RequestParam을 통해 fileName을, Session을 통해 경로를 뽑아옴
		String root = session.getServletContext().getRealPath("/");
		logger.info("입양후기 사진 삭제 요청");
		return Adopt.adoptPhotoDelete(root, fileName);
	}

	// 입양후기 글 상세보기 요청
	@RequestMapping(value = "/adoptDetail")
	public ModelAndView adoptDetail(@RequestParam("board_idx") String board_idx) {
		logger.info("입양후기 {}번 글 상세보기 요청 ", board_idx);
		return Adopt.adoptDetail(board_idx);
	}

	// 입양후기 글 삭제 요청
	@RequestMapping(value = "/adoptDelete")
	public String adoptDelete(@RequestParam("board_idx") String board_idx) {
		logger.info("입양후기 {}번 글 삭제 요청" + board_idx);
		return Adopt.adoptDelete(board_idx);
	}

	// 입양후기 글 수정 폼
	@RequestMapping(value = "/adoptUpdateForm")
	public ModelAndView adoptUpdateForm(@RequestParam("board_idx") String board_idx) {
		logger.info("입양후기 글 수정 폼 이동");
		return Adopt.adoptUpdateForm(board_idx);
	}

	// 입양후기 글 수정 요청
	@RequestMapping(value = "/adoptUpdate")
	public ModelAndView adoptUpdate(@RequestParam HashMap<String, String> map) {
		logger.info("입양후기 글 수정 요청");
		return Adopt.adoptUdate(map);
	}

}