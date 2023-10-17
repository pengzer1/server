package com.test.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;  //1. 서블릿 클래스 선언
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;  

public class Hi extends HttpServlet{
   public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException{  //2.
      //3.
      resp.setCharacterEncoding("UTF-8");  //한글 깨지지 않게.
      PrintWriter writer=resp.getWriter();
      
      //4.
      Calendar now = Calendar.getInstance();
      
      writer.println("<!DOCTYPE html>"
            + "<html>"
            + "<head>"
            + "<meta charset=\"UTF-8\">"
            + "<title>Insert title here</title>"
            + "</head>"
            + "<body>"
            + "   <h1>Hello</h1>"
            + "   <p>안녕하세요.</p>"
            + " <p id=\"time\">"
            + String.format("%tT", now) 
            +"</p>"
            + "   "
            + "</body>"
            + "</html>");
      
      writer.close();  //5.
   }
   

}