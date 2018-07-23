package com.petmily.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginChk extends HandlerInterceptorAdapter{

	@Override
	   public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
	         throws Exception {
	      System.out.println("controller 요청 전에 실행 -- preHandle()");
	      System.out.println("세션 검사");
	      RequestDispatcher rd = request.getRequestDispatcher("loginPage");
	      HttpSession session = request.getSession();
	      String id = (String) session.getAttribute("loginId");
	      boolean pass = false;
	      if(id==null) {
	         System.out.println("로그인 안됨");
	         request.setAttribute("msg", "로그인이 필요한 서비스입니다");
	         rd.forward(request, response);
	      }else {
	         System.out.println("로그인 됨");
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
