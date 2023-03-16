<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>

<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<title>Insert title here</title>
<title>Index</title>


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

<div class="layout menu">
	<jsp:include page="layout/menu.jsp" />
</div>

<style type="text/css">
.main {
	height: 500px;
}

div.main {
	height: auto;
	min-height: 100%;
}

#footer {
	height: 200px;
	position: relative;
	transform: translateY(-100%);
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
		<jsp:include page="<%=mainPage%>" />
		<div id="layout footer">
			<jsp:include page="layout/footer.jsp" />
		</div>
	</div>
</body>
</html>