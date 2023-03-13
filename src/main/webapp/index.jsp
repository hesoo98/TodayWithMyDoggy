<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<title>Insert title here</title>

<style type="text/css">

</style>

</head>
	<%
	  String mainPage="layout/main.jsp";
	
	//url을 통해서 main값을 읽어서 메인페이지에 출력을 한다
	if(request.getParameter("main")!=null){
		mainPage=request.getParameter("main");
	}
	  String root=request.getContextPath();
	%>
<body>
	<!-- 
	<div class="layout title">
		<jsp:include page="layout/title.jsp"/>		
	</div>
	 -->
	<div class="layout menu">
		<jsp:include page="layout/menu.jsp"/>		
	</div>

	<div class="layout main">
		<jsp:include page="<%=mainPage %>" />
	</div>

	<div class="layout footer">
		<jsp:include page="layout/footer.jsp"/>		
	</div>

</body>
</html>