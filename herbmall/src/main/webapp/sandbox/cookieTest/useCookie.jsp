<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>useCookie.jsp</title>
</head>
<body>
<%
	//생성한 쿠키 정보 읽어오기
	String id="", age="";
	Cookie[] ckArr= request.getCookies();
	
	if(ckArr!=null){
		for(int i=0;i<ckArr.length;i++){
			if(ckArr[i].getName().equals("id")){
				id=ckArr[i].getValue();
			}
			if(ckArr[i].getName().equals("age")){
				age=ckArr[i].getValue();
			}
		}
	}
	
	//쿠키의 유지 시간이 120초 => 120초가 지난 후에 useCookie.jsp 를 재실행 하면 
	//쿠키값을 가져오지 못함		
	
%>

<h1>쿠키 정보</h1>
<p> 쿠키 이름 : id, 쿠키값 : <%=id %></p>
<p> 쿠키 이름 : age, 쿠키값 : <%=age %></p>
</body>
</html>