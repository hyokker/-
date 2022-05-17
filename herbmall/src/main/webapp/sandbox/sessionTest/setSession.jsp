<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>setSession.jsp</title>
</head>
<body>
<%
	//Session => 사용자의 정보를 저장하는 방볍 ==> 웹서버에  저장됨
	String id ="hong";
	String pwd ="1234";
	
	session.setAttribute("id", id); //name value쌍으로 넣는다
	session.setAttribute("pwd", pwd);
%>
<p>세션에 정보가 저잠됨</p>
<a href="useSession.jsp">세션에 정보 읽어오기</a>
<hr>
<p>session id : <%=session.getId() %></p>
</body>
</html>