<%@page import="member.MemberDao"%>
<%@page import="answer.dogTalking.DogTalkingAnswerDto"%>
<%@page import="answer.dogTalking.DogTalkingAnswerDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

    <%
    
    request.setCharacterEncoding("utf-8");
    
    String num=request.getParameter("num");
    String answer=request.getParameter("answer");
    String currentPage=request.getParameter("currentPage");
    
    
    //nickname
    MemberDao mdao=new MemberDao();
    String id=(String)session.getAttribute("myid");
    
    DogTalkingAnswerDto dto=new DogTalkingAnswerDto();
    
    dto.setBoardnum(num);
    dto.setContent(answer);
    dto.setId(id);
    
    DogTalkingAnswerDao dao=new DogTalkingAnswerDao();
    dao.insertAnswer(dto);
    
    response.sendRedirect("../index.jsp?main=dog-talking/detail.jsp?num="+num+"&currentPage="+currentPage);
    
    %>