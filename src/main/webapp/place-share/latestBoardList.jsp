<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.placeShare.PlaceShareBoardDao"%>
<%@page import="java.util.List"%>
<%@page import="answer.placeShare.PlaceShareAnswerDao"%>
<%@page import="profile.dogProfile.DogProfileDto"%>
<%@page import="profile.dogProfile.DogProfileDao"%>
<%@page import="member.MemberDto"%>
<%@page import="member.MemberDao"%>
<%@page import="board.placeShare.PlaceShareBoardDto"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/page.css">

<link rel="canonical"
	href="https://getbootstrap.kr/docs/5.1/examples/album/">

<!-- Bootstrap core CSS -->
<link href="/docs/5.1/dist/css/bootstrap.min.css" rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>

<!-- Favicons -->
<link rel="apple-touch-icon"
	href="/docs/5.1/assets/img/favicons/apple-touch-icon.png"
	sizes="180x180">
<link rel="icon" href="/docs/5.1/assets/img/favicons/favicon-32x32.png"
	sizes="32x32" type="image/png">
<link rel="icon" href="/docs/5.1/assets/img/favicons/favicon-16x16.png"
	sizes="16x16" type="image/png">
<link rel="manifest" href="/docs/5.1/assets/img/favicons/manifest.json">
<link rel="mask-icon"
	href="/docs/5.1/assets/img/favicons/safari-pinned-tab.svg"
	color="#7952b3">
<link rel="icon" href="/docs/5.1/assets/img/favicons/favicon.ico">
<link rel="stylesheet" href="place-share/btn.css">

<meta name="theme-color" content="#7952b3">

<style>
.bd-placeholder-img {
	font-size: 1.125rem;
	text-anchor: middle;
	-webkit-user-select: none;
	-moz-user-select: none;
	user-select: none;
}

@media ( min-width : 768px) {
	.bd-placeholder-img-lg {
		font-size: 3.5rem;
	}
}

.card-img {
	width: 100%;
	overflow: hidden;
}

img {
	max-width: 100%;
	cursor: pointer;
	transition: transform .3s; /* Animation */
}

img:hover {
	transform: scale(1.1);
	-webkit-transform: scale(1.1); /* 크롬, 사파리 */
	-moz-transform: scale(1.1); /* 파이어폭스 */
	-ms-transform: scale(1.1); /* IE */
	-o-transform: scale(1.1); /* 오페라 */
}

#profile-img {
	width: 20px;
	border-radius: 20px 20px;
}
/*말 줄임표 생성 시작*/
.card-subject, .card-content {
	display: block;
	max-width: calc(100%);
	overflow: hidden;
	white-space: nowrap;
	text-overflow: ellipsis;
}
/*말 줄임표 생성 끝*/
.img-text {
	position: absolute;
	top: 5%;
	left: 20px;
	width: 50px;
	font-size: 13px;
	z-index: 1;
}

#img-addr-text {
	background-color: #00000066;
	width: 70px;
	border: none;
	border-radius: 50px;
	height: 27px;
	padding-left: 20px;
}
</style>
</head>
<body>
	<div class="album pb-5 bt-2">
		<div class="container">
			<br> <br>
					<div style="font-size: 13px; text-align:right; margin-left: 180px; color: gray;
					cursor: pointer;">더보기</div><br>
			
			<div
				class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-md-4 g-4">
				<%
				PlaceShareBoardDao dao = new PlaceShareBoardDao();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
				List<PlaceShareBoardDto> list = dao.getBoardList();
				int i=1;
				for (PlaceShareBoardDto dto : list) {
					if(i==5) {
						break;
					}
					String boardNum = dto.getNum();
					String boardId = dto.getId();
					MemberDao memberdao = new MemberDao();
					MemberDto memberdto = memberdao.getMemeber(boardId);
					String memberId = memberdto.getId();
					String memberNum = memberdao.getNum(memberId);
					DogProfileDao proDao = new DogProfileDao();
					DogProfileDto proDto = proDao.getMainDogInfo(memberNum);
					String proPhoto = proDto.getPhoto();
					String place = dto.getMapAddr().substring(0, 2);
					PlaceShareAnswerDao answerDao = new PlaceShareAnswerDao();
					int totalAnswerCnt = answerDao.getTotalAnswerCount(boardNum);
				%>
				<div class="col">
					<div class="card border-light mb-10" width="100%"
						style="border-radius: 10%;">
						<div class="card-img" id="img" style="border-radius: 12%;">
							<div class="img-text">
								<img src="/TodayWithMyDoggy/place-share/place-photo/marker.png"
									style="width: 15px; border-radius: 100%; position: absolute; margin-left: 10px; margin-top: 5px;">
								<button id="img-addr-text" style="color: #fff"><%=place%></button>
							</div>
							<input type="hidden" id="num" name="num"
								value="<%=dto.getNum()%>"> <img class="img" id="cardImg"
								class="bd-placeholder-img card-img-top"
								style="border-radius: 7%" width="600px;"
								src="/TodayWithMyDoggy/place-share/place-photo/<%=dto.getPhotoName()%>"
								height="200px;" xmlns="http://www.w3.org/2000/svg" role="img"
								aria-label="Placeholder: Thumbnail"
								preserveAspectRatio="xMidYMid slice" focusable="false"
								onclick="location.href='index.jsp?main=place-share/detail.jsp?num=<%=dto.getNum()%>'">
						</div>
						<div class="card-body">
							<span class="card-subject"
								style="font-size: 15px; cursor: pointer;"
								onclick="location.href='index.jsp?main=place-share/detail.jsp?num=<%=dto.getNum()%>'"><%=dto.getSubject()%></span>
							<span class="card-content"
								style="font-size: 12px; cursor: pointer; margin-bottom: 7px;"
								onclick="location.href='index.jsp?main=place-share/detail.jsp?num=<%=dto.getNum()%>'"><%=dto.getContent()%></span>
							<div class="d-flex justify-content-between align-items-center">
								<div class="img-box"
									style="width: 25px; height: 25px; border-radius: 70%; overflow: hidden; float: left; margin-right: 2px;">
									<img src="/TodayWithMyDoggy/mypage/dogImg/<%=proPhoto%>"
										id="profile-img" style="width: 100%; height: 100%">
								</div>
								<div
									style="float: left; padding-top: 5px; font-size: 10px; color: gray">
									<%=memberdto.getNickname()%>님 &emsp;&emsp; <i
										class="fa-regular fa-eye"></i><%=dto.getReadCount()%>
									&nbsp;<i class="fa-regular fa-comment-dots"></i><%=totalAnswerCnt%>
								</div>
								<br>

							</div>
						</div>
					</div>
				</div>
				<%
				i++;
				}
				%>
			</div>
		</div>
	</div>

</body>
</html>