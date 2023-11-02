package com.test.toy.board;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.test.toy.board.model.BoardDTO;
import com.test.toy.board.repository.BoardDAO;

@WebServlet("/board/list.do")
public class List extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// List.java
		
		// A. list.do 호출
		// B. list.do?column=subject&word=검색어 > 호출(검색하기)
		
		String column = req.getParameter("column");
		String word = req.getParameter("word");
		String search = "n"; // 검색중("y"), 목록보기("n")
		
		if ((column == null && word == null) || (column.equals("") && word.equals(""))) {
			search = "n";
		} else {
			search = "y";
		}
		
		HashMap<String, String> map = new HashMap<String, String>();
		
		map.put("column", column);
		map.put("word", word);
		map.put("search", search);
		
		// 1. DB 작업 > select
		// 2. 반환 > JSP 호출하기
		
		HttpSession session = req.getSession();
		// 조회수 티켓
		session.setAttribute("read", "n");
		
		// 1.
		BoardDAO dao = new BoardDAO();
		
		ArrayList<BoardDTO> list = dao.list(map);
		
		// 1.5 데이터 조작
		for (BoardDTO dto : list) {
			String subject = dto.getSubject();
			// 제목 길이 자르기
			if (subject.length() > 20) {
				subject = subject.substring(0, 20) + "...";
			}
			// 태그 비활성화
			// - <div> -> &lt;div&gt;
			subject = subject.replace("<", "&lt;");
			subject = subject.replace(">", "&gt;");
			
			dto.setSubject(subject);
		}
		
		// 2.
		req.setAttribute("list", list);
		req.setAttribute("map", map);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/board/list.jsp");
		dispatcher.forward(req, resp);
	}

}