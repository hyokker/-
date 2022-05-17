<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//로그인 체크 - 모든 페이지에 세션값이 없으면 알림창을 띄우고 로그인 페이지로 보낸다.
	String l_userid=(String)session.getAttribute("userid");
	if(l_userid==null || l_userid.isEmpty()){
		String ctxPath=request.getContextPath();
		String url = ctxPath+"/login/login.jsp";
	%>
		<script type="text/javascript">
			alert("먼저 로그인 하세요");
			location.href="<%=url%>";
		</script>
		<% return;
	}
	

%>