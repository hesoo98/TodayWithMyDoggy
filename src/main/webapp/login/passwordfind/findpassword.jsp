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
    function addHypen(obj) {
	    var number = obj.value.replace(/[^0-9]/g, "");
	    var hp = "";

	    if(number.length < 4) {
	        return number;
	    } else if(number.length < 7) {
	        hp += number.substr(0, 3);
	        hp += "-";
	        hp += number.substr(3);
	    } else if(number.length < 11) {
	        hp += number.substr(0, 3);
	        hp += "-";
	        hp += number.substr(3, 3);
	        hp += "-";
	        hp += number.substr(6);
	    } else {
	        hp += number.substr(0, 3);
	        hp += "-";
	        hp += number.substr(3, 4);
	        hp += "-";
	        hp += number.substr(7);
	    }
	    obj.value = hp;
	}
    </script>
</head>
<body>
	<form name="pwfindscreen" action="index.jsp?main=login/passwordfind/findpasswordresult.jsp" method = "POST">
			<div class = "search-title">
				비밀번호 찾기
			</div>
		<section class = "form-search">
			<div class = "find-id">
				<label>아이디</label>
				<input type="text" name="id" class = "btn-name" placeholder = "ID">
			<br>
			</div>
		
		 <div class = "find-phone">
				<label>번호</label>
				<input type="text" onKeyup = "addHypen(this);" name="hp" class = "btn-phone" placeholder = "휴대폰번호를 '-'없이 입력">
			</div> 
			<br>
	</section>
	<div class ="btnSearch">
		<input type="submit"value="찾기">
		<input type="button" name="cancle" value="취소" onClick="history.back()">
 	</div>
 </form>
</body>
</html>