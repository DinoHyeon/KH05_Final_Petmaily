package com.petmily.dao.boardDAO;

import java.util.ArrayList;
import java.util.HashMap;

import com.petmily.dto.BoardDTO;

public interface BoardInter {

	ArrayList<BoardDTO> protectList(HashMap<String, Object> map); /* 보호 게시판 리스트 */

	ArrayList<BoardDTO> missingList(HashMap<String, Object> map); /* 실종 게시판 리스트 */

	BoardDTO protectDetail(int board_idx); /* 보호 게시판 상세보기 */

	BoardDTO missingDetail(int board_idx); /* 실종 게시판 상세보기 */

	int missingWrite(BoardDTO dto); /* 실종 게시글 작성 */

	void missingWriteFile(String newFile, String oldFile, int board_idx); /* 실종 게시글 파일 업로드 */

}
