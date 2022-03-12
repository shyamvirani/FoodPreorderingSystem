<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

	<%
		
		Class.forName("com.mysql.jdbc.Driver");
		Connection con=null;	
		if(application.getAttribute("con")==null){
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/fps", "root", "root");
			application.setAttribute("con", con);
		}else{
			con = (Connection)application.getAttribute("con");
		}
	%>