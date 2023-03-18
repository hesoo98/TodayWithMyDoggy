<%@page import="answer.qna.QnaAnswerDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

    <%
    String idx=request.getParameter("idx");
    
    QnaAnswerDao dao=new QnaAnswerDao();
    dao.deleteAnswer(idx);
    
    response.sendRedirect("../index.jsp?main=qna/qnalist.jsp");
    %>