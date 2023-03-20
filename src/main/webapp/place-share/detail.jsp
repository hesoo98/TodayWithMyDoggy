<%@page import="answer.placeShare.PlaceShareAnswerDao"%>
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
	border-radius: 17px;
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

#map-addr:hover {
	color: #e3d82b
}
</style>
<script type="text/javascript">
$(function() {
	//처음에 시작시 리스트 호출
	list();
	
	var boardnum = $("#boardnum").val();
	
	$("#btnanswer").click(function() {
	alert(boardnum);

	$.ajax({	
		type: "get",
		url: "place-share/answerAddAction.jsp",
		dataType: "html",
		data: {"boardnum":boardnum, "myid": $("#myid").val(), "content":$("#content").val()},
		success: function(res) {
			$("#content").val(" ");
			
			list();
			}
		});
	});	
});

//사용자 정의 호출
function list() {	
	$.ajax({
		type: "get",
		url: "place-share/answerList.jsp",
		data: {"boardnum":$("#boardnum").val()},
		dataType: "json",
		success: function(res) {
			var s = "";
			var nickname = $("#nickname").val();
			var photo = $("#photo").val();
			$.each(res, function(idx, item) {
				s += "<div class='img-box' style='width: 40px; height: 40px; border-radius: 70%; overflow: hidden; float: left; margin-right: 20px;'>";
				s += "<img alt='강아지 프로필 사진' src='/TodayWithMyDoggy/mypage/dogImg/"+photo+"' id='dogImg' style='width: 100%; height: 100%;'>&nbsp;&nbsp;</div>";
				s += "<div style='margin-botton: 40px;'>"+nickname+"님&nbsp;&nbsp;&nbsp;<span class='aday' style='color: gray'>" + item.writeday + "</span>";
				s += "<i class='fa-solid fa-ellipsis' style='padding-left: 150px; color:gray; cursor: pointer'></i></div>";
				s += "<div style='width: 400px; font-size:15px; margin-top:20px; padding-left:60px;'>" + item.content;
				s += "<br><br><br><br></div>";
				
			});
			
			$("#answerView").html(s);
		}
	});
}
</script>
<script src="https://kit.fontawesome.com/2663817d27.js"
	crossorigin="anonymous"></script>
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

PlaceShareAnswerDao answerDao = new PlaceShareAnswerDao();
int totalAnswerCnt = answerDao.getTotalAnswerCount(boardnum);

dao.addReadCount(boardnum);
%>
<body>
	<div class="container" role="main">
		<br>
		<div class="profile-box" style="margin-bottom: 70px;">
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
			<%
			String loginok = (String) session.getAttribute("loginok");
			if (loginok != null) {
			%>
			<div style="margin-left: 50%">
				<button type="button" class="btn btn-warning"
					style="width: 60px; height: 30px; border-radius: 10px;"
					onclick="location.href='index.jsp?main=place-share/update.jsp?num=<%=boardnum%>'">수정하기</button>
				<button type="button" class="btn btn-danger"
					style="width: 60px; height: 30px; border-radius: 10px;" id="delete"
					onclick="location.href='place-share/deleteAction.jsp?num=<%=boardnum%>'">삭제하기</button>
			</div>
			<%
			}
			%>
		</div>
		<hr style="width: 700px;">
		<br>
		<div id="subject">
			<%=dto.getSubject()%>
		</div>
		<br>
		<div style="font-size: 17px;">
			<%=dto.getContent()%>
		</div>
		<div class="content-img" style="margin: 50px 0; padding-bottom: 30px;">
			<img
				src="/TodayWithMyDoggy/place-share/place-photo/<%=dto.getPhotoName()%>"
				id="title-img" style="width: 40%">
		</div>

		<!-- 지도 -->
		<i style="color: #aaaaaa">하단 주소 클릭시 길찾기 페이지로 이동</i><br>
		<div class="map-box" style="margin-bottom: 100px;">
			<div id="map" style="width: 50%; height: 350px; margin-bottom: 20px;"></div>
			<input type="hidden" id="la" value="<%=dto.getPlaceLa()%>"> <input
				type="hidden" id="ma" value="<%=dto.getPlaceMa()%>"> <input
				type="hidden" id="mapAddr" value="<%=dto.getMapAddr()%>">
			<div id="map-addr" style="font-size: 17px; cursor: pointer;"
				onclick="window.open('https://map.kakao.com/link/to/<%=dto.getMapAddr()%>,<%=dto.getPlaceLa()%>,<%=dto.getPlaceMa()%>', '_blank')">
				<img src="/TodayWithMyDoggy/place-share/place-photo/kakaomap.png"
					style="width: 25px; border-radius: 5px; margin-right: 10px;"><%=dto.getMapAddr()%></div>
		</div>
		<i class="fa-solid fa-heart" style="margin-left: 10px; margin-top: 2px; color: grey; font-size: 16px;
		cursor: pointer; float: left;" id="heart"></i>&nbsp;<div style="font-size: 15px; float: left;"><%=dto.getLikes() %></div>
		<hr style="width: 550px; margin-top: 20px">
		<script type="text/javascript">
			$("#heart").click(function () {
				$("#heart").css("color", "#CD0000");
			});
		</script>
		<!-- 댓글 -->
		<br>
		<div class="answer-box">
			<div class="img-box"
				style="width: 40px; height: 40px; border-radius: 70%; overflow: hidden; float: left; margin-right: 10px;">
				<img alt="강아지 프로필 사진"
					src="/TodayWithMyDoggy/mypage/dogImg/<%=proPhoto%>" id="dogImg"
					style="width: 100%; height: 100%;">&nbsp;&nbsp;
			</div>
			<form action="place-share/answerAddAction.jsp">
				<input type="hidden" id="boardnum" value="<%=boardnum%>">
				<input type="hidden" id="myid" value="<%=myid%>">
				<input type="hidden" id="nickname" value="<%=nickname%>">
				<input type="hidden" id="photo" value="<%=proPhoto%>">
				<div class="answer-input" style="float: left;">
					<input type="text" id="content" 
						class="form-control answer" placeholder="댓글을 입력해주세요"
						style="float: left; width: 500px; padding: 0 20px;"> 
						<input type="button" id="btnanswer" value="전송" class="btn-answer"
						style="float: left; margin-top: 5px;">
				</div>
			</form>
			<br>
		</div>
		<br>
		<div class="answer-list" style="margin: 30px;">
			<div style="font-size: 15px;">
				댓글 수
				<%=totalAnswerCnt%>개
			</div>
			<div style="margin: 20px;">
				<span id="answerView"></span>
			</div>
		</div>
		<br> <br> <input type="hidden" id="num"
			value="<%=boardnum%>">
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
		marker.setOpacity(0.7);
		marker.setMap(map);
	</script>
	<script type="text/javascript">
		$("#delete").click(function() {
			var del = confirm("글을 삭제하시겠습니까?");
			var num = $("num").val();
			if (del) {
				location.href = "place-share/deleteAction.jsp?num=" + num;
			} else {
				location.history();
			}
		});
	</script>
</body>
</html>