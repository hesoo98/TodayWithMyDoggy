<%@page import="member.MemberDto"%>
<%@page import="profile.dogProfile.DogProfileDto"%>
<%@page import="profile.dogProfile.DogProfileDao"%>
<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link
	href="https://fonts.googleapis.com/css2?family=Anton&family=Edu+VIC+WA+NT+Beginner:wght@600&family=Gamja+Flower&family=Single+Day&family=Jua&family=Nanum+Pen+Script&display=swap"
	rel="stylesheet">

<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<script type="text/javascript" src="js/layout.js"></script>
<link rel="stylesheet" href="css/layout.css">

<%
//프로젝트 경로구하기
String root = request.getContextPath();
//로그인 상태인지?
String loginok = (String) session.getAttribute("loginok");
// 관리자 계정인지?
String isAdmin = (String) session.getAttribute("isAdmin");
//아이디얻기
String myid = (String) session.getAttribute("myid");
MemberDao dao = new MemberDao();
String nickname = dao.getNickname(myid);
%>
</head>

<body>
	<nav class="navbar navbar-expand-custom navbar-mainbg m-0 p-0">
		<img src="/TodayWithMyDoggy/css/doglogg.png" width="50px;"
			style="margin-left: 80px; margin-right: 10px;"> <a
			class="navbar-brand navbar-logo pb-2 pt-2" href="index.jsp?main.jsp">
			<div style="font-size: 16px;">
				<b>TodayWithMyDoggy</b>
			</div>
		</a>
		<button class="navbar-toggler" type="button"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<i class="fas fa-bars text-white"></i>
		</button>
		<div class="collapse navbar-collapse p-0" id="navbarSupportedContent">
			<ul class="navbar-nav ml-0">
				<div class="hori-selector">
					<div class="left"></div>
					<div class="right"></div>
				</div>

				<li class="nav-item active"><a class="nav-link"
					href="<%=root%>/index.jsp?main=dog-friend/board.jsp"><i
						class="far"></i>같이 걸어요</a></li>
				<li class="nav-item"><a class="nav-link"
					href="<%=root%>/index.jsp?main=dog-talking/board.jsp"><i
						class=""></i>우리강아지</a></li>
				<li class="nav-item"><a class="nav-link"
					href="<%=root%>/index.jsp?main=place-share/boardList.jsp"><i
						class=""></i>같이가요</a></li>
				<li class="nav-item"><a class="nav-link"
					href="<%=root%>/index.jsp?main=qna/qnalist.jsp"><i
						class="qnaBoard"></i>Q&A 게시판</a></li>
				<li class="nav-item"><a class="nav-link"
					href="<%=root%>/index.jsp?main=notification/notificationlist.jsp"><i
						class="notificationBoard"></i>공지사항</a></li>

				<%
				if (loginok == null) {
				%>
				<li class="nav-item"><a class="nav-link"
					href="<%=root%>/index.jsp?main=login/loginmain.jsp"><i class=""></i>로그인</a></li>
				<li class="nav-item"><a class="nav-link"
					href="<%=root%>/index.jsp?main=signup/terms.jsp"><i class=""></i>회원가입</a>
				</li>
				<%
				} else {
				%>

				<a href="index.jsp?main=message/list.jsp"
					style="width: 25px; padding-top: 15px; margin-left: 50px; margin-right: 15px;">
					<i class="fa-solid fa-envelope"
					style="color: #5b5b5b; font-size: 25px"></i>
				</a>
				<%
				String memberNum = dao.getNum(myid);

				DogProfileDao proDao = new DogProfileDao();
				DogProfileDto proDto = proDao.getMyMainDog(memberNum);

				String proPhoto = proDto.getPhoto();
				%>

				<div class="img-box"
					style="width: 35px; height: 35px; border-radius: 70%; overflow: hidden; float: left; margin-right: 2px; margin-top: 10px;">
					<img src="/TodayWithMyDoggy/mypage/dogImg/<%=proPhoto%>"
						id="profile-img" style="width: 100%; height: 100%">
				</div>
				<i class="fa-solid fa-caret-down fa-rotate-270"
					style="margin-left: 25px; cursor: pointer;"></i>

				<div class="profile-bar">

					<%
					if (loginok == null) {
					%>
					<!-- 로그인 하지 않았을경우 관리자,마이페이지 안보이게 -->
					<%
					} else if (loginok != null && isAdmin.equals("0")) {
					%>
					<i class="fa-solid fa-user"
						style="color: #494949; cursor: pointer;"
						onclick="location.href='mypage/userMyPage.jsp'"> </i> <span
						style="font-size: 11px; cursor: pointer;"
						onclick="location.href='mypage/userMyPage.jsp'">마이페이지 </span> <i
						class="fa-solid fa-right-from-bracket"
						style="color: #cc0000; padding-top: 20px; margin-left: 15px; cursor: pointer;"
						onclick="location.href='login/logoutaction.jsp'"> </i> <span
						style="font-size: 11px; padding-bottom: 5px; cursor: pointer;"
						onclick="location.href='login/logoutaction.jsp'">로그아웃 </span>
					<%
					} else {
					%>

					<i class="fa-solid fa-user"
						style="color: #494949; cursor: pointer;"
						onclick="location.href='mypage/userMyPage.jsp'"> </i> <span
						style="font-size: 11px; cursor: pointer;"
						onclick="location.href='mypage/adminMyPage.jsp'">마이페이지 </span> <i
						class="fa-solid fa-right-from-bracket"
						style="color: #cc0000; padding-top: 20px; margin-left: 15px; cursor: pointer;"
						onclick="location.href='login/logoutaction.jsp'"> </i> <span
						style="font-size: 11px; padding-bottom: 5px; cursor: pointer;"
						onclick="location.href='login/logoutaction.jsp'">로그아웃 </span>
					<%
					}
					%>
				</div>
				<%
				}
				%>
			</ul>
		</div>
	</nav>
</body>
<script type="text/javascript">
	$(".profile-bar").hide();
	$(".fa-caret-down").click(function() {
		$(".profile-bar").toggle('fast')
	});
</script>
<script src="https://kit.fontawesome.com/2663817d27.js"
	crossorigin="anonymous"></script>
</html>