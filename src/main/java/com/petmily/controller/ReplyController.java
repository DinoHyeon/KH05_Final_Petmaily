package com.petmily.controller;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.petmily.dto.ReplyDTO;
import com.petmily.service.ReplyService;

@Controller
public class ReplyController {
	
	@Autowired ReplyService service;
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());


	@RequestMapping(value = "reply")
	public String reply (HttpSession session) {
		session.removeAttribute("loginId");
		
		//session.setAttribute("loginId", "test01");
		System.out.println("ssss :"+session.getAttribute("loginId"));
		return "reply";
	}
	
	@RequestMapping(value = "replyListCall")
	public @ResponseBody HashMap<String, Object> ReplyListCall (@RequestParam HashMap<String, String> params) {
		return service.replyListCall(params);
	}
	
	@RequestMapping(value = "replyRegist")
	public @ResponseBody int reply (@RequestParam HashMap<String, String> params, HttpSession session) {
		String ipAddr = null;
		try {
			InetAddress ip = InetAddress.getLocalHost();
			ipAddr = ip.getHostAddress();
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}
		return service.regist(params,session,ipAddr);
	}
	
	@RequestMapping(value = "replyDel")
	public @ResponseBody int replyDel (@RequestParam ("replyIdx") int replyIdx) {
		return service.replyDel(replyIdx);
	}
	
	@RequestMapping(value = "replyModi")
	public @ResponseBody int replyModi (@RequestParam HashMap<String, String> params) {
		return service.replyModi(params);
	}
	
	@RequestMapping(value = "replyPassChk")
	public @ResponseBody boolean replyPassChk (@RequestParam ("idx") int replyIdx, @RequestParam ("pass") String pass){
		System.out.println(replyIdx);
		System.out.println(pass);
		
		return service.replyPassChk(replyIdx,pass);
	}
	
}