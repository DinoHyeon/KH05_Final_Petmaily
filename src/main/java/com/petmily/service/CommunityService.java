package com.petmily.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
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
public class CommunityService {
	@Autowired
	SqlSession sqlSession;
	BoardInter inter;
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	HashMap<String, String> fileList = new HashMap<String, String>();

	// 보네 - (커뮤니티) 글쓰기
	@Transactional
	public ModelAndView communityWrite(HashMap<String, String> map) {
		ModelAndView mav = new ModelAndView();
		String page = "redirect:/communityForm";// 게시글 등록 실패시
		BoardDTO boardDTO = new BoardDTO();
		boardDTO.setBoard_writer(map.get("board_writer"));
		boardDTO.setBoard_title(map.get("board_title"));
		boardDTO.setBoard_content(map.get("board_content"));
		inter = sqlSession.getMapper(BoardInter.class);
		if (inter.communityWrite(boardDTO) == 1) {// 게시글 등록 성공시
			page = "redirect:/communityDetail?board_idx=" + boardDTO.getBoard_idx();
			for (String key : fileList.keySet()) {// map에서 첨부파일 key 값 추출
				inter.cWriteFile(key, fileList.get(key), boardDTO.getBoard_idx());
			}
		}
		fileList.clear();
		logger.info("커뮤니티 글 작성 후 fileList size:" + fileList.size());
		mav.setViewName(page);
		return mav;
	}

	// 보네 - (커뮤니티) 파일 등록
	public ModelAndView cFileUpload(MultipartFile file, String root) {
		ModelAndView mav = new ModelAndView();
		String fullPath = root + "resources/upload/";
		logger.info("cFileUpload 경로 : " + fullPath);
		// 1. 폴더가 없을 경우 폴더 생성
		File dir = new File(fullPath);
		if (!dir.exists()) {
			logger.info("cFileUpload 폴더 없음, 폴더 생성");
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
			logger.info("cFileUpload 저장할 파일 개수 : {}", fileList.size());
			mav.addObject("path", "resources/upload/" + cNewFileName);
		} catch (IOException e) {
			e.printStackTrace();
		}
		mav.setViewName("cFileUploadForm");
		return mav;
	}

	// 보네 - (커뮤니티) 파일 삭제
	public HashMap<String, Integer> cFileDel(String root, String fileName) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		int success = 0; // 성공 개수
		try {
			String fullPath = root + "resources/upload/" + fileName;
			File file = new File(fullPath);
			if (file.exists()) {// 삭제할 파일이 존재한다면
				file.delete();// 파일 삭제
			} else {
				logger.info("커뮤니티 파일 삭제 - 이미 삭제된 사진");
			}
			// 해당 파일명이 DB에 있으면 ?-> DB에서 삭제
			if (fileList.get(fileName) != null) {// map에 해당 파일 명이 존재하면
				System.out.println("여기유" + fileList.get(fileName));
				inter = sqlSession.getMapper(BoardInter.class);
				// fileName이 DB에 있는지 확인
				if (inter.cDelFileName(fileName) != null) {
					System.out.println("돈다");
					inter.cFileDelete(fileName);// newfilename을 기준으로 DB에서 삭제해주려고
					fileList.remove(fileName);// 파일리스트에서 삭제
				}

				logger.info("cFileUpload 삭제 후 남은 파일 개수 : {}", fileList.size());
			}
			success = 1;
		} catch (Exception e) {
			success = 0;
		} finally {
			map.put("success", success);
		}
		// fileList.clear(); 문제되는지 다시 확인
		return map;
	}

	// 보네 - (커뮤니티) 리스트
	public HashMap<String, Object> communityList(HashMap<String, String> map) {
		fileList.clear();// 파일리스트 클리어를 미리 실행해준다->추후 취소시 문제 생기지 않게 하려고
		inter = sqlSession.getMapper(BoardInter.class);
		int allCnt = inter.communityList(map).size(); // 전체 게시글 수
		int range = allCnt % 15 > 0 ? Math.round(allCnt / 15) + 1 : allCnt / 15;// 생성가능 페이지 수
		HashMap<String, Object> cList = new HashMap<String, Object>();
		int page = Integer.parseInt(map.get("showPageNum")); // 보여줄 페이지
		// 최종 페이지와 비교
		if (page > range) { // 기존에 보던 페이지가 최대 페이지보다 크면
			page = range; // 최대페이지로 띄워줌
		}
		int end = 15 * page;
		int start = end - 15 + 1;
		map.put("start", String.valueOf(start));
		map.put("end", String.valueOf(end));
		cList.put("cList", inter.communityList(map));
		cList.put("range", range); // 생성 페이지 수
		cList.put("currPage", page); // 현재 페이지
		return cList;
	}

	@Transactional
	// 보네 - (커뮤니티) 상세보기
	public ModelAndView communityDetail(String board_idx) {
		fileList.clear();// 수정폼에서 취소시 List 초기화하려고
		ModelAndView mav = new ModelAndView();
		inter = sqlSession.getMapper(BoardInter.class);
		inter.cUpHit(Integer.parseInt(board_idx));
		mav.addObject("cDetail", inter.communityDetail(Integer.parseInt(board_idx)));
		// mav.addObject("cDetailPhoto",
		// inter.cDetailPhoto(Integer.parseInt(board_idx)));
		mav.setViewName("communityDetail");
		return mav;
	}

	// 보네 - (커뮤니티) 글 삭제
	public String communityDelete(String board_idx) {
		inter = sqlSession.getMapper(BoardInter.class);
		int success = inter.communityDelete(Integer.parseInt(board_idx));
		String page = "communityDetail?board_idx=" + board_idx;
		if (success > 0) {
			page = "communityMain";
		}
		return page;
	}

	// 보네 - (커뮤니티) 수정 폼
	public ModelAndView communityUpdateForm(String board_idx) {
		ModelAndView mav = new ModelAndView();
		inter = sqlSession.getMapper(BoardInter.class);
		// 파일 정보
		ArrayList<BoardDTO> cFiles = inter.cFileList(Integer.parseInt(board_idx));
		for (BoardDTO boardDTO : cFiles) {
			fileList.put(boardDTO.getPhoto_newName(), boardDTO.getPhoto_oriName());
		}
		mav.addObject("cUpdateForm", inter.communityUpdateForm(Integer.parseInt(board_idx)));
		mav.addObject("cFiles", cFiles);
		mav.addObject("size", cFiles.size()); // 첨부파일 유무
		logger.info("커뮤니티 수정 폼 filesize" + cFiles.size());
		mav.setViewName("communityUpdateForm");
		return mav;
	}

	// 보네 - (커뮤니티) 수정
	public ModelAndView communityUpdate(HashMap<String, String> map) {
		ModelAndView mav = new ModelAndView();
		String page = "communityMain";// 필요시 페이지 수정
		BoardDTO boardDTO = new BoardDTO();
		boardDTO.setBoard_idx(Integer.parseInt(map.get("board_idx")));
		boardDTO.setBoard_title(map.get("board_title"));
		boardDTO.setBoard_content(map.get("board_content"));
		inter = sqlSession.getMapper(BoardInter.class);
		int success = inter.communityUpdate(boardDTO);
		if (success > 0) {// 수정 성공시
			page = "redirect:/communityDetail?board_idx=" + boardDTO.getBoard_idx();
		}
		// 파일에 변화가 있을 경우 파일 관련 쿼리 실행
		int size = fileList.size();
		logger.info("수정실행 - filelist size : " + size);
		if (size > 0) {// 수정된 글에 파일이 있을 경우
			for (String key : fileList.keySet()) {// map 에서 키를 뽑아 온다.
				// 중복 방지를 위해 기존 데이터 삭제
				logger.info("커뮤니티 newFile : {}", key);
				inter.cFileDelete(key);
				// 이후 추가
				inter.cWriteFile(key, fileList.get(key), boardDTO.getBoard_idx());
			}
		}
		fileList.clear();
		mav.setViewName(page);
		return mav;
	}
}
