<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link
	href="https://fonts.googleapis.com/css2?family=Anton&family=Edu+VIC+WA+NT+Beginner:wght@600&family=Gamja+Flower&family=Single+Day&family=Jua&family=Nanum+Pen+Script&display=swap"
	rel="stylesheet">

<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<script type="text/javascript" src="js/layout.js"></script>
<link rel="stylesheet" href="css/layout.css">

<title>Insert title here</title>

<%
//프로젝트 경로구하기
String root = request.getContextPath();
//로그인 상태인지?
String loginok = (String)session.getAttribute("loginok");
// 관리자 계정인지?
String isAdmin = (String)session.getAttribute("isAdmin");
%>

</head>

<body>


<nav class="navbar navbar-expand-custom navbar-mainbg">
	<a class="navbar-brand navbar-logo" href="index.jsp?main.jsp">개
		커뮤니티</a>
	<button class="navbar-toggler" type="button"
		aria-controls="navbarSupportedContent" aria-expanded="false"
		aria-label="Toggle navigation">
		<i class="fas fa-bars text-white"></i>
	</button>
	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav ml-auto">
			<div class="hori-selector">
				<div class="left"></div>
				<div class="right"></div>
			</div>
			<%if(loginok != null && isAdmin.equals("0")){%>
			<li class="nav-item"><a class="nav-link"
				href="<%=root%>/index.jsp?main=mypage/userMyPage.jsp"><i class=""></i>마이페이지</a>
			</li>
			<%} else {%>
			<li class="nav-item"><a class="nav-link"
				href="<%=root%>/index.jsp?main=mypage/adminMyPage.jsp"><i class=""></i>관리자페이지</a></li>
			<%}%>
			<li class="nav-item active"><a class="nav-link"
				href="<%=root%>/index.jsp?main=dog-friend/board.jsp"><i class="far"></i>같이 걸어요</a></li>
			<li class="nav-item"><a class="nav-link"
				href="<%=root%>/index.jsp?main=dog-talking/board.jsp"><i class=""></i>우리강아지</a></li>
			<li class="nav-item"><a class="nav-link"
				href="<%=root%>/index.jsp?main=place-share/placeShareBoardInput.jsp"><i class=""></i>같이가요</a></li>
			<li class="nav-item"><a class="nav-link"
				href="<%=root%>/index.jsp?main=qna/qnalist.jsp"><i class="qnaBoard"></i>Q&A 게시판</a></li>
			<li class="nav-item"><a class="nav-link"
				href="<%=root%>/index.jsp?main=notification/notificationlist.jsp"><i class="notificationBoard"></i>공지사항</a></li>
			<li class="nav-item"><a class="nav-link"
				href="<%=root%>/index.jsp?main=login/loginform.jsp"><i class=""></i>로그인</a>
			</li>
			<li class="nav-item"><a class="nav-link"
				href="<%=root%>/index.jsp?main=signup/addform.jsp"><i class=""></i>회원가입</a>
			</li>
		</ul>
	</div>
</nav>
</head>
<body>
</body>
</body>
</html>