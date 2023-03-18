<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
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
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0168677f39871625290af327bd783770&libraries=services"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style type="text/css">
.container {
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
	background-color: "";
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
String myid = (String) session.getAttribute("myid");

//로그인한 사람 닉네임
MemberDao mdao = new MemberDao();
String nickname = mdao.getNickname(myid);

// 게시글 번호
String boardnum = request.getParameter("num");

// 게시글 정보 가져와서 게시글 쓴 사람 아이디 구하기
PlaceShareBoardDao dao = new PlaceShareBoardDao();
PlaceShareBoardDto dto = dao.getData(boardnum);
String boardId = dto.getId();

// 게시글 쓴 사람 정보 가져오기
MemberDao memberdao = new MemberDao();
MemberDto memberdto = memberdao.getMemeber(boardId);

// 게시글 쓴 사람 id, num 가져오기
String memberId = memberdto.getId();
String memberNum = memberdao.getNum(memberId);

// 게시글 쓴 사람 num 값으로 프로필 정보 가져오기
DogProfileDao proDao = new DogProfileDao();
DogProfileDto proDto = proDao.getMainDogInfo(memberNum);

// 프로필 사진 가져오기
String proPhoto = proDto.getPhoto();

SimpleDateFormat sdf = new SimpleDateFormat("yyyy년-MM월-dd일 HH시:mm분");
%>
<body>
	<div class="container" role="main">
		<br>
		<div class="profile-box" style="margin-bottom: 100px;">
			<div class="img-box"
				style="width: 40px; height: 40px; border-radius: 70%; overflow: hidden; float: left;">
				<img alt="강아지 프로필 사진"
					src="/TodayWithMyDoggy/mypage/dogImg/<%=proPhoto%>" id="dogImg"
					style="width: 100%; height: 100%;">&nbsp;&nbsp;
			</div>
			<div class="nickname"
				style="float: left; padding-left: 10px; font-size: 15px;">
				<%=nickname%>님<br>
				<div class="date" style="color: gray">
					<%=sdf.format(dto.getWriteday())%><br>
				</div>
			</div>
		</div>

		<br>
		<div id="subject">
			<%=dto.getSubject()%>
		</div>
		<br>
		<div>
			<%=dto.getContent()%>
		</div>
		<div class="content-img" style="margin: 50px 0; padding-bottom: 30px;">
			<img
				src="/TodayWithMyDoggy/place-share/place-photo/<%=dto.getPhotoName()%>"
				id="title-img" style="width: 25%">
		</div>

		<!-- 지도 -->
		<div id="map" style="width: 50%; height: 350px; margin-bottom: 100px;"></div>
		<input type="hidden" id="la" value="<%=dto.getPlaceLa()%>"> <input
			type="hidden" id="ma" value="<%=dto.getPlaceMa()%>">

		<!-- 댓글 -->
		<div class="answer-box">
			<div class="answer-input">
				<input type="text" name="answer" value=""
					class="form-control answer" placeholder="댓글을 입력해주세요"
					style="float: left; width: 400px;"> <input type="button"
					value="전송" class="btn-answer" style="float: left; margin-top: 5px;">
			</div>
			<br> <br>
			<div class="answer-list">
				댓글쓴 사람<br>댓글 생성 날짜시간<br> 댓글 내용<br> 답글/수정/삭제
			</div>
		</div>
		<br> <br>
		<button type="button" class="btn btn-info" style="width: 100px;"
			onclick="location.href='index.jsp?main=place-share/update.jsp?num=<%=boardnum%>'">수정하기</button>
	</div>

	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng($("#la").val(), $("#ma").val()), // 지도의 중심좌표
			level : 4
		// 지도의 확대 레벨
		};

		// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
		var map = new kakao.maps.Map(mapContainer, mapOption);

		var imageSrc = 'place-share/place-photo/_Pngtree_dog_pet_animal_pin_location_5092521-removebg-preview.png', // 마커이미지의 주소입니다    
		imageSize = new kakao.maps.Size(94, 99), // 마커이미지의 크기입니다
		imageOption = {
			offset : new kakao.maps.Point(27, 69)
		}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

		// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize,
				imageOption), markerPosition = new kakao.maps.LatLng($("#la")
				.val(), $("#ma").val()); // 마커가 표시될 위치입니다

		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
			position : markerPosition,
			image : markerImage,
		// 마커이미지 설정 
		});
		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setOpacity(0.5);
		marker.setMap(map);
	</script>
</body>
</html>