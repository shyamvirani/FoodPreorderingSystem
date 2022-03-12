<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="fps.Order"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="fps.DataRetrival"%>

<%@ include file="db.jsp" %>  

<jsp:include page="template/userpanel_header.jsp"></jsp:include>

<jsp:include page="template/usersidebar.jsp"></jsp:include>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<style>
html{font-size:14px;}
a:link{text-decoration: none;}
table.b{
table-layout: fixed;}
.page-footer {
		  position: absolute;
		  right: 0;
		  bottom: 0;
		  left: 0;		  
		  text-align: center;
		}

</style>

		<div id="breadcrumbs-wrapper">
          <div class="container">
            <div class="row">
              <div class="col s12 m12 l12">
                <h5 class="breadcrumbs-title"><b>Orders:</b> Delivered</h5>
              </div>
            </div>
          </div>
        </div>
        <!--breadcrumbs end-->



        <!--start container-->
        
       	<div class="container">
          <p class="caption">List of orders by customers with details</p>
          <div class="divider"></div>
       
       
       
       
<%
if((String)session.getAttribute("user")==null)
	response.sendRedirect("../login.jsp");
else{
	String user = (String)session.getAttribute("user");
	Statement stmt = con.createStatement(); 
	String query = "select pkuser_id from tbluser where username = '"+user+"'";
	ResultSet rs = stmt.executeQuery(query);
	rs.next();
	int userId = rs.getInt("pkuser_id");
	int i=0;
	query = "select * from tblorder where fkuser_id = "+userId+" and status = 'delivered' order by pkorder_id desc";
	rs = stmt.executeQuery(query);
%>
          
					
          <div class="divider"></div>
              <div class="divider"></div>
        
	<div class="panel-group" id="accordion">
			<%while(rs.next()){
				Order allorder = (Order)DataRetrival.retival(con, rs);
			%>		    <div class="panel panel-default">
		    <a data-toggle="collapse" data-parent="#accordion" href="#collapse<%=++i %>"  style="color: black">
		     <div class="panel-heading" style="background-color:#e6e6e6">
		      
		       
		        <h4 class="panel-title">
		      	  <ul id="issues-collection" class="collection">
					
					<li class="collection-item avatar" >
                             <table class="b" >
                             <tr>
                              <td style="width:30px">
                              	<i class="mdi-content-content-paste red circle"></i>
                              </td>
                             	<td> 
                             		<p><strong>OrderID:</strong><%=allorder.orderId %></p>
                             	</td>
                              	<td>
                              		<p><strong>UserID:</strong><%=allorder.userId %></p>
                              	</td>
                              </tr>
                              <tr>
                              <td></td>
                              <td>
                             	 <p><strong>Date:</strong><%=allorder.dateTime.substring(0,10) %></p>
                             </td>
                             <td>
                             	  	 <p><strong>Payment Type:</strong><%=allorder.paymentType %></p>
                             	
                             </td>
							  </tr>
							  <tr>
							  <td></td>
							  <td>	 <p><strong>Time:</strong><%=allorder.dateTime.substring(11,19) %></p></td>
							  <td>					  
                              		<p><strong>Delivery Time:</strong><%=allorder.deliveryTime %></p>							  
							 	</td>
							 </tr>
							  <tr>
							  <td></td>
							  <td>	 <p><strong>Total Price:</strong><%=allorder.totalPrice %></p></td>
							  <td>					  
                              		<p><strong>Total Items:</strong><%=allorder.quantity.length %></p>							  
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
 				<h4 class="header">Order details
                	<a class="btn cyan waves-effect waves-light right" href="singleorder_user.jsp?oid=<%=allorder.orderId %>">View More
                                <i class="mdi-content-send right"></i>
                              </a>
                
                
                </h4>             
               </div>
              <div class="divider"></div>
              <div> 
              	<li class="collection-item">
			        <table>
			        <th>
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
<%
			int srNo = 0;
			String foodName[] = new String [allorder.totalItem];
			Statement stmt2 = con.createStatement();
			for(int j=0;j<allorder.refMenu.length;j++){				
				query = "select food_name from tblmenu where pkmenu = " + allorder.refMenu[j] +" and fkcanteen_id = "+allorder.canteenId;
				ResultSet rs2 = stmt2.executeQuery(query);
				rs2.next();
%>			 	 
			        <tr>
			        
			        <td>
			              <strong><%=++srNo %> </strong>
			         
			        
			        </td>
			        <td>
			        	<span><%=rs2.getString("food_name") %></span>
			        </td>
			        <td>
			        	
			                <strong><%=allorder.quantity[j] %></strong>
			          
			        </td>
			        <td>
			        	 
			              <span><%=allorder.price[j]*allorder.quantity[j]%></span>
			            
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
    