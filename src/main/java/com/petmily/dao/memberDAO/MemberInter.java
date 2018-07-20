package com.petmily.dao.memberDAO;

import java.util.ArrayList;
import java.util.HashMap;

import com.petmily.dto.MemberDTO;

public interface MemberInter {

	String loginConfirmPage(String id, String pw);
	
	int joinConfirmPage(MemberDTO dto);

	String idChkPage(String id);

	String idSearchPage(String name, String email, String phone);
	
	
	///////////////////////////소현////////////////////////////
	
	int memberallCount(HashMap<String, String> params);

	ArrayList<MemberDTO> getmemberList(HashMap<String, String> params);

	int getchangeState(String idx);
}
