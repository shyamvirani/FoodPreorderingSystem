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
				int index = Integer.parseInt(request.getParameter("index")); 
				out.print(index);
 				if(request.getParameter("modify")!=null){					
					 String menuId = "";
					while(index>0){
				    index--;
						if(Integer.parseInt(request.getParameter("status"+index))==0){
							menuId += request.getParameter("menuId["+index+"]") + ",";
						}
					} 					
					if(menuId.length()>0){
						menuId = menuId.substring(0, menuId.length()-1);
						String query = "update tblmenu set status = 0 where pkmenu in ("+menuId+");";
						Statement stmt = con.createStatement();
						out.print(query);
					    int updated = stmt.executeUpdate(query);
					}
				    response.sendRedirect("adminpanel.jsp");
				} 
%>	
</body>
</html>