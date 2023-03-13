<%@page import="board.dogFriend.DogFriendBoardDao"%>
<%@page import="board.dogFriend.DogFriendBoardDto"%>
<%@page import="member.MemberDto"%>
<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	DogFriendBoardDto dto=new DogFriendBoardDto();
	String nickname=request.getParameter("nickname");
	String subject=request.getParameter("subject");
	String content=request.getParameter("content");
	
	//dto에 저장
	dto.setNickname(nickname);
	dto.setSubject(subject);
	dto.setContent(content);
	
	//dao선언
	DogFriendBoardDao dao=new DogFriendBoardDao();
	dao.insertDogFriend(dto);
	
	//방금 추가된 num값 얻기
	int num=dao.getMaxNum();
	
	//이동
	response.sendRedirect("../index.jsp?main=dog-friend/board.jsp");

%>