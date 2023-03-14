<%@page import="org.json.simple.JSONObject"%>
<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	String nickname=request.getParameter("nickname");
	MemberDao dao=new MemberDao();
	
	int count=dao.isNicknameCheck(nickname);
	
	JSONObject ob=new JSONObject();
	ob.put("count", count);
%>

<%=ob.toString()%>