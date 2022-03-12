<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<jsp:include page="template/adminpanel_header.jsp"></jsp:include>
<jsp:include page="template/adminsidebar.jsp"></jsp:include> 
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java"%>
<%@ include file="db.jsp" %>
<style>

.page-footer {
  position: absolute;
  right: 0;
  bottom: 0;
  left: 0;
  
  text-align: center;
}


.optdown{
	margin-top:12px;
}

</style>
<%	  
if((String)session.getAttribute("user")==null)
	response.sendRedirect("../login.jsp");
else{
	  String user = (String)session.getAttribute("user");
      String query = "select canteen_name from tbladmin where admin_name = '"+user+"'"; 
      Statement stmt = con.createStatement(); 
      ResultSet rs = stmt.executeQuery(query);
      rs.next();      
      rs = stmt.executeQuery("Select * from tbluser where fkcanteen_id = '"+rs.getString("canteen_name")+"'");
	      
%>
  <section id="content">

        <!--breadcrumbs start-->
        <div id="breadcrumbs-wrapper">
          <div class="container">
            <div class="row">
              <div class="col s12 m12 l12">
                <h5 class="breadcrumbs-title">Add Wallet Balance</h5>
              </div>
            </div>
          </div>
        </div>
        
        		  <div class="container">
          <p class="caption"></p>
          <div class="divider"></div>
		  
		 <div>
			 <form class="formValidate" id="formValidate1" method="post" action="" novalidate="novalidate">
            <div class="row">
              <div>
			<table>
                    <thead>
                      <tr>
                        <th data-field="id"></th>
                 
                      </tr>
                    </thead>

                    <tbody>
			
			
					<tr>
						<td>
					
            	
          
						<select name="userlist" class="optdown">							
        	        	    
        	        	     
        	        	      <option value="-1" disabled selected>Select User</option>
        	        	     <% while(rs.next()){%>
            	        	  <option value="<%= rs.getInt("pkuser_id") %>"><%= rs.getString("username") %></option>  
            	        	  <%}%>      
            	                  	        
                	    </select>
								
						</td>
					
					
					
						<td>
							<div class="input-field col s12">
							<label for=amount class="">Enter Amount</label>
							<input id="amount" name="amount" type="number" data-error=".errorTxt2">
							<div class="errorTxt2"></div>
						</td>
						<td>
							 <div class="input-field col s12">
                     			 <button class="btn cyan waves-effect waves-light " type="submit" name="submit" value="submit">Submit
                          			 
                     			</button>
        			         </div>
						</td>
					</tr>					
                    </tbody>
			  </table>
              </div>
            </div>
			</form>	
			
			<%
			if(request.getParameter("submit")!=null){
				int  optselect=Integer.parseInt(request.getParameter("userlist"));
				int amount=Integer.parseInt(request.getParameter("amount"));  
				//Statement stmt1 = con.createStatement(); 
				
				query="select balance from tbluser where pkuser_id="+optselect+"";
				ResultSet rs1=stmt.executeQuery(query);
				int balance=0;
				while(rs1.next()){
					 balance=rs1.getInt("balance");
				}
				int updated_balance=balance+amount;
				
			 	String q="update tbluser set balance="+updated_balance+" where pkuser_id="+optselect+"";
				int update=stmt.executeUpdate(q);
				
				if(update==1){
				
					out.print("<h6>Wallet balance updated successfully</h6>");
				
				} 
			}
			
			%>	

 	</section>
 	<%} %>
      <!-- END CONTENT -->
    </div>
   


<jsp:include page="template/footer.jsp"></jsp:include> 