<%@page import="profile.dogProfile.DogProfileDao"%>
<%@page import="profile.dogProfile.DogProfileDto"%>
<%@page import="member.MemberDto"%>
<%@page import="member.MemberDao"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	//db에 저장할 member_num가져오기
	String myid = (String)session.getAttribute("myid");
	MemberDao xdao = new MemberDao();//여기서만 쓰이는 dao라 x붙임.
	String member_num = xdao.getNum(myid);
	
	//이미지가 업로드되는 실제경로
	String realPath=getServletContext().getRealPath("/mypage/dogImg");
	System.out.println(realPath);
	
	int uploadSize = 1024*1024*5; //5mb
	MultipartRequest multi = null;
	
	try {
		multi = new MultipartRequest(request, realPath, uploadSize, "utf-8", new DefaultFileRenamePolicy());
		
		String name = multi.getParameter("name");
		String photoname = multi.getFilesystemName("photo");
		String gender = multi.getParameter("gender");
		String dogSize = multi.getParameter("dog_size");
		String birthday = multi.getParameter("birthday");
		
		//dto에 저장
		DogProfileDto dto = new DogProfileDto();
		dto.setMemberNum(member_num);
		dto.setName(name);
		dto.setGender(gender);
		dto.setDogSize(dogSize);
		dto.setBirthday(birthday);
		dto.setPhoto(photoname);
		
		//dao선언
		DogProfileDao dao = new DogProfileDao();
		dao.insertDogProfile(dto);
		
		// 목록으로 이동
		response.sendRedirect("../index.jsp?main=mypage/dogMorePage.jsp");
		
		
	} catch(Exception e) {
		System.out.println("업로드오류" + e.getMessage());
	}
%>