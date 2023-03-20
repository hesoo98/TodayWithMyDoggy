<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="answer.dogTalking.DogTalkingAnswerDto"%>
<%@page import="board.dogTalking.DogTalkingBoardDto"%>
<%@page import="java.util.List"%>
<%@page import="answer.dogTalking.DogTalkingAnswerDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String boardnum = request.getParameter("boardnum");
	DogTalkingAnswerDao dao = new DogTalkingAnswerDao();
	List<DogTalkingAnswerDto> list = dao.showAnswers(boardnum);
	
	JSONArray arr = new JSONArray();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년-MM월-dd일 HH시:mm분");
	
	for(DogTalkingAnswerDto dto : list) {
		JSONObject ob = new JSONObject();
		ob.put("idx", dto.getIdx());
		ob.put("boardnum", dto.getBoardnum());
		ob.put("id", dto.getId());
		ob.put("content", dto.getContent());
		ob.put("writeday", sdf.format(dto.getWriteday()));
		arr.add(ob);
	}
%>
<%=arr.toString()%>