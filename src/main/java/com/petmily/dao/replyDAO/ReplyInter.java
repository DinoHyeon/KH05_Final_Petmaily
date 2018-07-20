package com.petmily.dao.replyDAO;

import java.util.ArrayList;
import java.util.HashMap;

import com.petmily.dto.ReplyDTO;

public interface ReplyInter {

	int regist(ReplyDTO dto);

	int replyDel(int replyIdx);

	String getReplyPass(int replyIdx);

	int replyModi(HashMap<String, String> params);

	int getAllCnt(int idx);

	ArrayList<ReplyDTO> getReplyList(HashMap<String, String> params);

}
