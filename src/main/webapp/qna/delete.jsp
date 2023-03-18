<%@page import="board.qna.QnaBoardDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

    <%
    
    String num=request.getParameter("num");
    
    QnaBoardDao dao=new QnaBoardDao();
    dao.deleteBoard(num);
    
    response.sendRedirect("../index.jsp?main=qna/qnalist.jsp");
    
    %>