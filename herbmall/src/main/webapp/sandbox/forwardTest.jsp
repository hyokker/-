<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>forwardTest.jsp</title>
</head>
<body>
	<h1>forward액션 태그 연습</h1>
	<form name="frm1" method="post" action="forwardTest_ok.jsp">
		이름 : <input type="text" name="name"><br>
		주소 : <input type="text" name="address"><br>
		<br> <input type="submit" value="전송">
	</form>
</body>
</html>