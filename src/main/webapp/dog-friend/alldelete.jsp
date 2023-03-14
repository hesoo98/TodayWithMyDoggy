<%@page import="board.dogFriend.DogFriendBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//nums 읽기
	String nums=request.getParameter("nums");

	//,로 분리해서 [] - split
	String [] num=nums.split(",");
	
	//배열의 갯수만큼 delete
	DogFriendBoardDao dao=new DogFriendBoardDao();

	for(String n:num){
		dao.deleteBoard(n);
	}
	//목록
	response.sendRedirect("../index.jsp?main=dog-friend/board.jsp");
%>