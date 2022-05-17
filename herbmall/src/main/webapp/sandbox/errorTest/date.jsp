<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page errorPage="error.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>errorTest/date.jsp</title>
</head>
<body>
<%
	Date date= new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String str = sdf.format(date);
%>
<h1>error 처리 연습</h1>
<p>현재 일자 : <%=st%></p> <!-- 고의로 에러 발생 -->
</body>
</html>