<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.Array"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>

<%@include file="db.jsp"%>
<% if((String)session.getAttribute("user")==null)
	response.sendRedirect("../login.jsp");
else{
	if(request.getParameter("modify")!=null){
		String user = (String)session.getAttribute("user");
		Statement stmt = con.createStatement();
		String query = "select pkcanteen_id from tbladmin where admin_name = '"+user+"'";
		ResultSet rs = stmt.executeQuery(query);
		rs.next();
		int canteenId = rs.getInt("pkcanteen_id");
		Statement stmt1 = con.createStatement();
		String q="select count(*) from tblmenu where status=1 and fkcanteen_id = "+canteenId+"";
		String q1="select pkmenu from tblmenu where status=1 and fkcanteen_id = "+canteenId+"";
		int n=0;
		int n1=0;	
		rs=stmt.executeQuery(q);
		
		
		String countRow="";
		while(rs.next()){
			countRow = rs.getString(1);
		}
		
		n=Integer.parseInt(countRow);
		out.println(n);
		ResultSet rs1=stmt.executeQuery(q1);
			String s=" ";
			while(rs1.next()){

				s = rs1.getString(1);
				 n1=Integer.parseInt(s);
				
			
		
		for(int i=1;i<n+1;i++){
				
				 String x=request.getParameter(n1+"_hide");
				 out.print(x);
				 if(x.equals("1")){
				 	query="update tblmenu set status=1 where pkmenu="+n1+"";
				 	int execute1=stmt1.executeUpdate(query);
				 }
				 else{
					 String query2="update tblmenu set status=0 where pkmenu="+n1+"";
					 int execute2=stmt1.executeUpdate(query2);
				 }
				}
			
			}

			response.sendRedirect("1568484422574_test.jsp");
		}}
	%>