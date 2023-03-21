<%@page import="member.MemberDto"%>
<%@page import="member.MemberDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Insert title here</title>
	<link href="https://fonts.googleapis.com/css2?family=Anton&family=Edu+VIC+WA+NT+Beginner:wght@600&family=Gamja+Flower&family=Single+Day&family=Jua&family=Nanum+Pen+Script&display=swap" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<style type="text/css">
		.rectangle {
			border:1px solid black;
		}
		
		div > p {
			font-size: 2rem;
		}
	</style>
</head>
<body>
<%
	//로그인한 사용자 아이디 가져와서 사용자 member_num(시퀀스)값 추출.
	String id = (String)session.getAttribute("myid");
	MemberDao memberDao = new MemberDao();
	MemberDto memberDto = memberDao.getMemeber(id);
	String member_num = memberDao.getNum(id);
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	//전화번호 getHp를 -로 split하여 자름.
	String fullHp = memberDto.getHp();
	String[] hpArray = fullHp.split("-");
	
	//이메일 getEmail@로 split하여 자름.
	String fullEmail = memberDto.getEmail();
	String[] emailArray = fullEmail.split("@");
%>
	<script type="text/javascript">
		$(function(){
			
			// 폰번호 input에 멤버의 앞자리 폰번호 선택되게 하는 로직.
			// 멤버의 앞자리 폰번호가 어떤것이냐에 따라 select가 선택되는 스크립트문.
			if (<%=hpArray[0].equals("010")%>) {
				$(".hp1").prop("selected", true);
			} else if (<%=hpArray[0].equals("011")%>) {
				$(".hp2").prop("selected", true);
			} else if (<%=hpArray[0].equals("016")%>) {
				$(".hp3").prop("selected", true);
			} else if (<%=hpArray[0].equals("070")%>) {
				$(".hp4").prop("selected", true);
			}
			
			// 이메일 input에 멤버의 뒷자리 이메일(회사,이름)선택되게 하는 로직.
			//이메일 선택
	    	$("#selEmail").change(function(){
	    		if($(this).val()=='-'){
	    			$("#email2").val('');
	    		}else{
	    			$("#email2").val($(this).val());
	    		}
	    	});
		});
		
		//전화번호 4자리 입력하면 넘어가기
	   	function goFocus(hp){
	   		if(hp.value.length==4)
	   			frm.hp3.focus();
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
	<div class="container" style="padding-bottom: 100px;">
		<p style="font-family: 'Dovemayo_gothic'; font-size:2.5rem">세부정보 등록</p>
		<form action="index.jsp?main=login/kakao/kakaoprofileinputaction.jsp" method="post">
			<div class="" style="width:800px; margin:0 auto;">
				<p style="font-family: 'Dovemayo_gothic'; font-size:2.5rem">나의 프로필</p>
				<div class="row">
					<div class="col-6">
						<p>닉네임</p>
						<p><input type="text" class="form-control form-control-lg" name="nickname" placeholder="이름" value="<%=memberDto.getNickname()%>"></p>
						<p>아이디</p>
						<p><input type="text" class="form-control form-control-lg" name="id" placeholder="아이디" value="<%=memberDto.getId()%>" disabled></p>
						<p>핸드폰</p>
						<p>
							<select class="form-control" name="hp1" size="1" style="width:100px;display:inline-block;">
								<option value="010" class="hp1">010</option>
								<option value="011" class="hp2">011</option>
								<option value="016" class="hp3">016</option>
								<option value="070" class="hp4">070</option>
							</select>
							<span>-</span>
							<input type="text" class="form-control" name="hp2" size="3" required="required" onkeyup="goFocus(this)" value="<%=hpArray[1]%>" style="width:100px;display:inline-block;">
							<span>-</span>
							<input type="text" class="form-control" name="hp3" size="3" required="required" value="<%=hpArray[2]%>" style="width:100px;display:inline-block;">
							
							
						</p>
						<p>이메일</p>
						<p>
							<input type="text" class="form-control input-lg" name="email1" required="required" style="width:100px;display:inline-block;" value="<%=emailArray[0]%>">
							<span>@</span>
							<input type="text" class="form-control input-lg" name="email2" id="email2" required="required" style="width:100px;display:inline-block;" value="<%=emailArray[1]%>">
							
							<select id="selEmail" class="form-control" style="width: 100px; display: inline-block;">
								<option value="-">직접입력</option>
								<option value="naver.com">네이버</option>
								<option value="gmail.com">구글</option>
								<option value="hanmail.net">다음카카오</option>
								<option value="nate.com">네이트</option>
							</select>
						</p>
					</div>
					<div class="col">
						<p>주소</p>
						<select id="addr" class="form-control" name="addr" style="width: 100px; display: inline-block;">
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
				</div>
				
			</div>
			<input type="submit" class="btn btn-warning btn-lg mx-auto d-block" style="margin-top:50px;" value="저장">
		</form>
	</div>
</body>
</html>