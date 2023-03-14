<%@page import="member.MemberDto"%>
<%@page import="member.MemberDao"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	//아직 수정중.
	//db에 저장할 member_num가져오기
	String myid = (String)session.getAttribute("myid");
	MemberDao dao = new MemberDao();
	
	//이미지가 업로드되는 실제경로
	String realPath=getServletContext().getRealPath("/mypage/dogImg");
	System.out.println(realPath);
	
	int uploadSize = 1024*1024*5; //5mb
	MultipartRequest multi = null;
	
	try {
		multi = new MultipartRequest(request, realPath, uploadSize, "utf-8", new DefaultFileRenamePolicy());
		
		String content = multi.getParameter("content");
		String photoname = multi.getFilesystemName("photo");

		/*
		//dto에 저장
		GuestDto dto = new GuestDto();
		dto.setMyid(myid);
		dto.setContent(content);
		dto.setPhotoname(photoname);
		
		//dao선언
		GuestDao dao = new GuestDao();
		dao.insertGuest(dto);
		
		//방명록 목록으로 이동
		response.sendRedirect("../index.jsp?main=guest/guestlist.jsp");
		*/
		
	} catch(Exception e) {
		System.out.println("업로드오류" + e.getMessage());
	}
%>