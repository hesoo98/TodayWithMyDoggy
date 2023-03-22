<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
    
    <style type="text/css">
    
  		#wrapper-form{
  			width: 100%;
  			height: 100%;
  			border: 1px solid lightgray;
			border-radius: 10px;  			
  			padding: 20px 50px;
  		}
    
    	.search-title{
    		margin: 5px 0px;
    	}
  		
  		input[type="text"]{
  			outline: none;
  			border: none;
  			width: 200px;
  			border-bottom: 1px solid lightgray;
  		}
  		
  		input[type="text"]:focus{
  			border-bottom-color: black;
  		}
    
    </style>
    
</head>
<body>
		<form id="wrapper-form" name="idfindscreen" action="index.jsp?main=login/idfind/findidresult.jsp" method = "POST">
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
	
	<div class="btnSearch" align="center">
		<input class="btn btn-default" type="submit" value="찾기">
		<input class="btn btn-default" type="button" value="취소" onClick="history.back()">
 	</div>
 	
 </form>
</body>
</html>