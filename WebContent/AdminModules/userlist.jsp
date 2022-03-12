<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@ page buffer="500kb" autoFlush="false" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 
 <jsp:include page="template/adminpanel_header.jsp"></jsp:include>
<jsp:include page="template/adminsidebar.jsp"></jsp:include> 
 <style type="text/css">
 
.page-footer {
  position: absolute;
  right: 0;
  bottom: 0;
  left: 0;
  
  text-align: center;
}


</style>
<script>
$(document).ready(function(){
	$.fn.dataTableExt.sErrMode = 'none';
});

</script>
<%@ include file="db.jsp" %>

 <section id="content">

        <!--breadcrumbs start-->
        <div id="breadcrumbs-wrapper">
          <div class="container">
            <div class="row">
              <div class="col s12 m12 l12">
                <h5 class="breadcrumbs-title">User List</h5>
              </div>
            </div>
          </div>
        </div>
        <!--breadcrumbs end-->


        <!--start container-->
        <div class="container">
          <p class="caption">Enable, Disable or Verify Users.</p>
          <div class="divider"></div>
          <!--editableTable-->

            <div class="row">
              <div class="col s12 m4 l3">
                <h4 class="header">List of users</h4>
              </div>
              <div>
		 <table id="data-table-admin" class="display" cellspacing="0" >
		                    <thead>
		                      <tr>
		                        <th data-field="Name">Name</th>
		                        <th data-field="Email">Email</th>
		                        <th data-field="Contact">Contact</th>
		                        <th data-field="Balance">Balance</th>	                                         					
		                      </tr>
		                    </thead>
		                    <tbody>
		<%		
		if((String)session.getAttribute("user")==null)
			response.sendRedirect("../login.jsp");
		else{
				String user = (String)session.getAttribute("user");
				Statement stmt = con.createStatement();
				String query = "select * from tbladmin where admin_name = '"+user+"'";
				ResultSet rs = stmt.executeQuery(query);
				rs.next();
			 	String canteenName = rs.getString("canteen_name");
				query = "select * from tbluser where fkcanteen_id = '"+canteenName+"'";
				rs = stmt.executeQuery(query);
				while(rs.next()){ 
		%>
	
						<tr>
							<td><%out.print(rs.getString("first_name")+" "+rs.getString("last_name")); %></td>
							<td><%=rs.getString("email") %></td>
							<td><%=rs.getString("phone_number") %></td>
							<td><%=rs.getString("balance") %></td>
		               </tr>
					
				<% }%>
				</tbody>
				
				
		</table>
		<% } %>
              </div>			  
            </div>
			
		 
            <div class="divider"></div>
            
          </div>
        </div>
        </div>
        <!--end container-->

      </section>
      <!-- END CONTENT -->
    </div>
    <!-- END WRAPPER -->

  </div>
  <!-- END MAIN -->

    <jsp:include page="template/footer.jsp"></jsp:include>