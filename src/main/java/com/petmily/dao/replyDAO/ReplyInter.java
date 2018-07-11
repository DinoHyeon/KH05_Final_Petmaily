package com.petmily.dao.replyDAO;

import java.util.ArrayList;
import java.util.HashMap;

import com.petmily.dto.ReplyDTO;

public interface ReplyInter {

	int regist(ReplyDTO dto);

	ArrayList<ReplyDTO> replyListCall(int idx);

	int replyDel(int replyIdx);

	String getReplyPass(int replyIdx);

	int replyModi(HashMap<String, String> params);

}
