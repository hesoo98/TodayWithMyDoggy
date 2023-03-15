<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.Catch"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="board.placeShare.PlaceShareBoardDto"%>
<%@page import="member.MemberDao"%>
<%@page import="com.mysql.cj.Session"%>
<%@page import="board.placeShare.PlaceShareBoardDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%

	request.setCharacterEncoding("utf-8");
	
	MultipartRequest multi = null;
	
	//이미지 저장 실제경로(저장 디렉토리, 절대 경로)
	String realPath = getServletContext().getRealPath("place-share/place-photo");
	System.out.print(realPath);
	
	try {
		
		int uploadSize=1024*1024*5;
		
		multi=new MultipartRequest(request,realPath,uploadSize,"utf-8",new DefaultFileRenamePolicy());

		MemberDao memberDao = new MemberDao();
		PlaceShareBoardDao dao = new PlaceShareBoardDao();
		String myid = (String)session.getAttribute("myid");
		String nickname = memberDao.getNickname(myid);
		
		String subject = multi.getParameter("subject");
		String content = multi.getParameter("content");
		String photoName = multi.getFilesystemName("photo1");	
		String titlePhotoName = multi.getParameter("titlePhoto");
		String placeLa = multi.getParameter("latitude");
		String placeMa = multi.getParameter("longitude");
		String placeName = multi.getParameter("placeName");
		
		PlaceShareBoardDto dto = new PlaceShareBoardDto();
		dto.setNickname(nickname);
		dto.setSubject(subject);
		dto.setContent(content);
		dto.setPhotoName(photoName);
		dto.setTitlePhotoName(titlePhotoName);
		
		dao.insertBoard(dto);
		
		response.sendRedirect("../index.jsp?main=place-share/datail.jsp");

	} catch(Exception e) {
       response.sendRedirect("UploadFail.jsp");
	}
%>