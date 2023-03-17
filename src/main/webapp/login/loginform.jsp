<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
<link rel="stylesheet" href="login/login.css">
</head>
<%
//세션값 얻기

String saveok = (String) session.getAttribute("saveok");

String myid = "";
if (saveok != null) {
	myid = (String) session.getAttribute("myid");
}
%>
<body>
	<!-- partial:index.partial.html -->
	<div id="login-form-wrap">
		<div id="title">Login</div>
		<form id="login-form" action="login/loginaction.jsp" method="post">
			<p>
				<input type="text" id="username" name="id" placeholder="아이디를 입력해주세요"
					required value="<%=myid%>"><i class="validation"><span></span><span></span></i>
			</p>
			<div style="margin-top: 25px;">
			<p>
				<input type="password" id="password" name="password"
					placeholder="비밀번호를 입력해주세요" required><i class="validation"><span></span><span></span></i>
			</p>
			</div>
			<br>
			<br>

			<div class="form-inline form-group">
				<div style="margin-left: 10px">
					<input type="checkbox" name="cbsave"
						<%=saveok == null ? "" : "checked"%> style="width: 13px">
				</div>
				<label for="phone_num" class="col-sm-0 control-label" style="padding-left: 5px; padding-top: 5px; color:gray;">아이디 저장
				</label>
			</div>
			<div style="">
				<input type="submit" id="login" value="Login">
			</div>

		</form>
		<div id="create-account-wrap">
			<p>
			 	<a href="index.jsp?main=login/idfind/findid.jsp">아이디 찾기</a>
			 	|
			 	<a href="index.jsp?main=login/passwordfind/findpassword.jsp">비밀번호 찾기</a>
			<p>
		</div>
		<!--create-account-wrap-->
	</div>
	<!--login-form-wrap-->
	<!-- partial -->

</body>
</html>
