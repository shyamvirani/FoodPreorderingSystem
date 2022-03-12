<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<%

if((String)session.getAttribute("user")!=null){
	session.removeAttribute("user");
	response.sendRedirect("login.jsp");
}
%>
</head>
<body>

</body>
</html>