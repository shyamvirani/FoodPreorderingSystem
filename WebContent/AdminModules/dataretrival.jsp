<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="fps.*"%>
<%@ include file="db.jsp" %>


<%
	Order o = null;
	Statement stmt=con.createStatement();
	String q="select * from tblorder ";
	ResultSet rs=stmt.executeQuery(q);
	o=new Order();
	while(rs.next()){
		o.orderId = rs.getInt("pkorder_id");
		o.userId = rs.getInt("fkuser_id");
		o.canteenId = rs.getInt("fkcanteen_id");
		o.totalItem = rs.getInt("total_item");
		o.dateTime = rs.getString("dateTime");
		o.deliveryTime = rs.getString("delivery_time");
		o.refMenu = csvToArray(rs.getString("ref_menu"));
		o.status = rs.getString("status");
		o.quantity = csvToArray(rs.getString("quantity"));
		o.price = csvToArray(rs.getString("price"));
	}
	
	out.print(o.canteenId+"		"+o.dateTime+"		"+o.deliveryTime+"		"+o.orderId+"		"+o.status+"		"+o.totalItem+"		"+o.userId);
	for(int i=0;i<o.totalItem;i++){
		out.print(o.price[i]+"    "+o.quantity[i]+"     "+o.refMenu[i]);
	}
%>

<%!
	public static int [] csvToArray(String str){
		String str2 [] = str.split(",");
		int arr[] = new int [str2.length];
		for(int i=0;i<str2.length;i++){
			arr[i] = Integer.parseInt(str2[i]);
		}
		return arr;	
	}
%>
<%!
		public static String arrayToCsv(int arr[]){
			String str = "";
			for(int i=0;i<arr.length;i++){
				str = str + arr[i] +",";
			}
			return str;
		}
%>	

</body>
</html>