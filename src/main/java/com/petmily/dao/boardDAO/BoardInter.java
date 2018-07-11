package com.petmily.dao.boardDAO;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.web.servlet.ModelAndView;

import com.petmily.dto.BoardDTO;

public interface BoardInter {

	ArrayList<BoardDTO> protectList(HashMap<String, String> map); /* 보호 게시판 리스트 */

	ArrayList<BoardDTO> missingList(HashMap<String, String> map); /* 실종 게시판 리스트 */

	BoardDTO protectDetail(int board_idx); /* 보호 게시판 상세보기 */

	BoardDTO missingDetail(int board_idx); /* 실종 게시판 상세보기 */

	int missingWrite(BoardDTO dto); /* 실종 게시글 작성 */
	
	void board_missingWrite(BoardDTO dto); /* 게시글 등록 성공 -> 실종 게시판 글 등록*/

	void missingWriteFile(String newFile, String oldFile, int board_idx, String main); /* 실종 게시글 파일 업로드 */

	ArrayList<BoardDTO> fileList(int board_idx); /* 첨부파일 리스트 */

	int protectWrite(BoardDTO dto); /* 보호 게시글 작성 */

	void board_protectWrite(BoardDTO dto); /* 게시글 등록 성공 -> 보호 게시판 글 등록*/

	void protectWriteFile(String key, String string, int board_idx, String main); /* 보호 게시글 파일 업로드 */

	String pDelFileName(String fileName);/* 보호_삭제 파일명 확인*/

	int pFileDelete(String fileName); /* 보호_DB에서 파일 삭제*/
	
	int protectDelete(int board_idx);/* 보호 게시글 삭제*/

	String mDelFileName(String fileName);/* 실종_삭제 파일명 확인*/

	int mFileDelete(String fileName);/* 실종_DB에서 파일 삭제*/

	int missingDelete(int board_idx); /* 실종 게시글 삭제*/

	int missingUpdate(String board_idx, String board_title, String board_content); /* 실종_게시글 수정*/

	void board_missingUpdate(String board_idx, String missing_loc, String animal_idx, String animal_type); /* 실종_게시글 수정-> 실종  게시글 수정*/

	int protectUpdate(String board_idx, String board_title, String board_content); /* 보호_게시글 수정*/

	void board_protectUpdate(String board_idx, String protect_loc, String animal_idx, String animal_type); /* 보호_게시글 수정-> 보호  게시글 수정*/

	int mgetAllCnt(HashMap<String, String> map); /*실종_출력할 수 있는 전체 게시글 수*/

	int pGetAllCnt(HashMap<String, String> map); /*보호_출력할 수 있는 전체 게시글 수*/

	


}
