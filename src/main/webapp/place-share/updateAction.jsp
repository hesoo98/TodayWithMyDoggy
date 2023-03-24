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
		
		int uploadSize=1024*1024*10;
		
		multi=new MultipartRequest(request,realPath,uploadSize,"utf-8",new DefaultFileRenamePolicy());

		String num = multi.getParameter("num");
		String subject = multi.getParameter("subject");
		String content = multi.getParameter("content");
		String photoName = multi.getFilesystemName("photo1");
		String placeLa = multi.getParameter("la");
		String placeMa = multi.getParameter("ma");
		String mapAddr = multi.getParameter("mapAddr");

		PlaceShareBoardDto dto = new PlaceShareBoardDto();
		dto.setNum(num);
		dto.setSubject(subject);
		dto.setContent(content);
		if(photoName == null) {
			photoName = multi.getParameter("photo");
		}
		dto.setPhotoName(photoName);
		dto.setPlaceLa(placeLa);
		dto.setPlaceMa(placeMa);
		dto.setMapAddr(mapAddr);

		PlaceShareBoardDao dao = new PlaceShareBoardDao();
		dao.updateBoard(dto);
		
		response.sendRedirect("../index.jsp?main=place-share/boardList.jsp");

	} catch(Exception e) {
       response.sendRedirect("UploadFail.jsp");
	}
%>
<input type="hidden" name="la" value="" id="la">
				<input type="hidden" name="ma" value="" id="ma">
				<input type="hidden" name="mapAddr" value="" id="mapAddr">