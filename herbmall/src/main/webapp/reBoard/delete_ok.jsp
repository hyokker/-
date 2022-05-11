<%@page import="com.herbmall.reboard.model.ReBoardVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.reboard.model.ReBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	//delete.jsp에서 post방식으로 이동
	//1
	request.setCharacterEncoding("utf-8");
	String no = request.getParameter("no");
	String pwd = request.getParameter("pwd");
	String groupNo= request.getParameter("groupNo");
	String step= request.getParameter("step");
	//2
	ReBoardDAO dao = new ReBoardDAO();
	ReBoardVO vo = new ReBoardVO();
	
	vo.setNo(Integer.parseInt(no));
	vo.setGroupNo(Integer.parseInt(groupNo));
	vo.setStep(Integer.parseInt(step));
	try {
		//[1] 비밀번호 체크
		if(dao.checkPwd(Integer.parseInt(no), pwd)){
		//[2] 삭제
		dao.deleteReBoard(vo);
		%>
		<script type="text/javascript">
			alert("삭제 성공");
			location.href = "list.jsp";
		</script>
	<% }else{ %>
		<script type="text/javascript">
			alert("비밀번호 불일치");
			history.back();
			</script>
	<%}//if
	} catch (SQLException e) {
		e.printStackTrace();
	}
	%>
</body>
</html>