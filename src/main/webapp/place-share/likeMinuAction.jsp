<%@page import="org.json.simple.JSONObject"%>
<%@page import="board.placeShare.PlaceShareBoardDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
String boardnum = request.getParameter("boardnum");
PlaceShareBoardDao dao = new PlaceShareBoardDao();

dao.minuLikeCnt(boardnum);
//num에 해당하는 chu값 json 형식으로 반환 
int likes = dao.getData(boardnum).getLikes();

JSONObject ob = new JSONObject();
ob.put("likes", likes);
%>
<%=ob.toString()%>