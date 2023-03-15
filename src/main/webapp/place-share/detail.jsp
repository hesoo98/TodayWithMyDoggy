<%@page import="board.placeShare.PlaceShareBoardDao"%>
<%@page import="board.placeShare.PlaceShareBoardDto"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style type="text/css">
	.container {
		width: 1200px;
	}
</style>
</head>
<%
	String num = request.getParameter("num");
	PlaceShareBoardDao dao = new PlaceShareBoardDao();	
	PlaceShareBoardDto dto = dao.getData(num);
%>
<body>
	<div class="container">
	<img class="top-img" src="">
	<br>
	<div>
		<img src="/TodayWithMyDoggy/place-share/place-photo/<%=dto.getPhotoName()%>" id="title-img">
	</div>
	</div>
	</body>
</html>