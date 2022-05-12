<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>dbcpTest.jsp</title>
</head>
<body>
<table border="1">
<tr>
   <th>번호</th>
   <th>제목</th>
   <th>이름</th>
</tr>

<%
   Connection con=null;
   PreparedStatement ps=null;
   ResultSet rs=null;
   
   /* JNDI(java Naming Directory Interface)
   - XML과 같은 외부 자원을 통해 객체의 레퍼런스를 얻어오는 기법
   이미 올라온 객체를 이름을 통해 검색해서 찾아내는 것   */
   
   try{
      Context ctx=new InitialContext();
      Context envCtx= (Context)ctx.lookup("java:/comp/env");
      //=> WAS에 따라서 DataSource 등록하는 방법이 다르며,
      //WAS마다 커넥션 가져오는 방법이 다른데,
      //java:comp/env는 톰캣에서 사용하는 프로토콜이다.
      
      DataSource ds = (DataSource)envCtx.lookup("jdbc/oracledb");
      //=> DataSource - 톰캣이 구현한 커넥션풀 객체
      
      con=ds.getConnection();
      System.out.println("con="+con);   
      
      String sql="select * from reboard";
      ps=con.prepareStatement(sql);
      
      rs=ps.executeQuery();
      while(rs.next()){
         int no=rs.getInt("no");
         String title=rs.getString("title");
         String name=rs.getString("name"); %>
      
         <tr>
            <td><%=no %></td>
            <td><%=title %></td>
            <td><%=name %></td>
         </tr>   
   <%   }
   }catch(NamingException e){
      e.printStackTrace();
   }catch(SQLException e){
      e.printStackTrace();
   }finally{
      if(rs!=null)rs.close();
      if(ps!=null)ps.close();
      if(con!=null)con.close();
   }

%>

</body>
</html>