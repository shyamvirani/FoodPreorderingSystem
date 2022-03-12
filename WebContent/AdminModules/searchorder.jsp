<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="fps.DataRetrival"%>
<%@page import="fps.Order"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>


 
<%@ include file="db.jsp" %>    
 
  <jsp:include page="template/adminpanel_header.jsp"></jsp:include>
  <jsp:include page="template/adminsidebar.jsp"></jsp:include>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
  <style>
		html{font-size:14px;}
		a:link{text-decoration: none;}
		table.b{
		table-layout: fixed;}
		.optdown{
		margin-top:12px;}
		.page-footer {
		  position: fixed;
		  right: 0;
		  bottom: 0;
		  left: 0;		  
		  text-align: center;
		}
</style> 

<section id="content">
<%
if((String)session.getAttribute("user")==null)
	response.sendRedirect("../login.jsp");
else{
	String user = (String)session.getAttribute("user");
	Statement stmt = con.createStatement();
	

%>
        <!--breadcrumbs start-->
        <div id="breadcrumbs-wrapper">
          <div class="container">
            <div class="row">
              <div class="col s12 m12 l12">
                <h5 class="breadcrumbs-title">Order details</h5>
              </div>
            </div>
          </div>
        </div>
        <!--breadcrumbs end-->


        <!--start container-->
        <div class="container">
                <p class="caption">
         <form class="formValidate" id="formValidate1" method="post" action="" novalidate="novalidate">
            <div class="row">
              <div>
			<table>
                    <thead>
                      <div class="divider"></div>
                    </thead>

                    <tbody>
					<tr>
						<td>
						<select name="sortlist" class="optdown">							  
        	        	     <option value="-1" disabled selected>Search by</option>
            	        	  <option value="orderid">Order ID</option>  
            	        	  <option value="username">User Name</option>         	        
                	    </select>
								
						</td>
						<td>
							<div class="input-field col s12">
							<label for=value class="">Enter Value</label>
							<input id="value" name="value" type="text" data-error=".errorTxt2">
							<div class="errorTxt2"></div>
						</td>
						<td>
							 <div class="input-field col s12">
                     			 <!-- <a href="singleorder.jsp?q=3">
  -->                    			 <button class="btn cyan waves-effect waves-light " type="submit" name="submit" value="submit">Submit		 
                     			</button></a>
        			         </div>
						</td>
					</tr>					
                    </tbody>
			  </table>
              </div>
            </div>
			</form>	
        </p>
		
          <p class="caption"></p>
          <div class="divider"></div>
          <!--editableTable-->
<%
//request.getParameter("orderId")!=null || request.getParameter("username")!=null
	if(request.getParameter("submit")!=null){
			String sortingPara=request.getParameter("sortlist");
			String query="";
			ResultSet rs;
			String v=request.getParameter("value");
			char c=v.charAt(0);
			if(Character.isDigit(c) && sortingPara.equalsIgnoreCase("orderid")){
			 	query =" select * from tblorder,tbluser where "+" tbluser.pkuser_id=tblorder.fkuser_id and pkorder_id="+v;
				 rs=stmt.executeQuery(query);
				if(rs.next()){
					String items=rs.getString("ref_menu");
					int count=0;
					//out.println(items);
					char itemCount[]=items.toCharArray();
					for(int j=0;j<itemCount.length;j++){
						
						if(itemCount[j]==','){
							count++;
						}
					}
				
				%>
		<div id="work-collections" class="seaction">
	             
		<div class="row">
            <div>
                <h4 class="header"></h4>
                <ul id="issues-collection" class="collection">
                	<li class="collection-item avatar">
                          
                          <table class="b" >
                         <tr>
                          <td style="width:30px;height:5px">
                          	<i class="mdi-content-content-paste red circle"></i>
                          </td>
                         	<td> 
                         		<strong>OrderID: </strong><%=rs.getString("pkorder_id") %>
                         	</td>
                         
                          	<td>
                          	</td>
                          	<td>
                         		
                       		 </td>
                          </tr>
                          <tr>
                          <td></td>                       
                          <td>
                          <strong>Customer Name: </strong><%=rs.getString("username") %>
                          	
                          </td>
                          <td>	
                          <strong>Email: </strong><%=rs.getString("email") %>
                          </td>
                          <td>	
                          	<strong>Contact:  </strong><%=rs.getString("phone_number") %>							  
						  </td>
						  
						  </tr>
						  <tr>
						  <td></td>
						  <td>	
						  <strong>Date: </strong><%=rs.getString("dateTime") %>
						  
						  </td>
						  <td>					  
						 	<p><strong>Delivery Time: </strong><%=rs.getString("delivery_time")%><!-- '.($status=='Paused' ? 'Paused --><!--  paused <a  data-position="bottom" data-delay="50" data-tooltip="Please contact administrator for further details." class="btn-floating waves-effect waves-light tooltipped cyan">    </a>--></p>							  
		  
						  </td>
						  <td>
							<strong>Status: </strong><%=rs.getString("status")%>	
						  </td>
						 </tr>
						 	<tr>
						 	<td></td>
						 	
						 	<td>    
							 		 <p><strong>Payment Type: </strong><%=rs.getString("payment_type") %> </p> 	
						 	</td>
						
						 	
						 		<td><strong>Total items: </strong><%=count %>	</td>
						 		 <td><strong>Total Price: </strong><%=rs.getString("total_price") %></td>
						 </tr>
					
						 </table>
						 
                          </li> 
                            </li>

		
                        <li class="collection-item">
                        	<div class="row">
	                        	<div class="col s2">                     
	                        		<p class="collections-title"><strong>SrNo.</strong> </p>
	                        	</div>
	                        	<div class="col s3">
		                        <strong>Item Name</strong>
		                        </div>
		                        <div class="col s3">
		                        <strong>Quantity</strong>
		                        </div>
		                        <div class="col s2">
		                        <strong>Price</strong>
		                        </div>
		                        <div class="col s2">
		                        <strong>Total Price(Rs.)</strong>
		                        </div>
	                        </div>
	                        </li>
  							</li>
	                          <%	
		query="select * from tblorder where pkorder_id="+v;
		rs=stmt.executeQuery(query);
		while(rs.next()){
			Order singleOrder = (Order)DataRetrival.retival(con, rs);
			int srNo = 0;
			String foodName[] = new String [singleOrder.totalItem];
			Statement stmt2 = con.createStatement();
			for(int j=0;j<singleOrder.refMenu.length;j++){				
				query = "select food_name from tblmenu where pkmenu = " + singleOrder.refMenu[j] +" and fkcanteen_id = "+singleOrder.canteenId;
				ResultSet rs2 = stmt2.executeQuery(query);
				rs2.next();
	        	//out.println(rs2.getString("food_name"));
%>
                        <li class="collection-item">
                        <div class="row">
                        <div class="col s2">
                        	<span><%=++srNo %></span> 
                        </div>
                        <div class="col s3">
                        	<span><%=rs2.getString("food_name") %></span>
                        </div>
                        <div class="col s3">
                        <span><%=singleOrder.quantity[j] %></span>
                        </div>
                        
                        <div class="col s2">
                        <span><%=singleOrder.price[j]%>  </span>
                        </div>
                        <div class="col s2">
                        <span><%=singleOrder.price[j]*singleOrder.quantity[j]%>  </span>
                        </div>
                        </div>
                        </li>
                        <li class="collection-item">
                                 <div class="row">
                                     <div class="col s7">
                                      <%} %>
                                            <p class="collections-title"> Total</p>
                                        </div>
                                        <div class="col s2">
										<span> </span>
                                        </div>
                                        <div class="col s3">
                                            <span><strong>Rs. </strong><%=rs.getString("total_price") %></span>
                                        </div>
                                        
                                  </div>

                                  </li>
                                  <li class="collection-item">
                                  <form method="post" action="changestatus.jsp">
                                  	<input type="hidden" value="<%=singleOrder.orderId %>" name="oid">
                                  	<%if(rs.getString("status").equalsIgnoreCase("yet to be delivered")){ %>
                                  	<button class="btn waves-effect waves-light right submit" type="submit" name="cancel">Cancel Order
                               		 <i class="mdi-content-clear right"></i> 
									</button>
									<%} 
									if(rs.getString("status").equalsIgnoreCase("processing")){ %>
		
									<button class="btn waves-effect waves-light right submit" type="submit" name="deliver">Delivered
                               		 <i class="mdi-action-done-all right"></i> 
									</button>
								<%} %>
									<label for="cname">Remark</label>	
								<input id="remark" name="remark" type="text" data-error=".errorTxt01" value="<%=rs.getString("remark") %>">
							<div class="errorTxt01">
							</div> </p>
							
						</form>						
		<%
		
		} %>	
		
		
					</div>
				</li>	
			</ul>
            </div>
          </div>
			<% 
				}}
			else{
				int i=0;
				query =" select * from tblorder,tbluser where "+" tbluser.pkuser_id=tblorder.fkuser_id and username= '"+v+"'";
			 	rs=stmt.executeQuery(query);
			 %>	
	        
	<div class="panel-group" id="accordion">
			<%while(rs.next()){
				Order allorder = (Order)DataRetrival.retival(con, rs);
			%>		    <div class="panel ">
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
                	<a class="btn cyan waves-effect waves-light right" href="singleorder.jsp?oid=<%=allorder.orderId %>">View More
                                <i class="mdi-content-send right"></i>
                              </a>
                
                
                </h4>              </div>
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
			
			
			
			 	
		<%	}	
	%>

          

        </div>
        <!--end container-->
<%}}
%>
      </section>
      <!-- END CONTENT -->
    </div>
    <!-- END WRAPPER -->

  </div>
  <jsp:include page="template/footer.jsp"></jsp:include>