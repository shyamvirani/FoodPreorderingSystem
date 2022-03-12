<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="db.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
		if(request.getParameter("action")!=null){
			int pkmenu = Integer.parseInt(request.getParameter("pkmenu"));
			String query = "update tblmenu set status = 1 where pkmenu = "+pkmenu;
			out.print(query);
 			Statement stmt = con.createStatement();
			int updated = stmt.executeUpdate(query);			
			response.sendRedirect("adminpanel.jsp"); 
		}
%>
</body>
</html>