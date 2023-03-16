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
	width: 1000px;
	border: 1px solid blue;
	padding-bottom: 100px;
}

#title-img {
	width: 40%;
	height: 30%;
}

input.input {
	width: 800px;
}
</style>
</head>
<%
String num = request.getParameter("num");
PlaceShareBoardDao dao = new PlaceShareBoardDao();
PlaceShareBoardDto dto = dao.getData(num);
%>
<body>
	<div class="container" role="main">
			<img
				src="/TodayWithMyDoggy/place-share/place-photo/<%=dto.getPhotoName()%>"
				id="title-img">
			<hr>
			유저 사진 & 닉네임 쓸 곳
			<hr>
			<div>
				제목 :
				<%=dto.getSubject()%>
			</div>
			<hr>
			<div>
				내용 :
				<%=dto.getContent()%>
			</div>
			<br> <br>
			<!-- 댓글 -->
			<form action="place-share/addAnswer.jsp" method="post">
				<%=dto.getWriteday() %>&nbsp;&nbsp;신고하기<br><br>
				<input type="text" name="answerContent" class="form-control input" placeholder="댓글을 입력해주세요">
			</form>
	</div>
</body>
</html>