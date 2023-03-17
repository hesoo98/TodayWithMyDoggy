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

</style>

</head>
<body>

	<div id="wrapper">
		<div  class="box sb">
		<span id="w-temp">온도</span>
		<span id="w-desc">날씨</span>
		<img id="w-img">
		<br>
		<span id="w-comment">문장</span>
		</div>
		<i class="fa-solid fa-dog fa-xl"></i>
	</div>


</body>

<script type="text/javascript" src="js/weather.js"></script>
<script src="https://kit.fontawesome.com/2663817d27.js" crossorigin="anonymous"></script>
</html>