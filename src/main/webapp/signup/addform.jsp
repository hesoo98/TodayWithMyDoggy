<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
    <script type="text/javascript">
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
    				}else{
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
    					$("#nickname").val('');
    					$("#nickname").focus();
    				}else{
    					//alert("가입 가능한 아이디입니다.");
    					$("span.nicknamesuccess").text("사용가능한 닉네임입니다.");
    				}
    			}
    			
    		})
    		
    	})
    	
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
    	if(f.password.value!=f.password2.value){
    		alert("비밀번호가 서로 다릅니다");
    		
    		f.password.value="";
    		f.password2.value="";
    		
    		return false;//action이 호출되지 않는다.
    	}
    }
    
    </script>
    
</head>
<body>
	<form action="addaction.jsp" method="post" onsubmit="return passCheck(this)">
		<table style="width:500px;">
			<tr>
				<th width="100">아이디</th>
				<td>
					<input type="text" name="id" id="id" required="required" style="width:120px;">
					<button type="button" id="btncheck">중복체크</button>
					<span class="idsuccess"></span>
				</td>
			</tr>
			
			<tr>
				<th width="100">비밀번호</th>
				<td>
					<input type="password" name="password" required="required"
					style="width:120px;" placeholder="비밀번호">
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
					<input type="text" name="addr" required="required" style="width:400px;">
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
					<button type="submit" style="width:100px;">저장하기</button>
					<button type="reset" style="width:100px;">초기화</button>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>