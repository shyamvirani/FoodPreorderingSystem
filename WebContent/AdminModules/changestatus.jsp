<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ include file="db.jsp" %>
    <%@page import="fps.Order"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="fps.DataRetrival"%>  
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
String remark="";
String oid="";
String query="";
remark=request.getParameter("remark");
oid=request.getParameter("oid");
out.println(oid);
if(request.getParameter("cancel")!=null){	
	
	query="update tblorder set  remark='"+remark+"' " + ",status='cancelled by admin'  where pkorder_id="+oid;
	String q =" select * from tbluser,tblorder where "+" tbluser.pkuser_id=tblorder.fkuser_id and pkorder_id="+oid;

	Statement stmt = con.createStatement();	
	ResultSet rs1=stmt.executeQuery(q);
	int r1 = 0;
	int r2 = 0;
	int uid = 0;
	int balance = 0;
	int uBalance = 0;
	if(rs1.next()){
		uid = rs1.getInt("pkuser_id");
		balance = rs1.getInt("balance");
		uBalance=balance + rs1.getInt("total_price");
	}
	String updateBalance="update tbluser set balance="+ uBalance +" where pkuser_id="+uid;
	r1 = stmt.executeUpdate(updateBalance);
	r2 = stmt.executeUpdate(query);
	 
		if(r1==1 && r2==1){
			response.sendRedirect("cancelledbyadmin.jsp");
			
		}
	}

	else if(request.getParameter("deliver")!=null){
		
		query="update tblorder set  remark='"+remark+"' " + ",status='delivered'  where pkorder_id="+oid;
		Statement stmt = con.createStatement();	
		int r=stmt.executeUpdate(query);
			if(r==1){
				response.sendRedirect("delivered_admin.jsp");
			}
			
	}
	else if(request.getParameter("processing")!=null){
		
		query="update tblorder set  remark='"+remark+"' " + ",status='processing'  where pkorder_id="+oid;
		Statement stmt = con.createStatement();	
		int r=stmt.executeUpdate(query);
			if(r==1){				
				response.sendRedirect("searchorder.jsp");
			}
			
	}



%>
</body>
</html>