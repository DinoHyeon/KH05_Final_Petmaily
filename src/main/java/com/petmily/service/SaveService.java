package com.petmily.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.petmily.dao.boardDAO.BoardInter;
import com.petmily.dto.BoardDTO;

@Service
public class SaveService {
	@Autowired
	SqlSession sqlSession;

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	BoardInter inter;
	HashMap<String, String> fileList = new HashMap<String, String>();

	// 구조후기 글 리스트 출력
	public HashMap<String, Object> saveList(HashMap<String, String> map) {
		inter = sqlSession.getMapper(BoardInter.class);
		int allCnt = inter.saveList(map).size(); // 전체 게시글 수
		int range = allCnt % 15 > 0 ? Math.round(allCnt / 15) + 1 : allCnt / 15;// 생성가능 페이지 수
		HashMap<String, Object> sList = new HashMap<String, Object>();
		int page = Integer.parseInt(map.get("showPageNum")); // 보여줄 페이지
		// 최종 페이지와 비교
		if (page > range) { // 기존에 보던 페이지가 최대 페이지보다 크면
			page = range; // 최대페이지로 띄워줌
		}
		int end = 15 * page;
		int start = end - 15 + 1;
		map.put("start", String.valueOf(start));
		map.put("end", String.valueOf(end));
		sList.put("sList", inter.saveList(map));
		sList.put("range", range); // 생성 페이지 수
		sList.put("currPage", page); // 현재 페이지

		/*
		 * String aSearchKey = map.get("cSearchKey"); //검색 키워드 String aSearchVal =
		 * map.get("cSearchVal"); //검색 값
		 */
		return sList;
	}

	// 구조후기 글 작성
	@Transactional
	public ModelAndView saveWrite(HashMap<String, String> params) {
		ModelAndView mav = new ModelAndView();
		String msg = "작성 성공";
		String page = "./saveMain";// 페이지 나중에 설정해주기 !!!!!-보네
		BoardDTO boardDTO = new BoardDTO();
		boardDTO.setBoard_writer(params.get("board_writer"));
		logger.info("boardDTO.getBoard_writer()" + boardDTO.getBoard_writer());
		boardDTO.setBoard_title(params.get("board_title"));
		logger.info("boardDTO.getBoard_title()" + boardDTO.getBoard_title());
		boardDTO.setBoard_content(params.get("board_content"));
		logger.info("boardDTO.getBoard_content()" + boardDTO.getBoard_content());
		////////////////////////////
		boardDTO.setSave_loc1(params.get("selsido"));
		logger.info("boardDTO.getsave_loc1()" + boardDTO.getSave_loc1());
		boardDTO.setSave_loc2(params.get("save_loc2"));
		logger.info("boardDTO.getSave_loc2()" + boardDTO.getSave_loc2());
		inter = sqlSession.getMapper(BoardInter.class);
		// inter.adoptWrite(boardDTO);
		if (inter.saveWrite(boardDTO) == 1) {
			// 성공하면 fileList 내용을 DB에 적용

			// 글 번호, 동물 종, 품종, 지역 데이터를 board_adopt 테이블에 저장
			inter.boardSaveWrite(boardDTO);

			page = "redirect:/saveDetail?board_idx=" + boardDTO.getBoard_idx();
			if (fileList.size() > 0) {// 저장할 파일이 있을 경우
				for (String key : fileList.keySet()) {// map에서 키를 뽑아온다.
					// newFile,oldFile,idx
					inter.savePhotoWrite(key, fileList.get(key), boardDTO.getBoard_idx());
				}
			}
		}
		fileList.clear();
		mav.addObject("msg", msg);
		mav.setViewName(page);
		return mav;
	}

	// 구조후기 글 사진 등록 요청
	public ModelAndView savePhotoWrite(MultipartFile file, String root) {
		ModelAndView mav = new ModelAndView();
		String fullPath = root + "resources/upload/";
		logger.info(fullPath);
		// 1. 폴더가 없을 경우 폴더 생성
		File dir = new File(fullPath);
		if (!dir.exists()) {
			logger.info("서비스: savePhotoWrite 메서드, 폴더가 없으므로 생성합니다");
			dir.mkdir();
		}
		// 2. 파일명 추출
		String cOriFileName = file.getOriginalFilename();
		// 3. 새로운 파일명 생성
		String cNewFileName = System.currentTimeMillis() + cOriFileName.substring(cOriFileName.lastIndexOf("."));
		// 4. 새 파일명으로 파일 변경
		try {
			byte[] bytes = file.getBytes(); // MultipartFile에서부터 바이트 추출
			Path filePath = Paths.get(fullPath + cNewFileName); // 파일 생성 경로
			Files.write(filePath, bytes); // 파일 생성
			fileList.put(cNewFileName, cOriFileName);
			logger.info("저장할 파일 개수 : {}", fileList.size());
			mav.addObject("path", "resources/upload/" + cNewFileName);
		} catch (IOException e) {
			e.printStackTrace();
		}
		mav.setViewName("savePhotoWriteForm");
		return mav;
		// 자바 nio는 자바 버전 7 이상에서 쓸수있음... io보다 빠름
		// 파일 업로드 자체는 db 쓰지 않기때문에 interface 안가도 된다!
	}

	// 구조후기 글 사진 삭제
	public HashMap<String, Integer> savePhotoDelete(String root, String fileName) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		int success = 0;
		try {
			String fullPath = root + "resources/upload/" + fileName;
			File file = new File(fullPath);
			if (file.exists()) {// 삭제할 파일이 존재한다면
				file.delete();// 파일 삭제
			} else {
				logger.info("이미 삭제된 사진");
			}
			// 해당 파일명이 DB에 있으면 ?-> DB에서 삭제
			if (fileList.get(fileName) != null) {// map에 해당 파일 명이 존재하면
				inter = sqlSession.getMapper(BoardInter.class);
				// fileName이 DB에 있는지 확인
				if (inter.saveDelFileName(fileName) != null) {
					inter.savePhotoDelete(fileName);// newfilename을 기준으로 DB에서 삭제해주려고
				}
				fileList.remove(fileName);
				logger.info("삭제 후 남은 파일 갯수 : {}", fileList.size());
			}
			success = 1;
		} catch (Exception e) {
			success = 0;
		} finally {
			map.put("success", success);
		}
		return map;
	}

	// 구조후기 글 상세보기
	@Transactional
	public ModelAndView saveDetail(String board_idx) {
		ModelAndView mav = new ModelAndView();
		inter = sqlSession.getMapper(BoardInter.class);
		inter.sUpHit(board_idx);
		mav.addObject("sDetail", inter.saveDetail(Integer.parseInt(board_idx)));
		mav.addObject("sDetailPhoto", inter.sDetailPhoto(Integer.parseInt(board_idx)));
		mav.addObject("boardSaveDetail", inter.boardSaveDetail(Integer.parseInt(board_idx)));
		mav.setViewName("saveDetail");
		return mav;
	}

	// 구조후기 글 삭제
	public String saveDelete(String board_idx) {
		inter = sqlSession.getMapper(BoardInter.class);
		int success = inter.saveDelete(Integer.parseInt(board_idx));
		String page = "saveDetail?board_idx=" + board_idx;
		if (success > 0) {
			page = "saveMain";
		}
		return page;
	}

	// 구조후기 글 수정 폼
	public ModelAndView saveUpdateForm(String board_idx) {
		ModelAndView mav = new ModelAndView();
		inter = sqlSession.getMapper(BoardInter.class);
		mav.addObject("sUpdateForm", inter.saveUpdateForm(Integer.parseInt(board_idx)));
		mav.addObject("boardSaveDetail", inter.boardSaveDetail(Integer.parseInt(board_idx)));
		mav.setViewName("saveUpdateForm");
		return mav;
	}

	// 구조후기 글 수정 요청
	public ModelAndView saveUpdate(HashMap<String, String> map) {
		ModelAndView mav = new ModelAndView();
		String page = "redirect:/saveMain";// 페이지 나중에 설정해주기 !!!!!-보네
		BoardDTO boardDTO = new BoardDTO();
		boardDTO.setBoard_idx(Integer.parseInt(map.get("board_idx")));
		boardDTO.setBoard_title(map.get("board_title"));
		boardDTO.setBoard_content(map.get("board_content"));
		boardDTO.setSave_loc1(map.get("selsido"));
		boardDTO.setSave_loc2(map.get("save_loc2"));
		inter = sqlSession.getMapper(BoardInter.class);
		inter.saveUpdate(boardDTO);
		// 글 번호, 동물 종, 품종, 지역 데이터를 board_adopt 테이블에 저장
		inter.boardSaveUpdate(boardDTO);
		mav.setViewName(page);
		return mav;
	}

}