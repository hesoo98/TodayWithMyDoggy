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
			// 이메일 선택
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
	</script>
	<div class="container" style="padding-bottom: 50px;">
	<p> | 나의 프로필 | </p>
		<form action="mypage/userProfileUpdateAction.jsp" method="post">
			<div style="width:800px;">
				
				<div class="row">
					<div class="col-6">
						<p>닉네임</p>
						<p><input type="text" class="form-control form-control" name="nickname" placeholder="이름" value="<%=memberDto.getNickname()%>"></p>
						<p>아이디</p>
						<p><input type="text" class="form-control form-control" name="id" placeholder="아이디" value="<%=memberDto.getId()%>" disabled></p>
						<p>핸드폰</p>
						<p>
							<select class="form-control" name="hp1" size="1" style="width:100px; display:inline-block;">
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
							<input type="text" class="form-control" name="email1" required="required" style="width:100px;display:inline-block;" value="<%=emailArray[0]%>">
							<span>@</span>
							<input type="text" class="form-control" name="email2" id="email2" required="required" style="width:100px;display:inline-block;" value="<%=emailArray[1]%>">
							
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
						<p>변경 전 주소</p>
						<p><input type="text" class="form-control form-control" name="oldaddr" placeholder="아이디" value="<%=memberDto.getAddr() %>" disabled></p><br>
						<p>변경 할 주소</p>
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
			<input type="submit" class="btn btn-light btn-sm mx-auto d-block" style="margin-top:50px;" value="저장">
		</form>
	</div>
</body>
</html>