<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>

</head>
<%
//세션값 얻기

	String saveok=(String)session.getAttribute("saveok");

	String myid="";
	if(saveok!=null){
		myid=(String)session.getAttribute("myid");
	}
	 String clientId = "sUt2jI76xWqhJYfWS7pU";//애플리케이션 클라이언트 아이디값";
	 String redirectURI = URLEncoder.encode("http://localhost:8080/TodayWithMyDoggy/index.jsp?main=login/navercallback.jsp", "UTF-8");
	 SecureRandom random = new SecureRandom();
     String state = new BigInteger(130, random).toString();
	 String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
	 apiURL += "&client_id=" + clientId;
	 apiURL += "&redirect_uri=" + redirectURI;
	 apiURL += "&state=" + state;
	 session.setAttribute("state", state);
%>
<body>
	<div style="margin-left:130px;">
		<form action="login/loginaction.jsp" method="post">
			<table style="width:300px;">
				<tr>
					<td colspan="2" align="center">
						<input type="checkbox" name="cbsave"<%=saveok==null?"":"checked" %>>아이디저장
					</td>
				</tr>
				
				<tr>
					<th width="100">아이디</th>
					<td>
						<input type="text" name="id" required="required" style="width:120px;"
						value="<%=myid%>">
					</td>
				</tr>
				
				<tr>
					<th width="100">비밀번호</th>
					<td>
						<input type="password" name="password" required="required" style="width:120px;">
					</td>
				</tr>
				
				<tr>
					<td colspan="2" align="center">
						<button type="submit" style="width:100px;" >로그인</button>
					</td>
				</tr>
				
				<tr>
				  <a href="<%=apiURL%>"><img height="50" src="http://static.nid.naver.com/oauth/small_g_in.PNG"/></a>
				 </tr>
				 
			</table>
		</form>
	</div>
	<script src="/js/user.js"></script>
</body>
</html>