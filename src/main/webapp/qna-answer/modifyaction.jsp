<%@page import="answer.qna.QnaAnswerDto"%>
<%@page import="answer.qna.QnaAnswerDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

    <%
    request.setCharacterEncoding("utf-8");
    
    String idx=request.getParameter("idx");
    String num=request.getParameter("num");
    String adminId=(String)session.getAttribute("myid");
    
    QnaAnswerDto dto=new QnaAnswerDto();
    dto.setIdx(idx);
    dto.setAdminId(adminId);
    dto.setBoardNum(num);
    dto.setContent(request.getParameter("content"));
    
    QnaAnswerDao dao=new QnaAnswerDao();
    dao.updateAnswer(dto);
    
    response.sendRedirect("../index.jsp?main=qna/detail.jsp?num="+num);
    %>