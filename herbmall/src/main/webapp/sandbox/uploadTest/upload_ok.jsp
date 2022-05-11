<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>upload_ok.jsp</title>
</head>
<body>
	<%	
		//MultipartRequest 객체 생성 성공 => 업로드 완료
		//실패 = > IOException 발생(파일용량 초과 등)

		String upDir="pds_upload";//업로드할 폴더
		//업로드할 폴더의 절대경로 구하기
		String saveDir=application.getRealPath(upDir);
		System.out.println("saveDir="+saveDir);
		
		saveDir=config.getServletContext().getRealPath(upDir);
		System.out.println("saveDir="+saveDir);
		
		saveDir="C:\\Users\\EZEN\\git\\acadamy\\herbmall\\src\\main\\webapp\\pds_upload";
		int maxSize=2*1024*1024;//업로드 최대 용량
		String encoding="utf-8";
		
		//업로드시 동일한 파일명이 있을 경우 나중에 업로드한 파일에 번호를 붙여 이름 변경
		DefaultFileRenamePolicy policy=new DefaultFileRenamePolicy();
		
		MultipartRequest mr = new MultipartRequest(request, saveDir, maxSize, encoding, policy);
		
		out.print("업로드 완료!");
		
		//업로드된 파일 정복 얻어오기
		String fileName=mr.getFilesystemName("fileName"); //form 태그 input[name=file] 네임
	
		String originFileName=mr.getOriginalFileName("fileName"); //form 태그의 네임
		//=> 업로드된 파일명 원본
		
		File file=mr.getFile("fileName");
		long fileSize=file.length();
		
		String id=request.getParameter("id");
		String id2=mr.getParameter("id");
	%>
	<h1>업로드된 파일 정보</h1>
	<p>업로드된 파일명(변경 후) : <%=fileName %></p>
	<p>업로드된 파일명(변경 전) : <%=originFileName %></p>
	<p>업로드된 파일크기 : <%=fileSize %></p>
	
	<h1>파라미터</h1>
	<p>id(request) : <%=id %></p>
	<p>id2(mr) : <%=id2 %></p>
</body>
</html>