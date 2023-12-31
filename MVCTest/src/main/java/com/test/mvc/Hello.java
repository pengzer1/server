package com.test.mvc;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Hello extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 서블릿 호출
		// 업무 처리
		
		// HTML 페이지 생산 > 불편;; > JSP 위임
//		resp.sendRedirect("/mvc/hello.jsp");
		
		// DB 작업 > select count(*)
		int count = 100;
		
		// 서블릿 > 자신의 업무 완료 > 산출물 일부 > 출력 > JSP 페이지로 전달
		req.setAttribute("count", count);
		
		// resp.sendRedirect("/mvc/hello.jsp");
		// pageContext.forward("/mvc/hello.jsp"); > pageContext 예약어가 없음
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/hello.jsp");
		dispatcher.forward(req, resp); // pageContext.forward()
		
	}
	
}
