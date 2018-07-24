package com.petmily.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AdminChk extends HandlerInterceptorAdapter{

	@Override
	   public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
	         throws Exception {
	      System.out.println("controller 요청 전에 실행 -- preHandle()");
	      System.out.println("상태 세션 검사");
	      RequestDispatcher rd = request.getRequestDispatcher("");
	      HttpSession session = request.getSession();
	      String id = (String) session.getAttribute("loginId");
	      String state = (String) session.getAttribute("state");
	      
	      boolean pass = false;
	      
	      if(id==null||state!="admin") {
	         request.setAttribute("msg", "관리자 페이지입니다.");
	         rd.forward(request, response);
	      }else if(id!=null&&state=="admin"){
	         pass = true;
	      }
	      return pass;
	   }


	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		super.postHandle(request, response, handler, modelAndView);
	}

	
}
