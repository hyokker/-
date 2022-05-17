<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main.jsp</title>
</head>	
<body>
	<h1> main</h1>
	<p>session id : <%=session.getId() %></p>
	<a href="setSession.jsp">setSession으로 </a>
</body>
</html>