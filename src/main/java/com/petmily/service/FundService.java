package com.petmily.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.petmily.dao.boardDAO.BoardInter;
import com.petmily.dto.BoardDTO;

@Service
public class FundService {
	@Autowired
	SqlSession sqlSession;
	BoardInter inter;

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	HashMap<String, String> fileList = new HashMap<String, String>();
	HashMap<String, String> fileList2 = new HashMap<String, String>();

	String filen;
	String newFileName;

	int i = 0;
	int j = 0;

	// 소현: getmyList(마이리스트 페이징 처리 list 호출)
	public HashMap<String, Object> getmyList(HashMap<String, String> params, HttpSession session) {
		inter = sqlSession.getMapper(BoardInter.class);
		params.put("loginWriter", (String) session.getAttribute("loginId"));

		int allCnt = inter.mylistallCount(params);
		int pageCnt = allCnt % 6 > 0 ? Math.round(allCnt / 6) + 1 : allCnt / 6;

		HashMap<String, Object> myList = new HashMap<String, Object>();

		int page = Integer.parseInt(params.get("showPageNum"));
		if (page > pageCnt) {
			page = pageCnt;
		}
		int end = 6 * page;
		int start = end - 6 + 1;

		params.put("start", String.valueOf(start));
		params.put("end", String.valueOf(end));
		myList.put("list", inter.getmyList(params));

		myList.put("range", pageCnt);
		myList.put("currPage", page);

		return myList;
	}

	// 소현: 나의 모금 리스트 삭제
	public int delMylist(int idx) {
		inter = sqlSession.getMapper(BoardInter.class);
		System.out.println("삭제요" + idx);
		int success = inter.delMylist(idx);
		return success;
	}

	/* 소현: 나의 모금 리스트 사유보기 */
	public String reason(int idx) {
		inter = sqlSession.getMapper(BoardInter.class);
		System.out.println("넘어온 번호" + idx);
		String reason = inter.reason(idx);
		System.out.println("이유" + reason);
		return reason;
	}

	// 소현: 모금게시판 페이징 처리 list 호출
	public HashMap<String, Object> getfundList(HashMap<String, String> params) {
		inter = sqlSession.getMapper(BoardInter.class);
		int allCnt = inter.fundlistallCount(params);
		int pageCnt = allCnt % 15 > 0 ? Math.round(allCnt / 15) + 1 : allCnt / 15;
		HashMap<String, Object> fundList = new HashMap<String, Object>();
		int page = Integer.parseInt(params.get("showPageNum"));

		if (page > pageCnt) {
			page = pageCnt;
		}

		int end = 15 * page;
		int start = end - 15 + 1;

		params.put("start", String.valueOf(start));
		params.put("end", String.valueOf(end));
		/*
		 * params.put("sido", (String) params.get("sido")); params.put("sigundo",
		 * (String) params.get("sigundo"));
		 */

		fundList.put("list", inter.getfundList(params));
		// 생성 페이지의 수
		fundList.put("range", pageCnt);
		// 현재 페이지 번호
		fundList.put("currPage", page);

		return fundList;
	}

	@Transactional
	public ModelAndView writefundbbs(HashMap<String, String> params, RedirectAttributes redirectAtt) {
		ModelAndView mav = new ModelAndView();
		String page = "redirect:/fundWrite";
		String msg = "";
		System.out.println("서비스 접근");

		BoardDTO board = new BoardDTO();
		board.setFund_area(params.get("sido") + " " + params.get("sigundo"));
		board.setBoard_type(params.get("board_type"));
		board.setBoard_title(params.get("board_title"));
		board.setBoard_content(params.get("board_content"));
		board.setBoard_writer(params.get("board_writer"));
		board.setFund_centerName(params.get("fund_centerName"));
		board.setMainPhoto(params.get("main"));

		// 글쓰기 DB적용
		inter = sqlSession.getMapper(BoardInter.class);

		System.out.println("board.getidx:" + board.getBoard_idx());
		if (inter.writebbs(board) == 1) {
			// 성공하면 fileList 내용을 DB에 적용
			page = "redirect:funddetail?idx=" + board.getBoard_idx();
			if (fileList.size() > 0) {// 저장할 파일이 있을 경우
				String main = "X";
				for (String key : fileList.keySet()) { // map에서 키를 뽑아온다.
					// map에서 키를 뽑아온다. newFile, oldFile, idx
					if (key.equals(board.getMainPhoto())) {
						main = "대표이미지";
					} else {
						main = "x";
					}
					inter.writeFile(key, fileList.get(key), board.getBoard_idx(), main);
				}
				inter.writefund(board.getBoard_idx(), board.getFund_centerName(), board.getFund_area());
				i = 0;
				j = 0;
			}
		}
		fileList.clear();

		mav.setViewName(page);

		System.out.println(board.getBoard_writer());
		System.out.println(board.getBoard_title());
		System.out.println(board.getBoard_content());
		return mav;
	}

	public HashMap<String, Integer> fileDel(String root, String fileName) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		i--;
		logger.info("삭제 i:iiii{}", i);
		int success = 0;
		try {
			String fullPath = root + "resources/upload/" + fileName;
			File file = new File(fullPath);
			if (file.exists()) {// 삭제할 파일이 존재 한다면
				file.delete();// 파일 삭제

				logger.info("파일 수정");
			} else {
				logger.info("이미 삭제된 사진");
			}

			if (fileList.get(fileName) != null) {// map 에 해당 파일 명이 존재하면
				// 해당 파일명이 DB 에 있으면? -> DB 에서 삭제
				logger.info("수정된 파일 명 : {}", fileName);
				inter = sqlSession.getMapper(BoardInter.class);
				// fileName DB 에 있는지 확인

				fileList.remove(fileName);// 리스트 삭제
				logger.info("삭제 후 남은 파일 갯수 : {}", fileList.size());
			}

			success = 1;
		} catch (Exception e) {
			System.out.println(e.toString());
			success = 0;
		} finally {
			logger.info("success : " + success);
			map.put("success", success);
		}
		return map;
	}

	public HashMap<String, Integer> filetwoDel(String root, String fileName) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		j--;
		logger.info("삭제 j:{}", j);
		int success = 0;
		try {
			String fullPath = root + "resources/upload/" + fileName;
			File file = new File(fullPath);
			if (file.exists()) {// 삭제할 파일이 존재 한다면
				file.delete();// 파일 삭제

				logger.info("파일 수정");
			} else {
				logger.info("이미 삭제된 사진");
			}

			if (fileList.get(fileName) != null) {// map 에 해당 파일 명이 존재하면
				// 해당 파일명이 DB 에 있으면? -> DB 에서 삭제
				logger.info("수정된 파일 명 : {}", fileName);
				inter = sqlSession.getMapper(BoardInter.class);
				// fileName DB 에 있는지 확인

				fileList.remove(fileName);// 리스트 삭제
				logger.info("삭제 후 남은 파일 갯수 : {}", fileList.size());
			}

			success = 1;
		} catch (Exception e) {
			System.out.println(e.toString());
			success = 0;
		} finally {
			logger.info("success : " + success);
			map.put("success", success);
		}
		return map;
	}

	public boolean checkphoto() {
		boolean photo = false;// 사진이 없으면 false 반환
		System.out.println("파일: " + fileList.size());
		if (fileList.size() > 0) {// 저장할 파일이 있을 경우
			photo = true;
		}

		return photo;
	}

	public boolean checkonephoto() {
		boolean photo = false;// 사진이 3개 이하면 false 반환
		logger.info("사진 체크 파일 이름33333:{}", newFileName);
		filen = newFileName.split("~")[0];
		logger.info(" 사진 체크파일 이름:{}", filen);
		// if(quizAnswer.equals(answer)) {
		if (filen.equals("동물")) {// 저장할 파일이 있을 경우

			i++;// 1
			logger.info("i222:{}", i);
		}
		if (filen.equals("영수증")) {// 저장할 파일이 있을 경우
			j++;// 1
			logger.info("j222:{}", j);
		}

		if (i > 3 || j > 1) {
			photo = true;
			logger.info("i3433는?:{}", i);
			logger.info("j3433는?:{}", j);
		}
		logger.info("포토:{}", photo);

		return photo;

	}

	public ModelAndView upload(MultipartFile file, String root) {
		logger.info("파일업로드");
		ModelAndView mav = new ModelAndView();
		// String fullPath = "resources/fundupload/";
		String fullPath = root + "resources/upload/";

		System.out.println("ddd");
		// 1. 폴더가 없을 경우 폴더 생성
		File dir = new File(fullPath);
		if (!dir.exists()) {
			logger.info("폴더 없음, 생성 시작");
			dir.mkdir();

		}

		String fname = "동물";
		String slash = "~";
		// 2. 파일명 추출
		String fileName = file.getOriginalFilename();

		// 3.새 파일명 생성
		newFileName = fname + slash + System.currentTimeMillis() + fileName.substring(fileName.lastIndexOf("."));
		String msg = "성공";
		// String filen = newFileName.split("~")[0];

		checkonephoto();

		logger.info("파일 이름1111:{}", newFileName);

		// 4. 파일 추출
		try {
			byte[] bytes = file.getBytes(); // multipartFile에서 부터 바이트 추출
			Path filePath = Paths.get(fullPath + newFileName); // 파일 생성 경로
			Files.write(filePath, bytes); // 파일 생성
			fileList.put(newFileName, fileName);

			logger.info("저장할 파일 갯수:{}", fileList.size());

			logger.info("저장할 파일 갯수:{}", fileList.size());
			mav.addObject("msg", msg);
			mav.addObject("path", "resources/upload/" + newFileName);
		} catch (IOException e) {
			e.printStackTrace();
		}

		mav.setViewName("animalupload");
		return mav;
	}

	public ModelAndView Photoupload(MultipartFile file, String root) {
		logger.info("파일업로드");
		ModelAndView mav = new ModelAndView();
		// String fullPath = "resources/fundupload/";
		String fullPath = root + "resources/upload/";
		// 1. 폴더가 없을 경우 폴더 생성
		File dir = new File(fullPath);
		if (!dir.exists()) {
			logger.info("폴더 없음, 생성 시작");
			dir.mkdir();

		}

		String fname = "영수증";
		// 2. 기존 파일명 추출
		String slash = "~";
		// 2. 파일명 추출
		String fileName = file.getOriginalFilename();

		// 3.새 파일명 생성
		newFileName = fname + slash + System.currentTimeMillis() + fileName.substring(fileName.lastIndexOf("."));
		String msg = "성공";
		logger.info("영수증 파일 이름1111:{}", newFileName);
		checkonephoto();

		// 4. 파일 추출
		try {
			byte[] bytes = file.getBytes(); // multipartFile에서 부터 바이트 추출
			Path filePath = Paths.get(fullPath + newFileName); // 파일 생성 경로
			Files.write(filePath, bytes); // 파일 생성

			fileList.put(newFileName, fileName);

			mav.addObject("path", "resources/upload/" + newFileName);

		} catch (IOException e) {
			e.printStackTrace();
		}

		mav.setViewName("receiptUpload");
		return mav;
	}

	public ModelAndView funddetail(String idx) {
		ModelAndView mav = new ModelAndView();
		inter = sqlSession.getMapper(BoardInter.class);
		// 상세보기 정보
		mav.addObject("dto", inter.funddetail(idx));
		inter.uphit(idx); // 조회수

		// 파일 정보(다운로드 리스트)
		ArrayList<BoardDTO> files = inter.fundfileList(idx);
		mav.addObject("files", files);
		mav.addObject("size", files.size());// 첨부 파일 유무 확인
		mav.setViewName("funddetail");
		return mav;
	}

	public ModelAndView fundupdateForm(Model model) {
		inter = sqlSession.getMapper(BoardInter.class);
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");

		int idx = Integer.parseInt(request.getParameter("idx")); // idx = 해당 게시글 번호
		BoardDTO dto = new BoardDTO();
		dto = inter.fundupdateForm(idx);
		ModelAndView mav = new ModelAndView(); // ModelAndView 객체 생성
		mav.addObject("dto", dto); // addObject 메서드를 이용해 뷰(UI)에 전달할 값을 추가한다.

		String call = request.getParameter("call");
		String page = "redirect:funddetail";
		if (call.equals("funddetail")) {
			page = "funddetail";
		} else {
			page = "fundupdateForm";
		}
		mav.setViewName(page);
		return mav;
	}

	// 소현 : getagreeList(관리자 승인 대기 list호출 페이징 처리)
	public HashMap<String, Object> getagreeList(HashMap<String, String> params) {
		inter = sqlSession.getMapper(BoardInter.class);
		int allCnt = inter.agreelistallCount(params);
		// 생성 가능한 페이지 수 구하기
		int pageCnt = allCnt % 10 > 0 ? Math.round(allCnt / 10) + 1 : allCnt / 10;
		// 리턴을 위한 맵 생성
		HashMap<String, Object> agreeList = new HashMap<String, Object>();
		int page = Integer.parseInt(params.get("showPageNum"));

		// 클라이언트가 원한 페이지가 최종 페이지보다 높은 경우..
		if (page > pageCnt) {
			page = pageCnt;
		}

		int end = 10 * page;
		int start = end - 10 + 1;

		params.put("start", String.valueOf(start));
		params.put("end", String.valueOf(end));

		agreeList.put("list", inter.getagreeList(params));
		// 생성 페이지의 수
		agreeList.put("range", pageCnt);
		// 현재 페이지 번호
		agreeList.put("currPage", page);

		return agreeList;
	}

	// 소현: 관리자 페이지 승인 리스트 승인 버튼 클릭시 승인
	public int agreeAd(int idx) {
		inter = sqlSession.getMapper(BoardInter.class);
		int success = inter.getagreeAdmin(idx);
		return success;
	}

	// 소현: 관리자 페이지 승인 리스트 거부 버튼 클릭시 클릭한 idx값
	public int sendno(int idx) {
		inter = sqlSession.getMapper(BoardInter.class);
		int success = inter.getnoreasonidx(idx);
		return success;
	}

	// 소현: 관리자 페이지 승인 리스트 거부 버튼 클릭시 거절사유 전송
	public int sendreason(int idx, String reason) {
		inter = sqlSession.getMapper(BoardInter.class);
		int success = inter.getnoreason(idx, reason);
		return success;
	}

	// 소현 : 수정 등록시
	public ModelAndView fundupdate(HashMap<String, String> params) {
		ModelAndView mav = new ModelAndView();
		// 1. 파라메터 값을 받아온다.
		String idx = params.get("idx");
		String content = params.get("content");
		String subject = params.get("subject");
		logger.info(idx + "/" + content + "/" + subject);
		inter = sqlSession.getMapper(BoardInter.class);
		String page = "redirect:/fundupdateForm?idx=" + idx;
		// 2. 수정 쿼리 실행
		int success = inter.fundupdate(subject, content, idx);
		logger.info("success : " + success);
		if (success > 0) {
			page = "redirect:/funddetail?idx=" + idx;
		}

		mav.setViewName(page);
		return mav;
	}

	/* 소현 :즐겨찾기 리스트 출력 페이징 처리 */
	public HashMap<String, Object> getlikeList(HashMap<String, String> params) {
		inter = sqlSession.getMapper(BoardInter.class);
		int allCnt = inter.likeallCount(params);
		// 생성 가능한 페이지 수 구하기
		int pageCnt = allCnt % 10 > 0 ? Math.round(allCnt / 10) + 1 : allCnt / 10;
		// 리턴을 위한 맵 생성
		HashMap<String, Object> likeList = new HashMap<String, Object>();
		int page = Integer.parseInt(params.get("showPageNum"));

		// 클라이언트가 원한 페이지가 최종 페이지보다 높은 경우..
		if (page > pageCnt) {
			page = pageCnt;
		}

		int end = 10 * page;
		int start = end - 10 + 1;

		params.put("start", String.valueOf(start));
		params.put("end", String.valueOf(end));

		likeList.put("list", inter.getlikeList(params));
		// 생성 페이지의 수
		likeList.put("range", pageCnt);
		// 현재 페이지 번호
		likeList.put("currPage", page);

		return likeList;
	}

	// 소현: 즐겨찾기 리스트 삭제
	public int delLikelist(int idx) {
		inter = sqlSession.getMapper(BoardInter.class);
		System.out.println("라이크리스트삭제요" + idx);
		int success = inter.delLikelist(idx);
		return success;
	}

	public ModelAndView funddelete(Model model) {
		inter = sqlSession.getMapper(BoardInter.class);
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		int idx = Integer.parseInt(request.getParameter("idx")); // idx = 해당 게시글 번호
		logger.info("삭제할 글번호:", idx);
		int success = inter.funddelete(idx);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/fundMain");// 삭제 성공시 리스트 이동

		return mav;
	}

}
