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
public class AdoptService {
	@Autowired
	SqlSession sqlSession;

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	BoardInter inter;
	HashMap<String, String> fileList = new HashMap<String, String>();

	// 입양후기 글 리스트 요청(페이징 포함)
	public HashMap<String, Object> adoptList(HashMap<String, String> map) {
		inter = sqlSession.getMapper(BoardInter.class);
		int allCnt = inter.adoptList(map).size(); // 전체 게시글 수
		logger.info("allCnt:" + allCnt);
		int range = allCnt % 15 > 0 ? Math.round(allCnt / 15) + 1 : allCnt / 15;// 생성가능 페이지 수
		logger.info("range:" + range);
		HashMap<String, Object> aList = new HashMap<String, Object>();
		int page = Integer.parseInt(map.get("showPageNum")); // 보여줄 페이지
		logger.info("page:" + page);
		// 최종 페이지와 비교
		if (page > range) { // 기존에 보던 페이지가 최대 페이지보다 크면
			page = range; // 최대페이지로 띄워줌
		}
		int end = 15 * page;
		logger.info("end:" + end);
		int start = end - 15 + 1;
		logger.info("start:" + start);
		map.put("start", String.valueOf(start));
		map.put("end", String.valueOf(end));
		aList.put("aList", inter.adoptList(map));
		aList.put("range", range); // 생성 페이지 수
		aList.put("currPage", page); // 현재 페이지

		return aList;
	}

	// 입양후기 글 작성
	@Transactional
	public ModelAndView adoptWrite(HashMap<String, String> params) {
		ModelAndView mav = new ModelAndView();
		String msg = "작성 성공";
		String page = "./adoptMain";// 페이지 나중에 설정해주기 !!!!!-보네
		BoardDTO boardDTO = new BoardDTO();
		boardDTO.setBoard_writer(params.get("board_writer"));
		logger.info("boardDTO.getBoard_writer()" + boardDTO.getBoard_writer());
		boardDTO.setBoard_title(params.get("board_title"));
		logger.info("boardDTO.getBoard_title()" + boardDTO.getBoard_title());
		boardDTO.setBoard_content(params.get("board_content"));
		logger.info("boardDTO.getBoard_content()" + boardDTO.getBoard_content());

		////////////////////////////
		boardDTO.setAnimal_idx(params.get("selanimal"));
		logger.info("boardDTO.getAnimal_idx()" + boardDTO.getAnimal_idx());
		boardDTO.setAnimal_type(params.get("animal_type"));
		logger.info("boardDTO.getAnimal_type()" + boardDTO.getAnimal_type());
		boardDTO.setAdopt_loc1(params.get("selsido"));
		logger.info("boardDTO.getAdopt_loc1()" + boardDTO.getAdopt_loc1());
		boardDTO.setAdopt_loc2(params.get("adopt_loc2"));
		logger.info("boardDTO.getAdopt_loc2()" + boardDTO.getAdopt_loc2());
		logger.info("셀렉트문 확인 :" + boardDTO.getAnimal_idx() + "/" + boardDTO.getAdopt_loc1());
		inter = sqlSession.getMapper(BoardInter.class);
		// inter.adoptWrite(boardDTO);
		if (inter.adoptWrite(boardDTO) == 1) {
			// 성공하면 fileList 내용을 DB에 적용

			// 글 번호, 동물 종, 품종, 지역 데이터를 board_adopt 테이블에 저장
			inter.boardAdoptWrite(boardDTO);

			page = "redirect:/adoptDetail?board_idx=" + boardDTO.getBoard_idx();
			if (fileList.size() > 0) {// 저장할 파일이 있을 경우
				for (String key : fileList.keySet()) {// map에서 키를 뽑아온다.
					// newFile,oldFile,idx
					inter.adoptPhotoWrite(key, fileList.get(key), boardDTO.getBoard_idx());
				}
			}
		}
		fileList.clear();
		mav.addObject("msg", msg);
		mav.setViewName(page);
		return mav;
	}

	// 입양후기 글 사진 등록 요청
	public ModelAndView adoptPhotoWrite(MultipartFile file, String root) {
		ModelAndView mav = new ModelAndView();
		String fullPath = root + "resources/upload/";
		logger.info(fullPath);
		// 1. 폴더가 없을 경우 폴더 생성
		File dir = new File(fullPath);
		if (!dir.exists()) {
			logger.info("서비스: adoptPhotoWrite 메서드, 폴더가 없으므로 생성합니다");
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
		mav.setViewName("adoptPhotoWriteForm");
		return mav;
		// 자바 nio는 자바 버전 7 이상에서 쓸수있음... io보다 빠름
		// 파일 업로드 자체는 db 쓰지 않기때문에 interface 안가도 된다!
	}

	// 입양후기 글 사진 삭제 요청
	public HashMap<String, Integer> adoptPhotoDelete(String root, String fileName) {
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
				if (inter.adoptDelFileName(fileName) != null) {
					inter.adoptPhotoDelete(fileName);// newfilename을 기준으로 DB에서 삭제해주려고
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

	// 입양후기 글 상세보기
	@Transactional
	public ModelAndView adoptDetail(String board_idx) {
		ModelAndView mav = new ModelAndView();
		inter = sqlSession.getMapper(BoardInter.class);
		inter.aUpHit(board_idx);
		mav.addObject("aDetail", inter.adoptDetail(Integer.parseInt(board_idx)));
		mav.addObject("aDetailPhoto", inter.aDetailPhoto(Integer.parseInt(board_idx)));
		mav.addObject("boardAdoptDetail", inter.boardAdoptDetail(Integer.parseInt(board_idx)));
		mav.addObject("reply", board_idx);
		mav.setViewName("adoptDetail");
		return mav;
	}

	// 입양후기 글 삭제
	public String adoptDelete(String board_idx) {
		inter = sqlSession.getMapper(BoardInter.class);
		int success = inter.adoptDelete(Integer.parseInt(board_idx));
		String page = "adoptDetail?board_idx=" + board_idx;
		if (success > 0) {
			page = "adoptMain";
		}
		return page;
	}

	// 입양후기 글 수정 폼
	public ModelAndView adoptUpdateForm(String board_idx) {
		ModelAndView mav = new ModelAndView();
		inter = sqlSession.getMapper(BoardInter.class);
		mav.addObject("aUpdateForm", inter.adoptUpdateForm(Integer.parseInt(board_idx)));
		mav.addObject("boardAdoptDetail", inter.boardAdoptDetail(Integer.parseInt(board_idx)));
		mav.setViewName("adoptUpdateForm");
		return mav;
	}

	// 입양 후기 글 수정 요청
	public ModelAndView adoptUdate(HashMap<String, String> map) {
		ModelAndView mav = new ModelAndView();
		String page = "redirect:/adoptMain";// 페이지 나중에 설정해주기 !!!!!-보네
		BoardDTO boardDTO = new BoardDTO();
		boardDTO.setBoard_idx(Integer.parseInt(map.get("board_idx")));
		boardDTO.setBoard_title(map.get("board_title"));
		boardDTO.setBoard_content(map.get("board_content"));
		boardDTO.setAnimal_idx(map.get("selanimal"));
		boardDTO.setAnimal_type(map.get("animal_type"));
		boardDTO.setAdopt_loc1(map.get("selsido"));
		boardDTO.setAdopt_loc2(map.get("adopt_loc2"));
		inter = sqlSession.getMapper(BoardInter.class);
		inter.adoptUpdate(boardDTO);
		// 글 번호, 동물 종, 품종, 지역 데이터를 board_adopt 테이블에 저장
		inter.boardAdoptUpdate(boardDTO);
		mav.setViewName(page);
		return mav;
	}

}