<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>forwardTest_ok.jsp</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
	
		request.setAttribute("fruit", "사과");
		//b.jsp로 포워드
	%>
	<h1>forwardTest_ok.jsp 페이지</h1>
	<jsp:forward page="b.jsp">
		<jsp:param value="축구" name="hobby"/>
	</jsp:forward>
</body>
</html>