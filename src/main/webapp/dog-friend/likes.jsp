<%@page import="org.json.simple.JSONObject"%>
<%@page import="board.dogFriend.DogFriendBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//num
	String num=request.getParameter("num");
	
	//dao선언
	DogFriendBoardDao dao=new DogFriendBoardDao();
	
	//num에 해당하는 likes 1층가
	dao.updateLikes(num);
	
	//num에 해당하는 chu값 json형식으로 반환
	int likes=dao.getData(num).getLikes();
	
	JSONObject ob=new JSONObject();
	ob.put("likes",likes);
	
%>

<%=ob.toString()%>