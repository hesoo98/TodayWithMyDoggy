<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="answer.placeShare.PlaceShareAnswerDto"%>
<%@page import="java.util.List"%>
<%@page import="answer.placeShare.PlaceShareAnswerDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String boardnum = request.getParameter("boardnum");
	PlaceShareAnswerDao dao = new PlaceShareAnswerDao();
	List<PlaceShareAnswerDto> list = dao.getAllAnswers(boardnum);
	
	JSONArray arr = new JSONArray();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년-MM월-dd일 HH시:mm분");
	
	for(PlaceShareAnswerDto dto : list) {
		JSONObject ob = new JSONObject();
		ob.put("idx", dto.getIdx());
		ob.put("boardnum", dto.getBoardNum());
		ob.put("id", dto.getId());
		ob.put("content", dto.getContent());
		ob.put("writeday", sdf.format(dto.getWriteday()));
		arr.add(ob);
	}
%>
<%=arr.toString()%>