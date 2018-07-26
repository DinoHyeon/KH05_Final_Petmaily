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
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
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
	HashMap<String, String> fileList = new HashMap<String, String>();

	/* 파일 업로드 */
	public ModelAndView mupload(MultipartFile file, String root) {
		ModelAndView mav = new ModelAndView();

		// 파일 업로드 할 전체 경로
		String fullPath = root + "resources/upload/";
		System.out.println(fullPath);
		// 폴더 없을 경우 폴더 생성
		File dir = new File(fullPath); // 전체경로를 담은 파일 선언
		if (!dir.exists()) {// 파일 존재하지 않을 경우
			System.out.println("파일 생성");
			dir.mkdirs();// 파일 생성
		}
		// 파일명 추출
		String fileName = file.getOriginalFilename(); // 원래 파일명
		System.out.println("fileName : " + fileName);
		// 새로운 파일명 생성(시스템시간(초)+원래파일명을 마지막에 있는 . 기준으로 자른 값)
		String newFileName = System.currentTimeMillis() + fileName.substring(fileName.lastIndexOf("."));
		System.out.println("newFileName : " + newFileName);
		// 파일 추출
		try {
			byte[] bytes = file.getBytes();// MultipartFile에서 바이트 추출
			Path filePath = Paths.get(fullPath + newFileName); // 파일 생성 경로(전체경로+새로운파일명)
			Files.write(filePath, bytes);// 파일생성
			fileList.put(newFileName, fileName); // DB에 나중에 저장할 파일리스트(새 파일명, 원래 파일명)
			logger.info("저장할 파일 갯수 : {}", fileList.size());
			mav.addObject("path", "resources/upload/" + newFileName);
		} catch (IOException e) {
			e.printStackTrace();
		}
		mav.setViewName("muploadForm");
		return mav;
	}

	/* 실종 게시판 리스트 */
	public HashMap<String, Object> missingList(HashMap<String, String> map) {
		inter = sqlSession.getMapper(BoardInter.class);

		// 전체 게시글 수 구하기
		int allCnt = inter.mgetAllCnt(map);

		logger.info("전체 게시글 수" + allCnt);
		// 생성 가능한 페이지 수 구하기
		int pageCnt = allCnt % 6 > 0 ? Math.round(allCnt / 6) + 1 : allCnt / 6;
		// 리턴을 위한 맵 생성
		HashMap<String, Object> missingList = new HashMap<String, Object>();

		int page = Integer.parseInt(map.get("showPageNum"));

		// 클라이언트가 원한 페이지가 최종 페이지보다 높은 경우..
		if (page > pageCnt) {
			page = pageCnt;
		}

		int end = 6 * page;
		int start = end - 6 + 1;

		map.put("start", String.valueOf(start));
		map.put("end", String.valueOf(end));

		missingList.put("list", inter.missingList(map));
		// 생성 페이지의 수
		missingList.put("range", pageCnt);
		// 현재 페이지 번호
		missingList.put("currPage", page);

		System.out.println(missingList.get("list"));

		return missingList;
	}

	/* 실종 게시판 상세보기 */
	public ModelAndView missingDetail(int board_idx, HttpSession session) {
		ModelAndView mav = new ModelAndView();

		String id = "";
		if (session.getAttribute("loginId") == null) {
			id = "비회원";
		} else {
			id = (String) session.getAttribute("loginId");
		}

		inter = sqlSession.getMapper(BoardInter.class);

		// 상세보기 정보
		mav.addObject("missingDetail", inter.missingDetail(board_idx));
		inter.uphit(board_idx); // 조회수
		// 첨부파일 정보
		ArrayList<BoardDTO> files = inter.fileList(board_idx);
		HashMap<String, Object> map = new HashMap<>();

		map.put("board_idx", board_idx);
		map.put("id", id);

		mav.addObject("files", files);
		mav.addObject("favorite", inter.favoriteChk(map));
		mav.addObject("size", files.size());// 첨부파일 유무
		mav.addObject("reply", board_idx);
		mav.setViewName("missingDetail");
		return mav;
	}

	/* 실종 게시판 글작성 */
	@Transactional
	public ModelAndView missingWrite(HashMap<String, String> map, String ipAddr, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String page = "redirect:/missingWriteForm"; // 글 등록 실패시 이동

		BoardDTO dto = new BoardDTO();
		dto.setMissing_loc(map.get("sido") + " " + map.get("sigundo"));
		dto.setAnimal_idx(map.get("animal")); // 동물종
		dto.setAnimal_type(map.get("animalType"));
		
		logger.info("내가선택한 동물 종 : "+map.get("animalType"));
		
		
		
		dto.setBoard_title(map.get("board_title"));
		dto.setBoard_content(map.get("board_content"));
		dto.setMainPhoto(map.get("main"));

		if (session.getAttribute("loginId")==null) { // loginId에 값이 없으면
			dto.setBoard_writer("비회원 " + ipAddr); // 작성자 : 비회원+ip주소
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder(); // 암호화
			dto.setMissing_pw(encoder.encode(map.get("pass")));
		} 
		if (session.getAttribute("loginId")!=null){
			dto.setBoard_writer((String) session.getAttribute("loginId"));
			dto.setMissing_pw("회원");

		}

		// DB에 글 등록
		inter = sqlSession.getMapper(BoardInter.class);

		if (inter.missingWrite(dto) == 1) {// 글 등록 성공
			page = "redirect:/missingDetail?board_idx=" + dto.getBoard_idx();
			if (fileList.size() > 0) {// 저장할 파일 있을 경우
				String main = "";
				for (String key : fileList.keySet()) {// map에서 첨부파일 key 값 추출
					if (key.equals(dto.getMainPhoto())) {
						main = "대표이미지";
					} else {
						main = "X";
					}
					inter.missingWriteFile(key, fileList.get(key), dto.getBoard_idx(), main);
				}
			}
			inter.board_missingWrite(dto);// board_missing 테이블에 글 등록
		}
		fileList.clear();// 글 작성 후 파일리스트를 한번 비워야지 다음 글쓰기시 중복X
		System.out.println("글 등록 완료 후 파일 리스트 : " + fileList.size());
		mav.setViewName(page);
		return mav;
	}

	/* 실종 글 수정 페이지 */
	public ModelAndView missingUpdateForm(int board_idx) {
		ModelAndView mav = new ModelAndView();

		inter = sqlSession.getMapper(BoardInter.class);

		// 상세보기 정보
		mav.addObject("missingDetail", inter.missingDetail(board_idx));
		// 파일 정보
		ArrayList<BoardDTO> files = inter.fileList(board_idx);
		for (BoardDTO dto : files) {
			fileList.put(dto.getPhoto_newName(), dto.getPhoto_oriName());

		}

		mav.addObject("files", files);
		mav.addObject("size", files.size()); // 첨부파일 유무
		mav.setViewName("missingUpdateForm");

		return mav;
	}

	/* 실종 게시판 첨부 파일 삭제 */
	public HashMap<String, Integer> mFileDel(String root, String fileName) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();

		int success = 0; // 이미지 성공 실패여부[0|1]

		try {
			String fullPath = root + "resources/upload/" + fileName;
			File file = new File(fullPath); // 전체 경로 담은 파일생성
			if (file.exists()) {// 삭제할 파일 존재
				file.delete();
			} else {
				logger.info("존재하지 않은 파일 입니다.");
			}

			// DB에서 파일 삭제
			if (fileList.get(fileName) != null) {// 파일리스트에 해당 파일이름 존재
				inter = sqlSession.getMapper(BoardInter.class);
				// fileName DB에 있는지 확인
				if (inter.mDelFileName(fileName) != null) {// 삭제할 파일명 존재
					inter.mFileDelete(fileName); // 해당이름 가진 파일(newFileName) DB에서 삭제
					fileList.remove(fileName); // 파일 리스트에서도 해당 이름 가진 파일 삭제
				}
			}
			success = 1; // 파일 삭제 성공
		} catch (Exception e) {
			success = 0; // 파일 삭제 실패
		} finally {
			map.put("success", success); // 파일 삭제 성공 여부 map 에 담기
		}
		fileList.clear();// 글 작성 후 파일리스트를 한번 비워야지 다음 글쓰기시 중복X
		return map;
	}

	/* 실종 게시글 삭제 */
	public ModelAndView missingDelete(Model model) {
		inter = sqlSession.getMapper(BoardInter.class);
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		int board_idx = Integer.parseInt(request.getParameter("board_idx"));
		logger.info("삭제할 글 번호 :" + board_idx);
		int success = inter.missingDelete(board_idx);

		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/missingList");// 삭제 성공시 리스트 이동

		return mav;
	}

	/* 실종 글 수정 */
	@Transactional
	public ModelAndView missingUpdate(HashMap<String, String> map) {
		ModelAndView mav = new ModelAndView();

		// 파라메터 값 받기
		String board_idx = map.get("board_idx");
		String missing_loc = map.get("sido") + map.get("sigundo");
		String animal_idx = map.get("animal");
		String animal_type = map.get("animalType");
		String board_title = map.get("board_title");
		String board_content = map.get("board_content");

		BoardDTO dto = new BoardDTO();
		dto.setMainPhoto(map.get("mainPhoto"));
		System.out.println(map.get("mainPhoto"));

		inter = sqlSession.getMapper(BoardInter.class);
		// 수정 실패
		String page = "redirect:/missingUpdateForm?board_idx=" + board_idx;

		// 쿼리 실행
		int success = inter.missingUpdate(board_idx, board_title, board_content);
		if (success > 0) {// 수정 성공
			page = "redirect:/missingDetail?board_idx=" + board_idx;
			inter.board_missingUpdate(board_idx, missing_loc, animal_idx, animal_type);

		}

		// 파일에 변화가 있을 경우 파일 관련 쿼리 실행
		int size = fileList.size();
		logger.info("list size : " + size);
		if (size > 0) {// 기존 파일이 남아 있거나, 추가 되었거나...
			for (String key : fileList.keySet()) {// map 에서 키를 뽑아 온다.
				String main = "X";
				if (key.equals(dto.getMainPhoto())) {
					main = "대표이미지";
				}
				// 중복 방지를 위해 기존 데이터 삭제
				logger.info("newFile : {}", key);
				inter.mFileDelete(key);
				// 이후 추가
				inter.missingWriteFile(key, fileList.get(key), Integer.parseInt(board_idx), main);
			}
		}
		fileList.clear();
		mav.setViewName(page);
		return mav;
	}

	public boolean mcheckphoto() {
		boolean photo = false;// 사진이 없으면 false 반환
		System.out.println("파일: " + fileList.size());
		if (fileList.size() > 0) {// 저장할 파일이 있을 경우
			photo = true;
		}

		return photo;
	}

	public boolean passChk(HashMap<String, String> params) {
		inter = sqlSession.getMapper(BoardInter.class);
		// param값으로 해당 글의 pass 출력
		String writingPass = inter.getPass(params);
		// 비교해서 결과 값 return
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		System.out.println("DB비밀번호 : " + writingPass);
		System.out.println("입력비밀번호 : " + params.get("pass"));
		return encoder.matches(params.get("pass"), writingPass);
	}

	public int favoriteRegist(HashMap<String, String> map, HttpSession session) {
		inter = sqlSession.getMapper(BoardInter.class);
		map.put("id", (String) session.getAttribute("loginId"));
		return inter.favoriteRegist(map);
	}

	public int favoriteDel(HashMap<String, String> map, HttpSession session) {
		inter = sqlSession.getMapper(BoardInter.class);
		map.put("id", (String) session.getAttribute("loginId"));
		return inter.favoriteDel(map);
	}

	public void photoClear() {
		System.out.println("사진 리스트 클리어");
		fileList.clear();
	}

}
