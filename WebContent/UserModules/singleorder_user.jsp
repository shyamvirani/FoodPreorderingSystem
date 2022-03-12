<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@page import="fps.Order"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="fps.DataRetrival"%>
<%@ page buffer="100kb" autoFlush="false" %>

  <jsp:include page="template/userpanel_header.jsp"></jsp:include>
  <jsp:include page="template/usersidebar.jsp"></jsp:include>
   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
      
<%@ include file="db.jsp" %>  
<style>
.optdown{
	margin-top:12px;

}
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

<section id="content">

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

<%
if((String)session.getAttribute("user")==null)
	response.sendRedirect("../login.jsp");
else{
	String user = (String)session.getAttribute("user");
	Statement stmt = con.createStatement();
	String query = "select * from tbluser where username = '"+user+"'";
	ResultSet rs = stmt.executeQuery(query);
	rs.next();
	int i=0;
	String oid=request.getParameter("oid");
	
 	//query = "select * from tblorder where pkorder_id ="+q;
 	query =" select * from tbluser,tblorder where "+" tbluser.pkuser_id=tblorder.fkuser_id and pkorder_id="+oid;
	rs = stmt.executeQuery(query);		
	while(rs.next()){
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
        <!--start container-->
        <div class="container">
        <p class="caption">
      
        </p>

          
          <div class="divider"></div>
          
       <br>
          
          <!--editableTable-->
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
                              		<%-- <strong>Customer Name: </strong><%=rs.getString("username") %> --%>
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
								<strong>Status: </strong><%=rs.getString("status") %> 	
							  </td>
							 </tr>
							 	<tr>
							 	<td></td>
							 	
							 	<td>    
							 		 <p><strong>Payment Type: </strong> <%=rs.getString("payment_type") %></p> 	
							 	</td>
							
							 	
							 		<td><strong>Total items: </strong><%=count %>	</td>
							 		 <td><strong>Total Price: </strong><%=rs.getString("total_price") %></td>
							 </tr>
						
							 </table>
							 	<%} %>
                              </li> 
                              </li>
                              <li class="collection-item">
                           

							
							
							
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
		query="select * from tblorder where pkorder_id="+oid;
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
	                           <div class="col s2"><span><%=++srNo %></span> 
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
                                                <span><strong>Rs. <%=rs.getString("total_price") %></strong></span>
                                            </div>
                                            
                                      </div>
                                     
                                      </li>
                                      <li class="collection-item">
                                      <form method="post" action="">
                                  	<%if(rs.getString("status").equalsIgnoreCase("yet to be delivered") && !(rs.getString("status").equalsIgnoreCase("processing")) ){ %>
                                      
                                      	<button class="btn waves-effect waves-light right submit" type="submit" name="cancel">Cancel Order
                                   		 <i class="mdi-content-clear right"></i> 
										</button>
								<%}%>
										<label for="cname">Remark</label>	
									<input id="remark" name="remark" type="text" data-error=".errorTxt01" value="<%=rs.getString("remark") %>">
								<div class="errorTxt01">
								</div> </p>
									
								  <% }%>
							</form>
							
							
			<%
			if(request.getParameter("cancel")!=null){
				String	remark=request.getParameter("remark");
				//oid=request.getParameter("oid");			
				query="update tblorder set  remark='"+remark+"' " + ",status='cancelled by customer'  where pkorder_id="+oid;
				String q =" select * from tbluser,tblorder where "+" tbluser.pkuser_id=tblorder.fkuser_id and pkorder_id="+oid;
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
						response.sendRedirect("cancelledbycustomer_user.jsp");
						
					}
			
				
			}
}
			
			
			%>							
							
							
							
							
							
							
						</div>
					</li>	
				</ul>
                </div>
              </div>
            </div>
        </div>
        <!--end container-->

      </section>
      <!-- END CONTENT -->
    </div>
    <!-- END WRAPPER -->

  </div>
  <jsp:include page="template/footer.jsp"></jsp:include>