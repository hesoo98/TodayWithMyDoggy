<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
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
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
    

    </script>
    
</head>
<body>
	<form action="signup/addaction.jsp" method="post" onsubmit="return passCheck(this)" name="frm">
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
					<input type="text" id="sample6_postcode" placeholder="우편번호" required="required">
					<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" required="required"><br>
					<input type="text" id="sample6_address" placeholder="주소" required="required" name=addr1><br>
					<input type="text" id="sample6_detailAddress" placeholder="상세주소" required="required" name=addr2>
					<input type="text" id="sample6_extraAddress" placeholder="참고항목">
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
</body>
</html>