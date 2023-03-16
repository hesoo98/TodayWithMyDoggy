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
	border: 1px solid blue;
	padding-bottom: 100px;
}

#title-img {
	width: 40%;
	height: 30%;
	border-radius: 5%;
}

.answer-input {
	width: 350px;
	height: 40px;
}

.answer-list {
	border: 1px solid blue;
	width: 500px;
}

input {
	margin: 0;
}

input[type="text"] {
	width: 140%;
	height: 100%;
	border: none;
	font-size: 1em;
	padding-left: 5px;
	font-style: oblique;
	display: inline;
	outline: none;
	box-sizing: border-box;
	color: black;
}

input[type="button"] {
	width: 20%;
	height: 80%;
	background-color: lightgray;
	border: none;
	background-color: white;
	font-size: 1em;
	color: #042AaC;
	outline: none;
	display: inline;
	margin-left: -80px;
	box-sizing: border-box;
}

input[type="button"]:hover {
	background-color: buttonshadow;
}

#subject {
	font-size: 20px;
	font-weight: bold;
}

div {
	font-size: 10pt
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
		<div id="subject">
			<%=dto.getSubject()%>
		</div>
		<hr>
		<img
			src="/TodayWithMyDoggy/place-share/place-photo/<%=dto.getPhotoName()%>"
			id="title-img">
		<hr>
		유저 사진 & 닉네임 쓸 곳
		<hr>
		<hr>
		<div>
			내용 :
			<%=dto.getContent()%>
		</div>
		<br>
		<!-- 댓글 -->
		<form action="place-share/addAnswer.jsp" method="post">
			<%=dto.getWriteday()%>&nbsp;&nbsp;신고하기<br> <br>

			<div class="answer-input">
				<input type="text" name="answer" value=""
					class="form-control answer" placeholder="댓글을 입력해주세요"> <input
					type="button" value="전송" class="btn-answer">
			</div>
			<br>
			<br>
			<div class="answer-list">
				댓글쓴 사람<br>댓글 생성 날짜시간<br> 댓글 내용<br> 답글/수정/삭제
			</div>
		</form>
	</div>
</body>
</html>