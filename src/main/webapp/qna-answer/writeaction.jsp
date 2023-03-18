<%@page import="answer.qna.QnaAnswerDto"%>
<%@page import="answer.qna.QnaAnswerDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

    <%
    request.setCharacterEncoding("utf-8");
    
    String adminId=(String)session.getAttribute("myid");
    String boardNum=request.getParameter("num");
    String content=request.getParameter("content");
    
    QnaAnswerDto dto=new QnaAnswerDto();
    dto.setAdminId(adminId);
    dto.setBoardNum(boardNum);
    dto.setContent(content);
    
    QnaAnswerDao dao=new QnaAnswerDao();
    dao.insertAnswer(dto);
    
    response.sendRedirect("../index.jsp?main=qna/qnalist.jsp");
    
    %>