<%@page import="board.dogTalking.DogTalkingBoardDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

    
    <%
    
    String num=request.getParameter("num");
    String currentPage=request.getParameter("currentPage");
    
    DogTalkingBoardDao dao=new DogTalkingBoardDao();
    dao.deleteBoard(num);
    
    response.sendRedirect("../index.jsp?main=dog-talking/board.jsp?currentPage="+currentPage);
    %>