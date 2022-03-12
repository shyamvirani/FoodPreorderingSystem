<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ include file="db.jsp" %>
<jsp:include page="template/userpanel_header.jsp"></jsp:include>
<jsp:include page="template/usersidebar.jsp"></jsp:include>

<style>
.mdi-maps-restaurant-menu{margin-left: 0px;}
.select-wrapper input.select-dropdown {margin: 0px 0px 0px 44px;width:96%}
</style>

<%
if((String)session.getAttribute("user")==null)
	response.sendRedirect("../login.jsp");
else{
	String user = session.getAttribute("user").toString();
	Statement stmt = con.createStatement();
	String query = "select * from tbluser where username = '"+user+"'";
	ResultSet rs = stmt.executeQuery(query);
	rs.next();
%>

      <section id="content">

        <!--breadcrumbs start-->
        <div id="breadcrumbs-wrapper">
          <div class="container">
            <div class="row">
              <div class="col s12 m12 l12">
                <h5 class="breadcrumbs-title">User Details</h5>
              </div>
            </div>
          </div>
        </div>
        <!--breadcrumbs end-->


        <!--start container-->
        <div class="container">
          <p class="caption">Edit your details here which are required for delivery and contact.</p>
          <div class="divider"></div>
            <div class="row">
              <div class="col s12 m4 l3">
                <h4 class="header">Details</h4>
              </div>
<div>
                <div class="card-panel">
                  <div class="row">
                    <form class="formValidate" id="formValidate" method="post" action="" novalidate="novalidate"class="col s12">
                      <div class="row">
                        <div class="input-field col s12">
                          <i class="mdi-social-person-outline prefix"></i>
                          <input name="firstname" id="firstname" type="text" value="<%= rs.getString("first_name") %>" data-error=".errorTxt1">
                          <label for="firstname" class="">First Name</label>
						  <div class="errorTxt1"></div>
                        </div>
                      </div>					
					  
					  <div class="row">
                        <div class="input-field col s12">
                          <i class="mdi-social-person-outline prefix"></i>
                          <input name="lastname" id="lastname" type="text" value="<%= rs.getString("last_name") %>" data-error=".errorTxt1">
                          <label for="lastname" class="">Last Name</label>
						  <div class="errorTxt1"></div>
                        </div>
                      </div>
                                        
                      <div class="row">
                        <div class="input-field col s12">
                          <i class="mdi-communication-email prefix"></i>
                          <input name="email" id="email" type="email" value="<%= rs.getString("email") %>" data-error=".errorTxt3">
                          <label for="email" class="">Email</label>
						  <div class="errorTxt3"></div>
                        </div>
                      </div>
                      <div class="row">
                        <div class="input-field col s12">
                          <i class="mdi-action-account-circle prefix"></i>
                          <input name="phone" id="phone" type="number" value="<%= rs.getString("phone_number") %>" data-error=".errorTxt5">
                          <label for="phone" class="">Contact</label>
						  <div class="errorTxt5"></div>
                        </div>
                      </div>					  
                      <div class="row">
                      	<div class="row margin">
				          <div class="input-field col s12">
				          <i class="mdi-maps-restaurant-menu prefix"></i>
				            <select class="optright" name="canteenname">
				            	<option value="<%= rs.getString("fkcanteen_id") %>" selected><%= rs.getString("fkcanteen_id") %></option>
				        <%  				        		
				        		String currentCanteen = rs.getString("fkcanteen_id");
				            	rs = stmt.executeQuery("select canteen_name from tbladmin");
				        
							 	while(rs.next()){
									if(!(rs.getString("canteen_name").equals(currentCanteen))){
										out.print("<option value='"+rs.getString("canteen_name")+"'>");
										out.print(rs.getString("canteen_name"));
										out.print("</option>");
									}
				            	} 
							
				        %>    	
				            </select>
				           
							<div class="errorTxt4"></div>			
				          </div>
				        </div>
                    <!--     <div class="input-field col s12">
                          <i class="mdi-maps-restaurant-menu prefix"></i>
                          <textarea name="address" id="address" class="materialize-textarea validate" data-error=".errorTxt6"></textarea>
                          <label for="address" class="">Canteen</label>
						  <div class="errorTxt6"></div>
                        </div>		-->
                        <div class="row">
                          <div class="input-field col s12">
                            <input class="btn cyan waves-effect waves-light right" class="mdi-content-send right" 
                            	type="submit" name="submit" value="Submit">
                                         
                          </div>
                        </div>
                      </div>
                    </form>
                  </div>
                </div>
              </div>
            <div class="divider"></div>
            
            <%
  
            if(request.getParameter("submit")!=null){
        		if(!request.getParameter("firstname").isEmpty() && !request.getParameter("lastname").isEmpty() && 
        				!request.getParameter("password").isEmpty() && !request.getParameter("phone").isEmpty() && 
        				!request.getParameter("email").isEmpty() && !request.getParameter("canteenname").isEmpty()){        		
        			
        			boolean error=false;
        			if(request.getParameter("phone").length()!=10){
        				out.print("<center><font color='red'>Length of phone number should be 10 digit.</font></center>");
        				error = true;
        			}
        			
        			String email= request.getParameter("email");
        			
        			int firstChar= email.codePointAt(0);
        			if(!(firstChar >=90 &&firstChar<=122)){
        				out.println("<center><font color='red'>First character must be small in email.</font></center>");					
        				error = true;
        			}
        			
        			String eSplit[]=email.split("@");				
        			int count=0;
        			for(int i=0;i<email.length();i++)
        				if(email.charAt(i)=='@')
        					count++;
        			if(count!=1){
        				out.println("<center><font color='red'>Occurrence of @ is not properly maintained in email.</font></center>");
        				error = true;					
        			}
        			
        			for(int i=0;i<email.length();i++){
        				int unicode=email.codePointAt(i);
        				if(!((unicode>=64 && unicode <=90)||(unicode >=97 && unicode<=122)||(unicode==95)||(unicode==46)||
        						(unicode>=48&& unicode<=57))){
        					out.println("<center><font color='red'>Special symbol is not allowed in the email address.</font></center>");
        					error = true;
        				}
        			}
        			
        			if(!(email.indexOf('.')+3<=email.length())){
        				out.println("<center><font color='red'>Invalid domain name in email.</font></center>");
        				error = true;
        			}
        			
        			//unique username is checked.
        			String username = user;        		
        		
        			if(error==false){
        				String firstname = request.getParameter("firstname");
        				String lastname = request.getParameter("lastname");        				
        				String password = request.getParameter("password");
        				String phone = request.getParameter("phone");
        				email = request.getParameter("email");
        				String canteenname = request.getParameter("canteenname");								
        				query = "update tbluser set first_name = '"+firstname+"', last_name = '"+lastname+"', password = '"+password+"', phone_number = '"+phone+"', email = '"+email+"', fkcanteen_id = '"+canteenname+"' where username = '"+username+"'";	        				
                        stmt = con.createStatement();
        				int updated= stmt.executeUpdate(query);
        				if(updated==1){
        					response.sendRedirect("userpanel.jsp");
        				}
        				else{
        					response.sendRedirect("editdetails.jsp");
        				}			
        			}
        		}else{
        			out.print("<center><font color='red'>All the fields are required.</font></center>");
        		}		
        	}


            %>
            
          </div>
        <!--end container-->

      </section>
    <%} %>
      <!-- END CONTENT -->
    </div>
    <!-- END WRAPPER -->

  </div>
  <jsp:include page="template/footer.jsp"></jsp:include>