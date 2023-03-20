<%@page import="board.dogTalking.DogTalkingBoardDto"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<title>Insert title here</title>

<style type="text/css">
.answer-input {
	width: 350px;
	height: 40px;
}


input {
	margin: 0;
}

input[type="text"] {
	width: 140%;
	height: 100%;
	border-radius: 17px;
	font-size: 1em;
	padding-left: 5px;
	font-style: oblique;
	display: inline;
	outline: none;
	box-sizing: border-box;
	color: black;
}

input[type="submit"] {
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

input[type="submit"]:hover {
	background-color: "";
}

</style>

</head>
<body>
<%
DogTalkingBoardDto dto=new DogTalkingBoardDto();
String num=request.getParameter("num");
%>
<div style="display: inline-flex ; margin: 20px 0px;">
	<form method="post" action="dog-talking/answeraction.jsp" >
		<div class="answer-input" style="float: left;">
		<input type="hidden" value="<%=num %>" name="num">
		<input type="text"  name="answer"
			class="form-control answer" placeholder="댓글을 입력해주세요"
			style="float: left; width: 500px; padding: 0 20px;"> 
		<input type="submit" id="btnanswer" value="전송" class="btn-answer"
		style="float: left; margin-top: 5px;">
		</div>
	</form>
</div>
<br><br>
</body>
</html>