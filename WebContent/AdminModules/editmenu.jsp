<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@ page buffer="200kb" autoFlush="false" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<jsp:include page="template/adminpanel_header.jsp"></jsp:include>
<jsp:include page="template/adminsidebar.jsp"></jsp:include> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<style>
.optdown{
	margin-top:14px;
}
html{font-size:14px;}
a:link{text-decoration: none;}
a:link{color: black;}
a:hover{color: red;}
td{
	width:25%;
}

.page-footer {
		  position: absolute;
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
                <h5 class="breadcrumbs-title">Edit Menu</h5>
              </div>
            </div>
          </div>
        </div>
        <!--breadcrumbs end-->



        <!--start container-->
        
       	<div class="container">
          <p class="caption">Modify Menu Items</p>
          <div class="divider"></div>
	
          <div class="divider"></div>
          <div class="divider"></div>
    <%
    if((String)session.getAttribute("user")==null)
    	response.sendRedirect("../login.jsp");
    else{
    %>
    <form class="formValidate" id="formValidate" method="post" action="" novalidate="novalidate">
      <input type="submit" name="submit" class="btn waves-effect waves-light col s12 " style="margin-left:88%;" value="modify"/>	
      <%   

  
      String user = (String)session.getAttribute("user");
   
		Statement stmt = con.createStatement();
		int index=0;
		String query = "select pkcanteen_id from tbladmin where admin_name = '"+user+"'";
		ResultSet rs = stmt.executeQuery(query);
		rs.next();
		int canteenId = rs.getInt("pkcanteen_id");		
		query = "select distinct category from tblmenu where fkcanteen_id = "+canteenId;		
		rs = stmt.executeQuery(query);
		
	%>
      <div class="panel-group" id="accordion">
		    <%while(rs.next())
			{ %>
		    <div class="panel panel-default">
		    <a data-toggle="collapse" data-parent="#accordion" href="#collapse<%=index %>">
		     <div class="panel-heading" style="background-color:#f5f5f5">
		      
		       
		        <h4 class="panel-title" >
		       	<%=rs.getString("category") %>       
		         </h4>
		     
	
		     
		      </div>
		         <div class="divider"></div>
		      </a>
		      <div id="collapse<%=index %>" class="panel-collapse collapse ">
		        <div class="panel-body" >
		      <div>
              <div class="col s12 m4 l3">
                <h4 class="header">Edit items</h4>
              </div>
              <div>
                  <table id="" class="" cellspacing="0">
                    <thead>
                      <tr>
                        <th>Name</th>
                        <th>Price</th>
                        <th>Status</th>
                      </tr>
                    </thead>
<%
		String category = rs.getString("category");
		Statement stmt2 = con.createStatement();
	 	query = "select * from tblmenu where fkcanteen_id = "+canteenId+" and category = '"+category+"'";
		ResultSet rs2 =  stmt2.executeQuery(query);
		while(rs2.next()){ 
%>   
                    <tbody>
					
					<tr>
						<td>
							<div class="input-field col s12" style="margin-right: 20px">
								<label for="">Name</label>
									<input value="<%=rs2.getString("food_name") %>" id="_name" name="foodname<%=rs2.getInt("pkmenu") %>" type="text" data-error=".errorTxt">
									<div class="errorTxt"></div>
							</div>
						</td>
						<td>
							<div class="input-field col s12 " style="margin-right: 20px">
							<label for="_price">Price</label>
								<input value="<%=rs2.getInt("price") %>" id="_price" name="price<%=rs2.getInt("pkmenu") %>" type="number" data-error=".errorTxt">
								<div class="errorTxt"></div>
							</div>
						</td>                      
						<td>
							<select name="status<%=rs2.getInt("pkmenu") %>" class="optdown">
						<% if(rs2.getInt("status")==1){ %>
        	        	      <option value="1" selected>Available</option>
            	        	  <option value="0">Not Available</option>
            	        		<%}else{ %>
        	        	      <option value="1">Available</option>
            	        	  <option value="0" selected>Not Available</option>
            	        		<%} %>
                	    </select>
						</td>
					</tr>
					<%} %>	
                    </tbody>
			</table>
				
              </div>
			
			  </div>
		        </div>
		      </div>
		    </div>
		    <div class="divider"></div>
		    <div class="divider"></div>
          
          
          <%index++;} %>	
			 
          <div>
          
          
          </div>
         
           </form>
         <%
		if(request.getParameter("submit")!=null){
			Statement stmt2 = con.createStatement();
			query = "select pkmenu from tblmenu where fkcanteen_id = "+canteenId;
			rs = stmt.executeQuery(query);
			int updated=0;
			while(rs.next()){
				int i = rs.getInt("pkmenu");
				String foodName = request.getParameter("foodname"+i);
				String price = request.getParameter("price"+i);
				String status = request.getParameter("status"+i);
				query = "update tblmenu set food_name = '"+foodName+"', price = "+price+", status = "+status+" where pkmenu = "+i ;
				 updated = stmt2.executeUpdate(query);
				
			}
			if(updated==1){
				response.sendRedirect("editmenu.jsp");
			}

		}
    	}
%>		  	
            
          </div>
       
        <!--end container-->

      
      <!-- END CONTENT -->


  </div>     
	 </div>
<jsp:include page="template/footer.jsp"></jsp:include> 
