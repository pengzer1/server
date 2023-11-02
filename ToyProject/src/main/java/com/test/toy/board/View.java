package com.test.toy.board;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.test.toy.board.model.BoardDTO;
import com.test.toy.board.repository.BoardDAO;

@WebServlet("/board/view.do")
public class View extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// View.java
		HttpSession session = req.getSession();
		
		// 1.
		String seq = req.getParameter("seq");
		
		String search = req.getParameter("search");
		String column = req.getParameter("column");
		String word = req.getParameter("word");
		
		// 2.
		BoardDAO dao = new BoardDAO();
		
		// 2.3 조회수 증가
		if (session.getAttribute("read") != null && session.getAttribute("read").toString().equals("n")) {
			dao.updateReadcount(seq);
			
			session.setAttribute("read", "y");
		}
		
		BoardDTO dto = dao.get(seq);
		
		// 2.5 데이터 조작
		
		// 태그 비활성화
		// - <div> -> &lt;div&gt;
		String subject = dto.getSubject();
		subject = subject.replace("<", "&lt;");
		subject = subject.replace(">", "&gt;");
		
		String content = dto.getContent();
		content = content.replace("<", "&lt;");
		content = content.replace(">", "&gt;");
		// 개행 문자 처리
		content = content.replace("\r\n", "<br>");
		
		dto.setSubject(subject);
		dto.setContent(content);
		
		// 내용으로 검색 > 검색어 강조!!
		if (search.equals("y") && column.equals("content")) {
			
			// 하위
			// <span style="background-color: yellow; color:tomato;">하위</span>
			dto.setContent(dto.getContent().replace(word, "<span style='background-color: yellow; color:tomato;'>" + word + "</span>"));
			
		}
		
		// 3.
		req.setAttribute("dto", dto);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/board/view.jsp");
		dispatcher.forward(req, resp);
	}

}