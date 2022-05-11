<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="com.herbmall.common.Utility"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.reboard.model.ReBoardDAO"%>
<%@page import="com.herbmall.reboard.model.ReBoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>downCount.jsp</title>
</head>
<body>
<%
	//detail.jsp 에서 파일 이름 클릭하여 get방식으로 이동
	//=>http://localhost:9090/herbmall/pds/downCount.jsp?no=5&fileName=B01.pdf
	//[1]다운로드 수 증가
	//1
	String no = request.getParameter("no");
	String fileName = request.getParameter("fileName");
	String originalFileName=request.getParameter("originalFileName");
	
	//2
	ReBoardDAO dao = new ReBoardDAO();
	
	BufferedInputStream bis =null;
	BufferedOutputStream bos=null;
	try{
		int cnt=dao.updateDownCount(Integer.parseInt(no));
		
		//3
		//[2]파일 다운로드 처리
		//page의 설정을 바꾸기 위해서 response를 다 날려버림
		response.reset();
		
		//setContentType은 MIME 타입을 지정-octet-stream으로 지정시,
		//형식을 지정하지 않겠다는 것
		response.setContentType("application/octet-stream");
		
		//브라우저 파일 확장자를 포함하여 모든 확장자의 파일들에 대해 다운로드시 무조건
		//파일 다운로드 대화상자가 뜨도록 하는 헤더속성
		response.setHeader("Content-Disposition", "attachment;filename="
			+ new String(originalFileName.getBytes("euc-kr"), "ISO-8859-1"));
		//url 전송시 ISO-8859-1 로 인코딩되므로 한글 처리 위해 인코딩
		
		out.clear();
		out=pageContext.pushBody();
		/*=> 이를 생략하면 프로그램 상엔 이상이 없으나 이미 존재하고 있는
		out객체로 바이트 기반의 스트림 작업을 명시하면서 오류가 발생함*/
		
		String path=application.getRealPath(Utility.UPLOAD_PATH);
		path=Utility.TEST_PATH;
		File file=new File(path,fileName);
		
		byte[] data=new byte[1024*1024];
		bis=new BufferedInputStream(new FileInputStream(file));
		
		bos = new BufferedOutputStream(response.getOutputStream());
		
		int count=0;
		while((count=bis.read(data))!=-1){
			bos.write(data);
		}
	}catch(SQLException e){
		e.printStackTrace();
	}catch(Exception e ){
		e.printStackTrace();
	}finally{
		if(bis!=null)bis.close();
		if(bos!=null)bos.close();
		
	}
	
	
	

%>
</body>
</html>