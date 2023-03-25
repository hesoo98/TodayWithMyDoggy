<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>

<script src = "https://developers.kakao.com/sdk/js/kakao.min.js"></script>

<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
<link rel="stylesheet" href="login/login.css">
<link rel="canonical"
	href="https://getbootstrap.kr/docs/5.1/examples/album/">
<!-- Bootstrap core CSS -->
<link href="/docs/5.1/dist/css/bootstrap.min.css" rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>

<!-- Favicons -->
<link rel="apple-touch-icon"
	href="/docs/5.1/assets/img/favicons/apple-touch-icon.png"
	sizes="180x180">
<link rel="icon" href="/docs/5.1/assets/img/favicons/favicon-32x32.png"
	sizes="32x32" type="image/png">
<link rel="icon" href="/docs/5.1/assets/img/favicons/favicon-16x16.png"
	sizes="16x16" type="image/png">
<link rel="manifest" href="/docs/5.1/assets/img/favicons/manifest.json">
<link rel="mask-icon"
	href="/docs/5.1/assets/img/favicons/safari-pinned-tab.svg"
	color="#7952b3">
<link rel="icon" href="/docs/5.1/assets/img/favicons/favicon.ico">
<meta name="theme-color" content="#7952b3">

<style type="text/css">

 	#btns{
 		width: 100%;
 	}

</style>

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

			<div class="form-inline form-group">
				<div>
					<input type="checkbox" name="cbsave"
						<%=saveok == null ? "" : "checked"%> style="width: 13px">
				</div>
				<label for="phone_num" class="col-sm-0 control-label" style="padding-left: 5px; padding-top: 5px; color:gray;">아이디 저장
				</label>
			</div>
			<div id="btns">
				<input type="submit" id="login" value="Login">
				<br>
				<a class ="kakao-login-btn"></a>
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
			 
	
	<div id="result">
	</div>
    
   <script type="text/javascript">
Kakao.init('c3daec463cc1c038e93542b4609bf488');
//console.log(Kakao.isInitialized());
 
  Kakao.Auth.createLoginButton({
    container: '.kakao-login-btn',
    success: function(authObj) {
      Kakao.API.request({
        url: '/v2/user/me',
        success: function(result) {
          id = result.id
          kakao_account = result.kakao_account
          nickname= kakao_account.profile.nickname
          email = kakao_account.email;
    
          //ajax
          $.ajax({
        	  type:"post",
        	  dataType:"html",
        	  url:"index.jsp?main=login/kakao/kakaologin.jsp",
        	  data:{"id":id,
        		  "nickname":nickname,
        		  "email":email,
        		  },
        	  success:function(){
        		  $(window).scrollTop(0);
        		  location.reload();
        	  }
        	  
          })
        }
      
      ,
        fail: function(error) {
          alert(
            'login success, but failed to request user information: ' +
              JSON.stringify(error)
          )
        },
      })
    },
    fail: function(err) {
      alert('failed to login: ' + JSON.stringify(err))
    },
  })
</script>

</body>
</html>