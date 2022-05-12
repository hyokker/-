<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>result4.jsp</title>
</head>
<body>
<jsp:useBean id="cvo" class="com.herbmall.test.CounterVO" scope="application"></jsp:useBean>
<h1>result4.jsp 페이지</h1>
count - <jsp:getProperty property="count" name="cvo"/>
<hr>
<a href="scope4.jsp">scope4.jsp 이동</a>

<hr>
<p>session id : <%=session.getId() %></p>
</body>
</html>