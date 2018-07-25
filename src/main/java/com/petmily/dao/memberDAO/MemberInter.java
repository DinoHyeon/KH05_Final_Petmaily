package com.petmily.dao.memberDAO;

import java.util.ArrayList;
import java.util.HashMap;

import com.petmily.dto.MemberDTO;

public interface MemberInter {

   MemberDTO loginConfirmPage(String id); //로그인 체크
   
   int joinConfirmPage(MemberDTO dto); //회원가입 요청 

   String idChkPage(String id); //아이디 중복확인 요청

   String idSearchPage(String name, String email, String phone); //아이디 찾기 요청

   String pwSearchPage(String id, String email); //비밀번호 찾기 요청

   int changePwPage(String id, String pw); //비밀번호 변경

   String memberUpdateConfirm(String loginId, String userPw); //회원정보 수정을 위한 비밀번호 확인 요청

   ArrayList<MemberDTO> memberUpdateForm(String loginId); //회원 정보 수정 페이지

   int memberUpdatePage(MemberDTO dto); //회원 정보 수정 요청

   int deleteUpdatePage(String loginId); //회원 탈퇴 요청

   String protectPwChk(String id); //비밀번호 암호화

   ArrayList<String> deleteConfirm(String state);//회원 탈퇴 확인

   void deleteFinish(String state);
   
   String ChkPwEmail(String id, String email);

	
	//////////////////////////////////////////////////소현//////////////////////////////////////////////////
	
	int memberallCount(HashMap<String, String> params);

	ArrayList<MemberDTO> getmemberList(HashMap<String, String> params);

	int getchangeState(String idx);

	
}
