<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="message.MessageDto"%>
<%@page import="message.MessageDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String num=request.getParameter("num");
	MessageDao dao=new MessageDao();
	MessageDto dto=dao.showMessageDetail(num);
	
	SimpleDateFormat sdf=new SimpleDateFormat("전송일: yyyy-MM-dd HH:mm");
	
	//num sender receiver content writeday is_read
	JSONObject ob=new JSONObject();
	ob.put("num", dto.getNum());
	ob.put("sender", dto.getSender());
	ob.put("receiver",dto.getReceiver());
	ob.put("content", dto.getContent());
	//ob.put("writeday",sdf.format(dto.getWriteday()));
	ob.put("isRead",dto.getIsRead());

%>
<%=ob.toString()%>