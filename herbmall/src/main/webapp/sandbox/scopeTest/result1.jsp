<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>result1.jsp</title>
</head>
<body>
<jsp:useBean id="cvo" class="com.herbmall.test.CounterVO" scope="page"></jsp:useBean>
<h1>result1.jsp</h1>
count - <jsp:getProperty property="count" name="cvo"/>
<hr>
<a href="scope1.jsp">scope1.jsp 로 이동</a>
</body>
</html>