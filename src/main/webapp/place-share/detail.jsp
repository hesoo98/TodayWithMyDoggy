<%@page import="member.MemberDto"%>
<%@page import="member.MemberDao"%>
<%@page import="profile.dogProfile.DogProfileDto"%>
<%@page import="profile.dogProfile.DogProfileDao"%>
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
	width: 800px;
	padding-bottom: 130px;
	padding-top: 70px;
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

#dogimg {
	width: 100%
}
</style>
</head>
<%
//로그인한 사람 아이디
String myid = (String)session.getAttribute("myid");

MemberDao mdao = new MemberDao();
String nickname = mdao.getNickname(myid);

String boardnum = request.getParameter("num");

PlaceShareBoardDao dao = new PlaceShareBoardDao();
PlaceShareBoardDto dto = dao.getData(boardnum);
String boardId = dto.getId();

MemberDao memberdao = new MemberDao();
MemberDto memberdto = memberdao.getMemeber(boardId);

String memberId = memberdto.getId();
String memberNum = memberdao.getNum(memberId);

DogProfileDao proDao = new DogProfileDao();
DogProfileDto proDto = proDao.getMainDogInfo(memberNum);
String proPhoto = proDto.getPhoto();

%>
<body>
	<div class="container" role="main">
		<div id="subject">
			<%=dto.getSubject()%>
		</div>
		유저 사진 & 닉네임 쓸 곳
		<br>
		<img alt="강아지 프로필 사진" src="/TodayWithMyDoggy/mypage/dogImg/<%=proPhoto%>" id="dogImg"
		style="width: 20px;">
		<%=nickname %><br>
		이미지: <%=proPhoto%>
		<hr>
		<img
			src="/TodayWithMyDoggy/place-share/place-photo/<%=dto.getPhotoName()%>"
			id="title-img">
		<br>
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