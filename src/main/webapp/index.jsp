<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link rel="icon" type="image/png" href="files/favicon-96x96.png" sizes="96x96">
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<title>Today With My Doggy</title>

<style type="text/css">

@font-face {
    font-family: 'SUIT-Regular';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_suit@1.0/SUIT-Regular.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}

* {
	font-family: SUIT-Regular;
	font-weight: 100;
}
</style>


<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<!-- jQuery library -->
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.6.3/dist/jquery.slim.min.js"></script>

<!-- Popper JS -->
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<style type="text/css">

*{
	padding: 0px;
	margin: 0px;
}

.layout{
	width: 1200px;
}


.main {
	height: auto;
	min-height: 100%;
	width: 1280px;
}
	
#wrapper{
	display: flex;
	height: auto;
	justify-content: space-between;
	margin: 30px 0px;
}

.aside{
	width: 200px;
}

#footer {
	margin: auto;
	clear: both;
	height: 200px;
}

	/* css */
	
	input,textarea{
		padding: 2px 3px;
	}

	input:focus,textarea:focus, select {
	    outline: none;
	}
	
	table{
		table-layout: fixed
	}
	
	a:hover{
		color: black;
	}
</style>

</head>

<%
String mainPage = "layout/main.jsp";
if (request.getParameter("main") != null) {
	mainPage = request.getParameter("main");
}
String root = request.getContextPath();
%>

<body>
	<!-- 페이지 전환시 navbar 위 공간 오류 원인 -->
	<div class="layout main">
		<div id="menu">
			<jsp:include page="layout/menu.jsp" />
		</div>
		
		<div id="wrapper">
			<div class="aside">
				<jsp:include page="layout/aside-left.jsp" />
			</div>
			<div>
				<jsp:include page="<%=mainPage%>" />
			</div>
			<div class="aside">
				<jsp:include page="layout/aside-right.jsp" />
			</div>
		</div>
	
	</div>
		<div id="footer">
			<jsp:include page="layout/footer.jsp" />
		</div>
</body>
</html>