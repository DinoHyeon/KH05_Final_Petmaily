package com.petmily.dao.memberDAO;

import com.petmily.dto.MemberDTO;

public interface MemberInter {

	String loginConfirmPage(String id, String pw);
	
	int joinConfirmPage(MemberDTO dto);

	String idChkPage(String id);

	String idSearchPage(String name, String email, String phone);
}
