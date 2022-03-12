<%@page import="fps.DataRetrival"%>
<%@page import="fps.Order"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>

<jsp:include page="template/userpanel_header.jsp"></jsp:include>

<jsp:include page="template/usersidebar.jsp"></jsp:include>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<style>
html{font-size:14px;}
a:link{text-decoration: none;}
table.b
{
table-layout: fixed;
}
.page-footer {
		  position: relative;
		  right: 0;
		  bottom: 0;
		  left: 0;		  
		  text-align: center;
		}

</style>

<%@ include file="db.jsp" %>
		<div id="breadcrumbs-wrapper">
          <div class="container">
            <div class="row">
              <div class="col s12 m12 l12">
                <h5 class="breadcrumbs-title">All Order</h5>
              </div>
            </div>
          </div>
        </div>
        <!--breadcrumbs end-->



        <!--start container-->
         
        <div class="container">    
         <p class="caption">List of orders</p>
 
<%
if((String)session.getAttribute("user")==null)
	response.sendRedirect("../login.jsp");
else{
	String user = (String)session.getAttribute("user");
	Statement stmt = con.createStatement();
	String query = "select pkuser_id from tbluser where username = '"+user+"'";
	ResultSet rs = stmt.executeQuery(query);
	rs.next();	
	int i=0;
	query = "select * from tblorder where fkuser_id = "+rs.getInt("pkuser_id")+" order by pkorder_id desc" ;
	rs = stmt.executeQuery(query);
%>					
          <div class="divider"></div>
              <div class="divider"></div>
        
	<div class="panel-group" id="accordion">
			<%while(rs.next()){
				Order temp = (Order)DataRetrival.retival(con,rs);				
			%>
		    <div class="panel panel-default">
		    <a data-toggle="collapse" data-parent="#accordion" href="#collapse<%=++i %>"  style="color: black">
		     <div class="panel-heading" style="background-color:#e6e6e6">
		      
		       
		        <h4 class="panel-title">
		      	  <ul id="issues-collection" class="collection">
					
					<li class="collection-item avatar" >
                             <table class="b">
                             <tr>
                              <td style="width:20px;">
                              	<i class="mdi-content-content-paste red circle"></i>
                              </td>
                             	<td> 
                             		<p><strong>Order ID:</strong><%=rs.getString("pkorder_id") %></p>
                             	</td>
                              	<td class="temp">
                              		<p><strong>Date:</strong><%=rs.getString("dateTime").substring(0, 10) %> </p>
                              	</td>
                              </tr>
                              <tr>
                              <td></td>
                              <td>
                             	 <p><strong>Total:</strong><%=rs.getInt("total_price") %></p>
                             </td>
                             <td class="temp">
                             	  	 <p><strong>Payment Type:</strong><%=rs.getString("payment_type") %></p>
                             	
                             </td>
							  </tr>
							  <tr>
							  <td></td>
							  <td>	 <p><strong>Time:</strong><%=rs.getString("dateTime").substring(11, 19) %></p></td>
							  <td class="temp">					  
                              		<p><strong>Status:</strong><%=rs.getString("status") %></p>							  
							 	</td>
							 </tr>
                              </li> 
                     		</table>
		         </h4>
		        
	
		     
		      </div>
		      </a>
		      <div id="collapse<%=i %>" class="panel-collapse collapse ">
		       <div class="panel-body" >
		      <div>
              <div class="col s12 m4 l3">
                <h4 class="header">Order details</h4>
              </div>
              <div>
              	<li class="collection-item">
			        <table>
			       <tr> <th>
			        	Sr no.
			        </th>
			        <th>
			        	Item Name
			        </th>
			         <th>
			        	Quantity
			        </th>
			          <th>
			        	Price (Rs)
			        </th>
			 	 </tr>
			      
<%			
			String foodName[] = new String [temp.totalItem];
			Statement stmt2 = con.createStatement();
			for(int j=0;j<temp.refMenu.length;j++){				
				query = "select food_name from tblmenu where pkmenu = " + temp.refMenu[j] +" and fkcanteen_id = "+temp.canteenId;
				ResultSet rs2 = stmt2.executeQuery(query);
				rs2.next();
%>					  <tr>        
			        <td>
			              <strong> <%=j+1 %> </strong>
			        </td>
			        <td>
			        	<span><%=rs2.getString("food_name") %></span>
			        </td>
			        <td>
			        	
			                <strong><%=temp.quantity[j] %></strong> 
			          
			        </td>
			        <td>
			        	 
			              <span><%=temp.price[j]*temp.quantity[j] %></span>
			            
			        </td>
			        </tr>
			 <%} %>      
			        </table>
			       
			    </li>                  
              </div>
			  <div class="input-field col s12">
              
			  </div>
			  </div>
		        </div>
		      </div>		      
		    </div>
			<%}%>
		    
		    <div class="divider"></div>
		    <div class="divider"></div>
          
         
         </div>
                 
         <%} %>   
          </div>
       
        <!--end container-->

      
      <!-- END CONTENT -->
		

  </div>  
<jsp:include page="template/footer.jsp"></jsp:include>      