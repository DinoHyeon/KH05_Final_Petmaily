package com.petmily.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.petmily.dao.replyDAO.ReplyInter;
import com.petmily.dto.ReplyDTO;

@Service
public class ReplyService {
	@Autowired SqlSession sqlSession;
	ReplyInter inter;
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	public int regist(HashMap<String, String> params, HttpSession session, String ipAddr) {
		inter = sqlSession.getMapper(ReplyInter.class);
		ReplyDTO dto = new ReplyDTO();
		
		dto.setBoard_idx(Integer.parseInt(params.get("idx")));
		if(session.getAttribute("loginId")==null) {
			dto.setReply_writer("비회원 "+ipAddr);
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
			dto.setReply_pw(encoder.encode(params.get("pass")));
		}else {
			dto.setReply_pw("회원");
			dto.setReply_writer((String) session.getAttribute("loginId"));
		}
		dto.setReply_content(params.get("content"));
		
		return inter.regist(dto);
	}

	public HashMap<String, Object> replyListCall(HashMap<String, String> params) {
		inter = sqlSession.getMapper(ReplyInter.class);
		
		int allCnt = inter.getAllCnt(Integer.parseInt(params.get("idx")));
		int pageCnt = allCnt % 15 > 0 ? Math.round(allCnt/15)+1 : allCnt/15;
		HashMap<String, Object> replyList = new HashMap<String,Object>();
		
		int page = Integer.parseInt(params.get("showPageNum"));
		
		if(page>pageCnt) {
			page=pageCnt;
		}
		
		int end = 15*page;
		int start = end-15+1;
		
		params.put("start", String.valueOf(start));
		params.put("end", String.valueOf(end));
		
		replyList.put("list", inter.getReplyList(params));
		replyList.put("range", pageCnt);
		replyList.put("currPage", page);
		
		return replyList;
	}

	public int replyDel(int replyIdx) {
		inter = sqlSession.getMapper(ReplyInter.class);
		return inter.replyDel(replyIdx);
	}

	public boolean replyPassChk(int replyIdx, String pass) {
		inter = sqlSession.getMapper(ReplyInter.class);
		String replyPass = inter.getReplyPass(replyIdx);

		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		
		return encoder.matches(pass, replyPass);
	}

	public int replyModi(HashMap<String, String> params) {
		inter = sqlSession.getMapper(ReplyInter.class);
		return inter.replyModi(params);
	}

	
	
}
