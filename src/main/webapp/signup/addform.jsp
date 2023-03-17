<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
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
    	  alert("8자리 ~ 20자리 이내로 입력해주세요.");
    	  	f.password.value="";
  		  	f.password2.value="";
    	  return false;
    	 }else if(pw.search(/\s/) != -1){
    	  alert("비밀번호는 공백 없이 입력해주세요.");
    	  	f.password.value="";
  		 	f.password2.value="";
    	  return false;
    	 }else if(num < 0 || eng < 0 || spe < 0 ){
    	  alert("영문, 숫자, 특수문자를 혼합하여 입력해주세요.");
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
<div class="container" style="border:0px solid gray" >
<div style="width:600px; margin: 0 auto;" id="signuptable">
	<form action="signup/addaction.jsp" method="post" onsubmit="return passCheck(this)" name="frm" id="sign-form" >
		<div id="signuptext">
		회원가입
		</div>
		<br>
		<table style="border: 0px solid gray; width:500px;" >
			<tr>
				<th width="100">아이디</th>
				<td>
					<input type="text" name="id" id="id" required="required" style="width:120px;">
					<button type="button" id="btncheck" class="w-btn-outline w-btn-yellow-outline">중복체크</button>
					<span class="idsuccess"></span>
				</td>
			</tr>
			
			<tr>
				<th width="100">비밀번호</th>
				<td>
					<input type="password" id="password" name="password" required="required"
					style="width:120px;" placeholder="비밀번호">
					<span>영문, 숫자, 특수문자를 혼합한 8~20자리</span>
				</td>
			</tr>
			
			<tr>
				<th width="100">비밀번호 확인</th>
				<td>
					<input type="password" name="password2" required="required"
					style="width:120px;" placeholder="비밀번호 확인">
				</td>
			</tr>
			
			<tr>
				<th width="100">닉네임</th>
				<td>
					<input type="text" name="nickname" id="nickname" required="required" style="width:120px;">
					<button type="button" id="btncheck2">중복체크</button>
					<span class="nicknamesuccess"></span>
				</td>
			</tr>
			
			<tr>
				<th width="100">핸드폰</th>
				<td>
					<select name="hp1" size="1">
						<option value="010">010</option>
						<option value="011">011</option>
						<option value="016">016</option>
						<option value="070">070</option>
					</select>
					<b>-</b>
					<input type="text" name="hp2" size="3" required="required" onkeyup="goFocus(this)">
					<b>-</b>
					<input type="text" name="hp3" size="3" required="required">
			</td>
			</tr>
			
			<tr>
				<th width="100">주소</th>
				<td>
					<select name="address" size="1" class="nice-select">
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
				</td>
			</tr>
			
			<tr>
				<th width="100">이메일</th>
				<td>
					<input type="text" name="email1" required="required" style="width:120px;">
				<b>@</b>
					<input type="text" name="email2" id="email2" required="required" style="width:120px;">
					
					<select id="selEmail">
						<option value="-">직접입력</option>
						<option value="naver.com">네이버</option>
						<option value="gmail.com">구글</option>
						<option value="hanmail.net">다음카카오</option>
						<option value="nate.com">네이트</option>
					</select>
				</td>
			</tr>
			
			<tr>
				<td colspan="2", align="center">
					<button type="submit" style="width:100px;" id="signup">저장하기</button>
					<button type="reset" style="width:100px;">초기화</button>
				</td>
			</tr>
		</table>
	</form>
	</div>
	</div>
</body>
</html>