<%@page import="member.MemberDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.placeShare.PlaceShareBoardDto"%>
<%@page import="java.util.List"%>
<%@page import="board.placeShare.PlaceShareBoardDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
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
<meta name="theme-color" content="#7952b3">

<style>
.bd-placeholder-img {
	font-size: 1.125rem;
	text-anchor: middle;
	-webkit-user-select: none;
	-moz-user-select: none;
	user-select: none;
}

.container {
	width: 1200px;
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
  -moz-transform: scale(1.1);  /* 파이어폭스 */
  -ms-transform: scale(1.1); /* IE */
  -o-transform: scale(1.1);  /* 오페라 */
}
</style>

<%
PlaceShareBoardDao dao = new PlaceShareBoardDao();
List<PlaceShareBoardDto> list = dao.getList();

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>

</head>
<body>
	<div class="album py-5 bg-light">
		<div class="container">
			<button type="button" class="btn btn-warning" id="moveAdd" 
			onclick="location.href='index.jsp?main=place-share/write.jsp'">글쓰기</button>
			<br> <br>
			<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-md-4 g-4">

				<%
				for (PlaceShareBoardDto dto : list) {
				%>
				<div class="col">
					<div class="card border-light mb-10" width="100%" style="border-radius: 10%">
						<div class="card-img" id="img" style="border-radius: 12%">
							<input type="hidden" id="num" name="num" value="<%=dto.getNum() %>">
							<img class="img" class="bd-placeholder-img card-img-top" style="border-radius: 7%"
								src="/TodayWithMyDoggy/place-share/place-photo/<%=dto.getPhotoName()%>"
								height="250px;" xmlns="http://www.w3.org/2000/svg"
								role="img" aria-label="Placeholder: Thumbnail"
								preserveAspectRatio="xMidYMid slice" focusable="false"
								onclick="location.href='index.jsp?main=place-share/detail.jsp?num=<%=dto.getNum() %>'"+>
						</div>
						<div class="card-body">
							<p class="card-subject"><%=dto.getSubject()%></p>
							<p class="card-content"><%=dto.getContent()%></p>
							<div class="d-flex justify-content-between align-items-center">
								<small class="text-muted">작성자:<%=dto.getNickname()%>
									조회수:<%=dto.getReadCount()%> 좋아요수:<%=dto.getLikes()%></small>
							</div>
						</div>
					</div>
				</div>
				<%
				}
				%>
			</div>
		</div>
		<script src="/docs/5.1/dist/js/bootstrap.bundle.min.js"
			integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
			crossorigin="anonymous"></script>
</body>
</html>
