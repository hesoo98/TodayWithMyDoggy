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
		<form name="idfindscreen" action="index.jsp?main=login/idfind/findidresult.jsp" method = "POST">
			<div class = "search-title">
				아이디 찾기
			</div>
			
		<section class = "form-search">
			
			<div class = "find-phone">
				<label>번호</label>
				<input type="text" name="hp" onKeyup = "addHypen(this);" class = "btn-phone" placeholder = "휴대폰번호를 '-'없이 입력">
			</div>
			
			<br>
	</section>
	
	<div class ="btnSearch">
		<input type="submit" value="찾기">
		<input type="button" value="취소" onClick="history.back()">
 	</div>
 	
 </form>
</body>
</html>