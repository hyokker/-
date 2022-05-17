<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>useSession.jsp</title>
</head>
<body>
<%

	String id =(String)session.getAttribute("id");
	String pwd =(String)session.getAttribute("pwd");
	int interval=session.getMaxInactiveInterval();//세션 유지 시간 기본 -30분 (1800초)

%>

<h1>세션 정보</h1>
<p>id : <%=id %></p>
<p>pwd : <%=pwd %></p>
<p>세션 유지시간 : <%=interval %>초</p>

<hr>
<p session id : <%=session.getId() %>>
<a href="logout.jsp">logout</a>
</body>
</html>