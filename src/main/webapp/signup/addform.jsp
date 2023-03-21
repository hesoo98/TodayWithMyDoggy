<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<link rel="stylesheet" href="signup/signup.css">
<style type="text/css">
body {
	background-color: #9f9da7;
	font-size: 1.6rem;
	font-family: "Open Sans", sans-serif;
	color: #2b3e51;
}
</style>
<script type="text/javascript">
    //전화번호 4자리 입력하면 넘어가기
   	function goFocus(hp){
   		if(hp.value.length==4)
   			frm.hp3.focus();
   	}
    $(function(){
    	//id중복체크
    	$("#btncheck").click(function(){
    		//id읽기
    		var id=$("#id").val();
    		//alert(id);
    		$.ajax({
    			type:"get",
    			url:"signup/idsearch.jsp",
    			dataType:"json",
    			data:{"id":id},
    			success:function(res){
    				
    				//console.log(res.count);
    				if(res.count==1){
    					//alert("이미 가입된 아이디입니다.\n다시 입력해 주세요.");
    					$("span.idsuccess").text("중복된 아이디입니다.");
    					$("#id").val('');
    					$("#id").focus();
    					}
    					else{
    					//alert("가입 가능한 아이디입니다.");
    					$("span.idsuccess").text("사용가능한 아이디입니다.");
    				}
    			}
    			
    		})
    		
    	})
    	//닉네임 중복체크
    	$("#btncheck2").click(function(){
    		//닉네임읽기
    		var nickname=$("#nickname").val();
    		//alert(nickname);
    		$.ajax({
    			type:"get",
    			url:"signup/nicknamesearch.jsp",
    			dataType:"json",
    			data:{"nickname":nickname},
    			success:function(res){
    				
    				//console.log(res.count);
    				if(res.count==1){
    					//alert("이미 가입된 아이디입니다.\n다시 입력해 주세요.");
    					$("span.nicknamesuccess").text("중복된 닉네임입니다.");
    					$("#id").val('');
    					$("#id").focus();
    					}
    					else{
    					//alert("가입 가능한 아이디입니다.");
    					$("span.nicknamesuccess").text("사용가능한 닉네임입니다.");
    				}
    			}
    			
    		})
    		
    	})
    	//아이디, 닉네임 중복확인 체크
    	   $("#signup").click(function(){
    		  if($("span.idsuccess").text() === ""){
    	  	  alert("아이디 중복확인 후 사용해주세요");
    	  	  return false;
    	 	 }else if($("span.idsuccess").text() === "중복된 닉네임입니다."){
    	 		 alert("아이디가 중복되었습니다.");
    	 		 return false;
    	 	 }else if($("span.nicknamesuccess").text() === ""){
    	 	   alert("닉네임 중복확인 후 사용해주세요");
    	 	   return false;
    	 	 }else if($("span.nicknamesuccess").text() === "중복된 닉네임입니다."){
    	 		 alert("닉네임이 중복되었습니다.");
    	 		 return false;
    	 	 };
    		});

    	//이메일 선택
    	$("#selEmail").change(function(){
    		if($(this).val()=='-'){
    			$("#email2").val('');
    		}else{
    			$("#email2").val($(this).val());
    		}
    	});
    });
    //비밀번호 확인
    function passCheck(f){
    	 var pw = $("#password").val();
    	 var num = pw.search(/[0-9]/g);
    	 var eng = pw.search(/[a-z]/ig);
    	 var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);

    	 if(pw.length < 8 || pw.length > 20){
    	  alert("비밀번호는 8자리 ~ 20자리 이내로 입력해주세요");
    	  	f.password.value="";
  		  	f.password2.value="";
    	  return false;
    	 }else if(pw.search(/\s/) != -1){
    	  alert("비밀번호는 공백 없이 입력해주세요");
    	  	f.password.value="";
  		 	f.password2.value="";
    	  return false;
    	 }else if(num < 0 || eng < 0 || spe < 0 ){
    	  alert("비밀번호에 영문, 숫자, 특수문자를 혼합하여 입력해주세요");
    	  	f.password.value="";
  		  	f.password2.value="";
    	  return false;
    	 }else if(f.password.value!=f.password2.value){
    	  alert("비밀번호가 서로 다릅니다");
    		f.password.value="";
    		f.password2.value="";
    		
    		return false;//action이 호출되지 않는다.
    		
    		
    	}else {
    		console.log("통과"); 
    	    return true;
    	 }
    
    	
    }
    </script>
</head>
<body>
	<div class="container"
		style="border: 0px solid gray; margin-bottom: 100px; margin-top: 100px;">
		<div style="width: 650px; height: 800px; margin: 0 auto;"
			id="signuptable">

			<form action="signup/addaction.jsp" method="post"
				onsubmit="return passCheck(this)" name="frm" id="sign-form"
				style="padding: 50px 100px; font-size: 13px;">
				<div id="signuptext" style="font-size: 20px;">회원가입</div>
				<br>
				<span width="100">아이디</span><span style="color: red"> *</span>&nbsp;&nbsp;<span class="idsuccess" style="color: #EB0000;"></span>
				<div>
					<input type="text" name="id" id="id" required="required"
						style="width: 320px; float: left" class="form-control" placeholder="아이디를 입력하세요">
					<button type="button" id="btncheck" class="alert alert-danger"
						style="width: 100px; margin-left: 10px; height: 40px; line-height:10px;">중복체크</button>
						<br>
						
				</div>
				<span width="100">비밀번호</span><span style="color: red"> *</span>
				<div>
					<input type="password" id="password" name="password"
						required="required" style="width: 430px;"
						placeholder="영문, 숫자, 특수문자를 혼합한 8~20자리" class="form-control">
				</div>
				<br>

				<span width="100">비밀번호 확인</span><span style="color: red"> *</span>
				<div>
					<input type="password" name="password2" required="required"
						style="width: 430px;" placeholder="비밀번호 확인" class="form-control">
				</div>
				<br>

				<span width="100">닉네임</span><span style="color: red"> *</span>&nbsp;&nbsp;<span class="nicknamesuccess" style="color: #EB0000;"></span><br>
				
				<div>
					<input type="text" name="nickname" id="nickname"
						required="required" style="width: 320px; float: left;"
						class="form-control" placeholder="닉네임을 입력하세요">
					<button type="button" id="btncheck2" class="alert alert-danger"
						style="width: 100px; height: 40px; line-height:10px; margin-left: 10px;">중복체크</button>
				</div>
				<div width="100">전화번호 <span style="color: red; margin-right: 10px;">*</span><span style="color: grey">
				('-'를 제외한 숫자만 입력)</span></div>
				<div class="hp" style="width: 400px;">
					<select name="hp1" size="1" style=" float: left; width: 80px; height: 30px; background-color: #eee"" class="form-control">
						<option value="010">010</option>
						<option value="011">011</option>
						<option value="016">016</option>
						<option value="070">070</option>
					</select> 
					 
					 <input type="text" name="hp2" size="3"
						required="required" onkeyup="goFocus(this)" class="form-control" style="width: 110px; float: left; height: 30px; margin-left: 10px;">
					 
					 <input type="text" name="hp3" size="3" required="required"
						class="form-control" style="width: 110px; float: left; height: 30px; margin-left: 10px;">
				</div>
				<br><br>
				<div style="margin-top: 10px;">
				<span width="100">이메일</span><span style="color: red">*</span>
				</div>
				<div>
					<input type="text" name="email1" required="required"
						style="width: 160px; float: left;" class="form-control"> <span style="float: left; padding-top: 10px;">&nbsp;@&nbsp;</span> 
						<input type="text" name="email2" id="email2" required="required"
						style="width: 140px; float: left;" class="form-control"> 
					<select id="selEmail" style="float: left; width:100px; height: 38px; margin-left: 10px; background-color: #eee" class="form-control">
						<option value="-">직접입력</option>
						<option value="naver.com">네이버</option>
						<option value="gmail.com">구글</option>
						<option value="hanmail.net">다음카카오</option>
						<option value="nate.com">네이트</option>
					</select>
				</div>
				
				<br><br>
				<div style="margin-top: 18px;">
					<span width="100">주소</span><span style="color: red">*</span>
				</div>
				<div>
					<select name="address" size="1" class="nice-select form-control" style="width: 27%">
						<option value="강원">강원</option>
						<option value="경기">경기</option>
						<option value="경남">경남</option>
						<option value="경북">경북</option>
						<option value="광주">광주</option>
						<option value="대구">대구</option>
						<option value="대전">대전</option>
						<option value="부산">부산</option>
						<option value="서울" selected>서울</option>
						<option value="세종">세종</option>
						<option value="울산">울산</option>
						<option value="인천">인천</option>
						<option value="전남">전남</option>
						<option value="전북">전북</option>
						<option value="제주">제주</option>
						<option value="충남">충남</option>
						<option value="충북">충북</option>
					</select>
				</div>
				<div style="margin-top: 50px; margin-left: 120px;">
					<button type="submit" class="btn btn-outline-secondary" style="width: 100px; color: black" id="signup">회원가입</button>
					&nbsp;
					<button type="reset" class="btn btn-outline-secondary" style="width: 100px; color: black">초기화</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>