package com.petmily.dao.boardDAO;

import java.util.ArrayList;
import java.util.HashMap;

import com.petmily.dto.BoardDTO;

public interface BoardInter {

	/////////////////////////////////////////////////// 윤영//////////////////////////////////////////////////

	ArrayList<BoardDTO> protectList(HashMap<String, String> map); /* 보호 게시판 리스트 */

	ArrayList<BoardDTO> missingList(HashMap<String, String> map); /* 실종 게시판 리스트 */

	BoardDTO protectDetail(int board_idx); /* 보호 게시판 상세보기 */

	BoardDTO missingDetail(int board_idx); /* 실종 게시판 상세보기 */

	int missingWrite(BoardDTO dto); /* 실종 게시글 작성 */

	void board_missingWrite(BoardDTO dto); /* 게시글 등록 성공 -> 실종 게시판 글 등록 */

	void missingWriteFile(String newFile, String oldFile, int board_idx, String main); /* 실종 게시글 파일 업로드 */

	ArrayList<BoardDTO> fileList(int board_idx); /* 첨부파일 리스트 */

	int protectWrite(BoardDTO dto); /* 보호 게시글 작성 */

	void board_protectWrite(BoardDTO dto); /* 게시글 등록 성공 -> 보호 게시판 글 등록 */

	void protectWriteFile(String key, String string, int board_idx, String main); /* 보호 게시글 파일 업로드 */

	String pDelFileName(String fileName);/* 보호_삭제 파일명 확인 */

	int pFileDelete(String fileName); /* 보호_DB에서 파일 삭제 */

	int protectDelete(int board_idx);/* 보호 게시글 삭제 */

	String mDelFileName(String fileName);/* 실종_삭제 파일명 확인 */

	int mFileDelete(String fileName);/* 실종_DB에서 파일 삭제 */

	int missingDelete(int board_idx); /* 실종 게시글 삭제 */

	int missingUpdate(String board_idx, String board_title, String board_content); /* 실종_게시글 수정 */

	void board_missingUpdate(String board_idx, String missing_loc, String animal_idx,
			String animal_type); /* 실종_게시글 수정-> 실종 게시글 수정 */

	int protectUpdate(String board_idx, String board_title, String board_content); /* 보호_게시글 수정 */

	void board_protectUpdate(String board_idx, String protect_loc, String animal_idx,
			String animal_type); /* 보호_게시글 수정-> 보호 게시글 수정 */

	int mgetAllCnt(HashMap<String, String> map); /* 실종_출력할 수 있는 전체 게시글 수 */

	int pGetAllCnt(HashMap<String, String> map); /* 보호_출력할 수 있는 전체 게시글 수 */

	String getPass(HashMap<String, String> params); /* 실종_비밀번호확인 */

	int favoriteChk(HashMap<String, Object> map); /* 즐겨찾기 체크 */

	int favoriteRegist(HashMap<String, String> map); /* 즐겨찾기 등록 */

	int favoriteDel(HashMap<String, String> map); /* 즐겨찾기 삭제 */

	
	
	/////////////////////////////////////////////////// 소현//////////////////////////////////////////////////
	
	int mylistallCount(HashMap<String, String> params);

	ArrayList<BoardDTO> getmyList(HashMap<String, String> params);

	int delMylist(int idx);

	String reason(int idx);

	int fundlistallCount(HashMap<String, String> params);

	ArrayList<BoardDTO> getfundList(HashMap<String, String> params);

	int writefund(BoardDTO board);

	int writebbs(BoardDTO board);

	void writeFile(String key, String string, int board_idx, String main);

	void writefund(int board_idx, String fund_centerName, String fund_area);

	BoardDTO funddetail(String idx);

	ArrayList<BoardDTO> fundfileList(String idx);

	BoardDTO fundupdateForm(int idx);

	int fundupdate(String subject, String content, String idx);

	int agreelistallCount(HashMap<String, String> params);

	ArrayList<BoardDTO> getagreeList(HashMap<String, String> params);

	int getagreeAdmin(int idx);

	int getnoreasonidx(int idx);

	int getnoreason(int idx, String reason);

	int likeallCount(HashMap<String, String> params);

	ArrayList<BoardDTO> getlikeList(HashMap<String, String> params);

	int delLikelist(int idx);

	int funddelete(int idx);

	void uphit(String idx);
	

	/////////////////////////////////////////////////// 보네//////////////////////////////////////////////////

	int communityWrite(BoardDTO boardDTO);// 보네 - (커뮤니티) 글 작성

	void cWriteFile(String key, String string, int board_idx);// 보네 - (커뮤니티) 파일 등록

	ArrayList<BoardDTO> cFileList(int board_idx); // 보네 - (커뮤니티) 파일 리스트

	int cFileDelete(String fileName);// 보네 - (커뮤니티) 파일 DB에서 삭제

	String cDelFileName(String fileName);// 보네 - (커뮤니티) 삭제 파일명 존재 확인

	ArrayList<BoardDTO> communityList(HashMap<String, String> map);// 보네 - (커뮤니티) 리스트

	void cUpHit(int board_idx);// 보네 - (커뮤니티) 조회수 증가

	BoardDTO communityDetail(int board_idx);// 보네 - (커뮤니티) 상세페이지

	String cDetailPhoto(int board_idx);// 보네 - (커뮤니티) 상세페이지 내 사진

	int communityDelete(int board_idx);// 보네 - (커뮤니티) 글 삭제

	BoardDTO communityUpdateForm(int board_idx);// 보네 - (커뮤니티) 글 수정 폼

	ArrayList<BoardDTO> cUpdateFormPhoto(int board_idx);// 보네 - (커뮤니티) 수정 폼 내 사진

	int communityUpdate(BoardDTO boardDTO);// 보네 - (커뮤니티) 글 수정
	

	/////////////////////////////////////////////////// 용진//////////////////////////////////////////////////

	/* 구조후기 */
	ArrayList<BoardDTO> saveList(HashMap<String, String> map); // 구조후기 글 리스트

	int saveWrite(BoardDTO dto); // 구조후기 글 작성

	int boardSaveWrite(BoardDTO dto); // board_save 테이블에 동물 종류, 품종, 지역 등록

	void savePhotoWrite(String key, String string, int board_idx); // 구조후기 사진(파일) 등록

	void sUpHit(String board_idx); // 구조후기 글 조회수 증가

	BoardDTO saveDetail(int board_idx); // 구조후기 후기 글 상세보기

	BoardDTO boardSaveDetail(int board_idx); // 구조후기 셀렉트 테이블 값 상세보기

	String sDetailPhoto(int board_idx); // 구조후기 상세보기 내부 사진(파일)

	BoardDTO saveUpdateForm(int board_idx); // 구조후기 글 수정 폼

	int saveUpdate(BoardDTO dto); // 구조후기 글 수정

	int boardSaveUpdate(BoardDTO dto); // board_save 테이블 내용 수정

	int saveDelete(int board_idx); // 구조후기 글 삭제

	int savePhotoDelete(String fileName); // 구조후기 사진 파일 삭제

	String saveDelFileName(String fileName); // 삭제 파일명 존재 확인
	/* 구조후기 */

	/* 입양후기 */
	ArrayList<BoardDTO> adoptList(HashMap<String, String> map); // 입양후기 글 리스트

	int adoptWrite(BoardDTO dto); // 입양후기 글 작성

	int boardAdoptWrite(BoardDTO dto); // board_adopt 테이블에 동물 종류, 품종, 지역 등록

	void adoptPhotoWrite(String key, String string, int board_idx); // 입양후기 사진(파일) 등록

	void aUpHit(String board_idx); // 입양 후기 글 조회수 증가

	BoardDTO adoptDetail(int board_idx); // 입양 후기 글 상세보기

	BoardDTO boardAdoptDetail(int board_idx); // 입양 후기 셀렉트 테이블 값 상세보기

	String aDetailPhoto(int board_idx); // 입양후기 상세보기 내부 사진(파일)

	BoardDTO adoptUpdateForm(int board_idx); // 입양후기 글 수정 폼

	int adoptUpdate(BoardDTO dto); // 입양후기 글 수정

	int boardAdoptUpdate(BoardDTO dto); // board_adopt 테이블 내용 수정

	int adoptDelete(int board_idx); // 입양후기 글 삭제

	int adoptPhotoDelete(String fileName); // 입양후기 사진 파일 삭제

	String adoptDelFileName(String fileName); // 삭제 파일명 존재 확인
	/* 입양후기 */
}
