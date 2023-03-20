<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="message.MessageDto"%>
<%@page import="message.MessageDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String num=request.getParameter("num");
	String id=(String)session.getAttribute("myid");

	MessageDao dao=new MessageDao();
	MessageDto dto=dao.showMessageDetail(num);
	dao.updateRead(num);
	
	SimpleDateFormat sdf=new SimpleDateFormat("전송일: yyyy-MM-dd HH:mm");
	
	JSONObject ob=new JSONObject();
	ob.put("cnt", dao.getUnreadCount(id));
	ob.put("num", dto.getNum());
	ob.put("sender", dto.getSender());
	ob.put("receiver",dto.getReceiver());
	ob.put("content", dto.getContent());
	ob.put("writeday",sdf.format(dto.getWriteday()));
	ob.put("isRead",dto.getIsRead());

%>
<%=ob.toString()%>