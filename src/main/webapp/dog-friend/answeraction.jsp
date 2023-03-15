<%@page import="answer.dogFriend.DogFriendAnswerDao"%>
<%@page import="answer.dogFriend.DogFriendAnswerDto"%>
<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    
    request.setCharacterEncoding("utf-8");
    
    String num=request.getParameter("num");
    String answer=request.getParameter("answer");
    
    //nickname
    MemberDao mdao=new MemberDao();
    String id=(String)session.getAttribute("myid");
    String nickname=mdao.getNickname(id);
    
    DogFriendAnswerDto dto=new DogFriendAnswerDto();
    
    dto.setBoardNum(num);
    dto.setContent(answer);
    dto.setNickname(nickname);
    
    DogFriendAnswerDao dao=new DogFriendAnswerDao();
    dao.insertAnswer(dto);
    
    response.sendRedirect("../index.jsp?main=dog-friend/detail.jsp?num="+num);
    
    %>