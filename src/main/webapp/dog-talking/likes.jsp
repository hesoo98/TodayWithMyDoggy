<%@page import="org.json.simple.JSONObject"%>
<%@page import="board.dogTalking.DogTalkingBoardDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

    
    <%
    
 	String num=request.getParameter("num");
    
    //dao
    DogTalkingBoardDao dao=new DogTalkingBoardDao();
    dao.updateLikes(num);
    
    //num에 해당하는 chu를 json 형식으로 반환
    int likes=dao.getData(num).getLikes();
    
    JSONObject ob=new JSONObject();
    ob.put("likes",likes);
    
    %><%=ob.toString()%>