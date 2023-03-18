<%@page import="board.qna.QnaBoardDto"%>
<%@page import="board.qna.QnaBoardDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

    <%
    request.setCharacterEncoding("utf-8");
    
    String id=(String)session.getAttribute("myid");
    String title=request.getParameter("title");
    String content=request.getParameter("content");
    String secret=request.getParameter("secret");
    
    QnaBoardDto dto=new QnaBoardDto();
    dto.setId(id);
    dto.setTitle(title);
    dto.setContent(content);
    dto.setSecret(secret);
    
    QnaBoardDao dao=new QnaBoardDao();
    dao.insertQna(dto);
    
    response.sendRedirect("../index.jsp?main=qna/qnalist.jsp");
    
    %>