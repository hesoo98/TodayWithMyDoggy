<%@page import="member.MemberDao"%>
<%@page import="board.dogTalking.DogTalkingAnswerDto"%>
<%@page import="board.dogTalking.DogTalkingAnswerDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

    <%
    
    request.setCharacterEncoding("utf-8");
    
    String num=request.getParameter("num");
    String answer=request.getParameter("answer");
    
    //nickname
    MemberDao mdao=new MemberDao();
    String id=(String)session.getAttribute("myid");
    String nickname=mdao.getNickname(id);
    
    DogTalkingAnswerDto dto=new DogTalkingAnswerDto();
    
    dto.setBoardnum(num);
    dto.setContent(answer);
    dto.setNickname(nickname);
    
    DogTalkingAnswerDao dao=new DogTalkingAnswerDao();
    dao.insertAnswer(dto);
    
    response.sendRedirect("../index.jsp?main=dog-talking/detail.jsp?num="+num);
    
    %>