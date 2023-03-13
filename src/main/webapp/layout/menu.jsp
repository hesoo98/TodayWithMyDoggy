<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<title>Insert title here</title>
</head>
<body>

	<a href="#">메인</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="#">마이페이지</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="index.jsp?main=dog-talking/write.jsp">같이걸어요</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="#">우리강아지</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="#">같이가요</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="index.jsp?main=qna/qnalist.jsp">Q&A</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="index.jsp?main=notification/notificationlist.jsp">공지사항</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<%
	//프로젝트 경로구하기
	String root = request.getContextPath();
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<!-- 홈페이지의 로고 -->
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expand="false">
				<span class="icon-bar"></span>
				<!-- 줄였을때 옆에 짝대기 -->
				<span class="icon-bar"></span> <span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">웹 페이지 제목</a>
		</div>

		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="<%=root%>/index.jsp">메인</a></li>
				<li><a href="<%=root%>/index.jsp?main=loginmain.jsp">마이페이지</a></li>
				<li><a href="<%=root%>/index.jsp?main=member/addform.jsp">같이걸어요</a></li>
				<li><a href="<%=root%>/index.jsp?main=guest/guestlist.jsp">우리강아지</a></li>
				<li><a href="<%=root%>/index.jsp?main=board/boardlist.jsp">같이가요</a></li>
				<li><a href="<%=root%>/index.jsp?main=board/boardlist.jsp">Q&A</a></li>
			</ul>
			<%
			// 회원이 아닌 경우
			if (userID == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul></li>
			</ul>
			<%
			} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul></li>
			</ul>
			<%
			}
			%>
		</div>
	</nav>
</body>
</html>