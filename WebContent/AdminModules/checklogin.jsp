<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
		String userlogin = (String)session.getAttribute("user");
		if(userlogin==null)
			response.sendRedirect("login.jsp");
		else
			out.print("not null");
%>
</body>
</html>