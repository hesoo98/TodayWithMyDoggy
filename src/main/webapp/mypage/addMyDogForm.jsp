<%@page import="profile.dogProfile.DogProfileDao"%>
<%@page import="profile.dogProfile.DogProfileDto"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>강아지 프로필 수정 폼</title>
	<link href="https://fonts.googleapis.com/css2?family=Anton&family=Edu+VIC+WA+NT+Beginner:wght@600&family=Gamja+Flower&family=Single+Day&family=Jua&family=Nanum+Pen+Script&display=swap" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<script src="https://kit.fontawesome.com/2663817d27.js" crossorigin="anonymous"></script>
	<style type="text/css">
		.rectangle {
			border:1px solid black;
		}
		#dogprofile {
			border:1px solid #EDEDED;
			border-radius: 200px;
			width:200px;
			height:200px;
		}
	</style>
	<script type="text/javascript">
		$(function(){
			// 카메라 이미지 눌렀을때 선택창 클릭한 것처럼 하기.
			$("#camera").click(function(){
				$("#photo").trigger("click"); //이벤트 강제호출 : trigger
			});
		});
		
		function readURL(input) {
			if(input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					$('#dogprofile').attr("src", e.target.result);
				}
				reader.readAsDataURL(input.files[0]);
			}
		}
	</script>
</head>
<body>
	<div class="container main">
		<p>| 강아지 추가 | </p>
	
		<div style="width:800px; margin:0 auto;">
			<form action="mypage/addDogAction.jsp" method="post" enctype="multipart/form-data">
				<div class="row" style="float:none;">
					<div class="row" style="float:none;margin:0 auto;">
						<img src="/TodayWithMyDoggy/mypage/dogImg/dogImgNotFound.png" id="dogprofile">
					</div>
				</div>
				
				<div class="row justify-content-end" style="margin-top: 30px;">
					<i class="fa-solid fa-camera camera" id="camera">&nbsp;&nbsp;<b>사진 추가</b></i>
				 	<input type="file" name="photo" id="photo" style="visibility: hidden;" onchange="readURL(this)" required="required">
				</div>
				
				<table class="table table-borderless align-middle">
					<tr>
						<td style="text-align:right;">
							강아지 이름 &nbsp;&nbsp;&nbsp;
						</td>
						<td>
							<input type="text" name="name" class="form-control" style="width:200px;" placeholder="강아지 이름 입력" required="required">
						</td>
					</tr>
					<tr>
						<td style="text-align:right;">성별 &nbsp;&nbsp;&nbsp;</td>
						<td>
							<input type="radio" name="gender" value="암"><i class="fa-solid fa-venus"></i>&nbsp;&nbsp;
							<input type="radio" name="gender" value="수"><i class="fa-solid fa-mars"></i>&nbsp;&nbsp;
							<input type="radio" name="gender" value="중성화"><i class="fa-solid fa-venus-mars"></i>&nbsp;&nbsp;
						</td>
					</tr>
					
					<tr>
						<td style="text-align:right;">사이즈 &nbsp;&nbsp;&nbsp;</td>
						<td>
							<input type="radio" name="dog_size" value="소형견">소형&nbsp;&nbsp;	
							<input type="radio" name="dog_size" value="중형견">중형&nbsp;&nbsp;
							<input type="radio" name="dog_size" value="대형견">대형&nbsp;&nbsp;
						</td>
					</tr>
					<tr>
						<td style="text-align:right;">생일 &nbsp;&nbsp;&nbsp;</td>
						<td>
							<input type="date" name="birthday" value="2023-03-14"min="2000-01-01" max="2030-12-31">
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<input type=submit class="btn btn-light btn-sm" value=저장하기 style="float:right;">
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>