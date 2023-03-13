<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<title>Insert title here</title>

<style type="text/css">

	div.layout{
	  border: 1px solid gray;
	  position: absolute;
	  font-family: "Nanum Gothic";
	}
	
	div.title{
	border: 1px solid gray;
	  width: 1200px;
	  height: 150px;
	  line-height: 80px;
	  font-size: 25px;
	  top:0px;
	  text-align: center;
	}
	
	div.menu{
	border: 1px solid gray;
	  margin-top:10px;
	  width: 1200px;
	  height: 50px;
	  font-size: 20px;
	  top:150px;
	  text-align: center;
	}
	
	div.main{
	border: 1px solid gray;
	  width:1200px;
	  height:500px;
	  font-size: 12px;
	  top: 230px;
	}
	
	div.footer{
	  width:1200px;
	  height: 100px;
	  top:740px;
	  border:1px solid black;
	}
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
	<div class="layout title">
		<jsp:include page="layout/title.jsp"/>		
	</div>

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