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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.petmily.dao.boardDAO.BoardInter;
import com.petmily.dto.BoardDTO;

@Service
public class MissingService {
	@Autowired
	SqlSession sqlSession;
	BoardInter inter;

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	// 업로드 한 파일명을 저장 후 나중에 DB 에 추가<newFileName,oldFileName>
	HashMap<String,String> fileList = new HashMap<String,String>();

	/* 파일 업로드 */
	public ModelAndView upload(MultipartFile file, String root) {
		System.out.println("파일업로드 서비스 ");
		ModelAndView mav = new ModelAndView();
		// 파일 업로드 할 전체 경로
		String fullPath = root+"resources/upload/";
		System.out.println(fullPath);
		// 폴더 없을 경우 폴더 생성
		File dir = new File(fullPath); // 전체경로를 담은 파일 선언
		if(!dir.exists()) {// 파일 존재하지 않을 경우
			System.out.println("파일 생성");
			dir.mkdirs();// 파일 생성
		}
		// 파일명 추출
		String fileName = file.getOriginalFilename(); // 원래 파일명
		System.out.println("fileName : "+fileName);
		// 새로운 파일명 생성(시스템시간(초)+원래파일명을 마지막에 있는 . 기준으로 자른 값)
		String newFileName = System.currentTimeMillis() + fileName.substring(fileName.lastIndexOf("."));
		System.out.println("newFileName : "+newFileName);
		// 파일 추출
		try {
			byte[] bytes = file.getBytes();// MultipartFile에서 바이트 추출
			Path filePath = Paths.get(fullPath + newFileName); // 파일 생성 경로(전체경로+새로운파일명)
			Files.write(filePath, bytes);// 파일생성
			fileList.put(newFileName, fileName); // DB에 나중에 저장할 파일리스트(새 파일명, 원래 파일명)
			logger.info("저장할 파일 갯수 : {}",fileList.size());
			mav.addObject("path", "resources/upload/" + newFileName);
		} catch (IOException e) {
			e.printStackTrace();
		}
		mav.setViewName("uploadForm");
		return mav;
	}

	/* 실종 게시판 리스트 */
	public ModelAndView missingList(HashMap<String, Object> map) {
		inter = sqlSession.getMapper(BoardInter.class);

		ArrayList<BoardDTO> missingList = inter.missingList(map);

		ModelAndView mav = new ModelAndView();
		mav.addObject("missingList", missingList); // 보여줄 내용
		mav.setViewName("missingList");// 보여질 페이지
		return mav;
	}

	/* 실종 게시판 상세보기 */
	public ModelAndView missingDetail(int board_idx) {
		ModelAndView mav = new ModelAndView();

		inter = sqlSession.getMapper(BoardInter.class);

		mav.addObject("missingDetail", inter.missingDetail(board_idx));
		mav.setViewName("missingDetail");
		return mav;
	}

	/* 실종 게시판 글작성 */
	public ModelAndView missingWrite(HashMap<String, String> map) {
		ModelAndView mav = new ModelAndView();
		String page = "redirect:/missingWriteForm"; // 글 등록 실패시 이동

		BoardDTO dto = new BoardDTO();
		dto.setBoard_title(map.get("board_title"));
		dto.setBoard_content(map.get("content"));
		// DB에 글 등록
		inter = sqlSession.getMapper(BoardInter.class);

		if (inter.missingWrite(dto) == 1) {// 글 등록 성공
			page = "redirect:/missingDetail?board_idx=" + dto.getBoard_idx();
			if (fileList.size()>0) {// 저장할 파일 있을 경우
				for(String key : fileList.keySet()) {// map에서 첨부파일 key 값 추출
					inter.missingWriteFile(key, fileList.get(key), dto.getBoard_idx());
				}
			}
		}
		fileList.clear();//글 작성 후 파일리스트를 한번 비워야지 다음 글쓰기시 중복X
		mav.setViewName(page);
		return mav;
	}

}
