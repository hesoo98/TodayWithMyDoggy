<%@page import="member.MemberDao"%>
<%@page import="profile.dogProfile.DogProfileDto"%>
<%@page import="profile.dogProfile.DogProfileDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<title>Insert title here</title>

<style type="text/css">

	body{
		border: 1px solid black;
		width:100%;
	}
	
	#wrapper{
		text-align: center;
	}
	
	/* 말풍선 */
	.box {
	  width: 400px;
	  margin: 50px auto;
	  border: 4px solid #d3d3d3;
	  padding: 20px;
	  text-align: center;
	  font-weight: 700;
	  color: #fdde6b;
	  font-family: arial;
	  position: relative;
	}

	.sb:before {
	  content: "";
	  width: 0px;
	  height: 0px;
	  position: absolute;
	  border-left: 10px solid transparent;
	  border-right: 10px solid transparent;
	  border-top: 10px solid #d3d3d3;
	  border-bottom: 10px solid transparent;
	  right: 50%;
	  bottom: -23px;
	}
	
	.sb:after {
	  content: "";
	  width: 0px;
	  height: 0px;
	  position: absolute;
	  border-left: 10px solid transparent;
	  border-right: 10px solid transparent;
	  border-top: 10px solid #fff;
	  border-bottom: 10px solid transparent;
	  right: 50%;
	  bottom: -18px;
	}
	
	.w-mydog{
	  margin-top: -30px;
	  margin-bottom: 30px;
	  left:100px;
	  width: 50px;
	  height: 50px;
	  border-radius: 50px;
	}

</style>

</head>

<%
String id=(String)session.getAttribute("myid");
MemberDao mdao=new MemberDao();
String num=mdao.getNum(id);

DogProfileDao dao=new DogProfileDao();
DogProfileDto dto=dao.getMyMainDog(num);

String proPhoto = dto.getPhoto();

%>

<body>
	
	<div id="wrapper">
		<div  class="box sb">
		<span id="w-city">지역</span>
		<span id="w-temp">온도</span>
		<span id="w-desc">날씨</span>
		<br>
		<span id="w-comment">문장</span>
		</div>
		
		<%if(dto.getIdx()!=null){%>
			<img class="w-mydog" src="/TodayWithMyDoggy/mypage/dogImg/<%=proPhoto%>">
		<%}else{%>
			<span class="w-mydog"><i class="fa-solid fa-dog fa-xl"></i></span>
		<%} %>
	</div>


</body>

<script type="text/javascript" src="js/weather.js"></script>
<script src="https://kit.fontawesome.com/2663817d27.js" crossorigin="anonymous"></script>
</html>