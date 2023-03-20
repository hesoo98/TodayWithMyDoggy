<%@page import="profile.dogProfile.DogProfileDao"%>
<%@page import="profile.dogProfile.DogProfileDto"%>
<%@page import="member.MemberDto"%>
<%@page import="member.MemberDao"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%

	DogProfileDao dogDao = new DogProfileDao();
	MemberDao memberDao = new MemberDao();
	
	//db에 저장할 member_num가져오기
	String id = (String)session.getAttribute("myid");
	String member_num = memberDao.getNum(id);
	
	// 내 모든 강아지 마리 수
	//int myDogCount = dogDao.getMyDogList(member_num).size();
	
	//이미지가 업로드되는 실제경로
	String realPath=getServletContext().getRealPath("/mypage/dogImg");
	System.out.println(realPath);
	
	int uploadSize = 1024*1024*5; //5mb
	MultipartRequest multi = null;
	
	try {
		multi = new MultipartRequest(request, realPath, uploadSize, "utf-8", new DefaultFileRenamePolicy());
		
		String idx = multi.getParameter("idx");
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
		dto.setIdx(idx);
		
		dogDao.updateDogProfile(dto);
		
		// 목록으로 이동
		response.sendRedirect("../index.jsp?main=mypage/dogMorePage.jsp");
		
		
	} catch(Exception e) {
		System.out.println("업로드오류" + e.getMessage());
	}
%>