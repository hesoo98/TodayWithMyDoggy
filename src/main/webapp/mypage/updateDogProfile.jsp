<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="profile.dogProfile.DogProfileDto"%>
<%@page import="profile.dogProfile.DogProfileDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Insert title here</title>
	<link href="https://fonts.googleapis.com/css2?family=Anton&family=Edu+VIC+WA+NT+Beginner:wght@600&family=Gamja+Flower&family=Single+Day&family=Jua&family=Nanum+Pen+Script&display=swap" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<script src="https://kit.fontawesome.com/2663817d27.js" crossorigin="anonymous"></script>
	<style type="text/css">
		#dogprofile {
			border:2px solid gray;
			border-radius: 200px;
			width:200px;
			height:200px;
		}
	</style>
	<%
		String dog_idx = request.getParameter("idx");
		DogProfileDao dogDao = new DogProfileDao();
		DogProfileDto dogDto = dogDao.getDogProfileDto(dog_idx);
		String gender = dogDto.getGender();
		String dog_size = dogDto.getDogSize();
		String birthday = dogDto.getBirthday();
		String photo_name = dogDto.getPhoto();
		
		//이미지가 업로드되는 실제경로
		String realPath=getServletContext().getRealPath("/mypage/dogImg");
		String absolute_photo = realPath+"\\"+dogDto.getPhoto();
		//System.out.println(photo);
	%>
	<script type="text/javascript">
		$(function(){
			// 강아지 성별 정보 불러와서 radio에 표시
			if("<%=gender%>" == "암"){
				$(".gender1").prop("checked", true);
			} else if("<%=gender%>" == "수"){
				$(".gender2").prop("checked", true);
			} else if("<%=gender%>" == "중성화"){
				$(".gender3").prop("checked", true);
			}
			
			// 강아지 사이즈 정보 불러와서 radio에 표시
			if("<%=dog_size%>" == "소형견"){
				$(".size1").prop("checked", true);
			} else if("<%=dog_size%>" == "중형견"){
				$(".size2").prop("checked", true);
			} else if("<%=dog_size%>" == "대형견"){
				$(".size3").prop("checked", true);
			}
			
			
			
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

<script>
	
</script>
	<div class="container main" style="border:1px solid red;">
		<h1>강아지 수정 폼</h1>
		<div class="" style="width:800px;margin:0 auto;">
			<form action="mypage/updateDogAction.jsp" method="post" enctype="multipart/form-data">
				<input type="hidden" name="idx" value="<%=dog_idx%>">
				<div class="row" style="float:none;">
					<div class="row" style="float:none;margin:0 auto;">
						<img src="/TodayWithMyDoggy/mypage/dogImg/<%=photo_name %>" id="dogprofile">
					</div>
				</div>
				<div class="row">
				 	<input type="file" name="photo" id="photo" onchange="readURL(this)" required="required" value="/TodayWithMyDoggy/mypage/dogImg/<%=photo_name%>">
				</div>
				<table class="table table-borderless align-middle">
					<tr>
						<td style="text-align:right;">
							강아지 이름 &nbsp;&nbsp;&nbsp;
						</td>
						<td>
							<input type="text" name="name" class="form-control" style="width:200px;" placeholder="강아지 이름 입력" required="required" value="<%=dogDto.getName()%>">
						</td>
					</tr>
					<tr>
						<td style="text-align:right;">성별 &nbsp;&nbsp;&nbsp;</td>
						<td>
							<input type="radio" name="gender" value="암" class="gender1"><i class="fa-solid fa-venus"></i>&nbsp;&nbsp;
							<input type="radio" name="gender" value="수" class="gender2"><i class="fa-solid fa-mars"></i>&nbsp;&nbsp;
							<input type="radio" name="gender" value="중성화" class="gender3"><i class="fa-solid fa-venus-mars"></i>&nbsp;&nbsp;
						</td>
					</tr>
					
					<tr>
						<td style="text-align:right;">사이즈 &nbsp;&nbsp;&nbsp;</td>
						<td>
							<input type="radio" name="dog_size" value="소형견" class="size1">소형&nbsp;&nbsp;	
							<input type="radio" name="dog_size" value="중형견" class="size2">중형&nbsp;&nbsp;
							<input type="radio" name="dog_size" value="대형견" class="size3">대형&nbsp;&nbsp;
						</td>
					</tr>
					<tr>
						<td style="text-align:right;">생일 &nbsp;&nbsp;&nbsp;</td>
						<td>
							<input type="date" name="birthday" value="<%=birthday%>"min="2000-01-01" max="2030-12-31">
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<input type=submit class="btn btn-warning btn-lg" value=저장하기 style="float:right;">
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>

</html>