<%@page import="board.qna.QnaBoardDao"%>
<%@page import="board.qna.QnaBoardDto"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<%
request.setCharacterEncoding("utf-8");

String num=request.getParameter("num");

QnaBoardDto dto=new QnaBoardDto();

dto.setNum(num);
dto.setTitle(request.getParameter("title"));
dto.setContent(request.getParameter("content"));
dto.setSecret(request.getParameter("secret"));

QnaBoardDao dao=new QnaBoardDao();
dao.updateBoard(dto);

response.sendRedirect("../index.jsp?main=qna/detail.jsp?num="+num);


%>