package com.petmily.dto;

import java.sql.Date;

public class ReplyDTO {
	private int reply_idx;
	private int board_idx;
	private String reply_content;
	private String reply_writer;
	private Date reply_regDate;
	private String reply_pw;
	
	public int getReply_idx() {
		return reply_idx;
	}
	public void setReply_idx(int reply_idx) {
		this.reply_idx = reply_idx;
	}
	public int getBoard_idx() {
		return board_idx;
	}
	public void setBoard_idx(int board_idx) {
		this.board_idx = board_idx;
	}
	public String getReply_content() {
		return reply_content;
	}
	public void setReply_content(String reply_content) {
		this.reply_content = reply_content;
	}
	public String getReply_writer() {
		return reply_writer;
	}
	public void setReply_writer(String reply_writer) {
		this.reply_writer = reply_writer;
	}
	public Date getReply_regDate() {
		return reply_regDate;
	}
	public void setReply_regDate(Date reply_regDate) {
		this.reply_regDate = reply_regDate;
	}
	public String getReply_pw() {
		return reply_pw;
	}
	public void setReply_pw(String reply_pw) {
		this.reply_pw = reply_pw;
	}
	
	
}
