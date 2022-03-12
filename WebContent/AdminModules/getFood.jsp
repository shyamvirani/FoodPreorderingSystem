<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java"%>
<%@ include file="db.jsp" %>

<%	  
      int pkmenu=Integer.parseInt(request.getParameter("category_list"));  
      Statement stmt = con.createStatement(); 
      String query = "select category,fkcanteen_id from tblmenu where pkmenu = "+pkmenu+"";    		  
      ResultSet rs = stmt.executeQuery(query);
      rs.next();
      query = "select food_name,pkmenu from tblmenu where status = 0 and category = '"+rs.getString("category")+"' and fkcanteen_id = "+rs.getInt("fkcanteen_id")+"";
	  rs = stmt.executeQuery(query);
      while(rs.next()){
            	out.print("<option value='"+rs.getString("pkmenu")+"'>"+rs.getString("food_name")+"</option>"); 
            }
%>
