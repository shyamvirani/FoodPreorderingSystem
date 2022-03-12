<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<jsp:include page="template/userpanel_header.jsp"></jsp:include>
<jsp:include page="template/usersidebar.jsp"></jsp:include>
<%@page import="java.sql.Array"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
     <%@ include file="db.jsp" %>
 
<style>

.page-footer {
  position: absolute;
  right: 0;
  bottom: 0;
  left: 0;
  
  text-align: center;
}

</style>    
 <script type="text/javascript">
    $("#formValidate").validate({
        rules: {
            
			newpassword: {
				required: true,
				minlength: 5
			},
			
			confirmpassword: {
				required: true,
				minlength: 5
			},
            
        },
        messages: {
            
			newpassword: {
				required: "Enter new password",
				minlength: "Minimum 5 characters are required."
			},
			oldpassword: {
				required: "Enter old password",
				minlength: "Minimum 5 characters are required."
			},
			confirmpassword: {
				required: "ReEnter password",
				minlength: "Minimum 5 characters are required."
			},
           	
        },
        errorElement : 'div',
        errorPlacement: function(error, element) {
          var placement = $(element).data('error');
          if (placement) {
            $(placement).append(error)
          } else {
            error.insertAfter(element);
          }
        }
     });
    </script>
   <%
  
   if((String)session.getAttribute("user")==null)
   	response.sendRedirect("../login.jsp");
   
   
   %>
 <section id="content">

        <!--breadcrumbs start-->
        <div id="breadcrumbs-wrapper">
          <div class="container">
            <div class="row">
              <div class="col s12 m12 l12">
                <h5 class="breadcrumbs-title">Change Password</h5>
              </div>
            </div>
          </div>
        </div>
        
        <!--breadcrumbs end-->


        <!--start container-->
        <div class="container">
          <p class="caption"></p>
          <div class="divider"></div>
            <div class="row">
              <div class="col s12 m4 l3">
                <h4 class="header">Password details</h4>
              </div>
              <div>
                <div class="card-panel">
                  <div class="row">
                      
                    <form class="formValidate" id="formValidate" method="post" action="" novalidate="novalidate" class="col s12">
                          <div class="row">
                        <div class="input-field col s12">
                          <i class="mdi-action-lock-outline prefix"></i>
                          <input name="oldpassword" id="oldpassword" type="password" data-error=".errorTxt4">
                          <label for="oldpassword" class="">Old password</label>
						  <div class="errorTxt4"></div>
                        </div>
                      </div>
                         <div class="row">
                        <div class="input-field col s12">
                          <i class="mdi-action-lock-outline prefix"></i>
                          <input name="newpassword" id="newpassword" type="password" data-error=".errorTxt4">
                          <label for="newpassword" class="">NewPassword</label>
						  <div class="errorTxt4"></div>
                        </div>
                      </div>
                       <div class="row">
                        <div class="input-field col s12">
                          <i class="mdi-action-lock-outline prefix"></i>
                          <input name="confirmpassword" id="confirmpassword" type="password" data-error=".errorTxt4">
                          <label for="confirmpassword" class="">ConfirmPassword</label>
						  <div class="errorTxt4"></div>
                        </div>
                      </div>
                    
                        <div class="row">
                          <div class="input-field col s12">
                            <button class="btn cyan waves-effect waves-light right" type="submit" name="action">Submit
                              <i class="mdi-content-send right"></i>
                            </button>
                          </div>
                        </div>
                      </div>
                    </form>
                    
                    <%
                    
                    
                    if(request.getParameter("action")!=null){
                    	
                    	String oldpwd=request.getParameter("oldpassword");
	                   	String newpwd=request.getParameter("newpassword");
	                   	String user = (String)session.getAttribute("user");
	                   	String confirmpwd=request.getParameter("confirmpassword");
	                   	if(!oldpwd.isEmpty() && !newpwd.isEmpty() && !confirmpwd.isEmpty()){
                  		String query="select * from tbluser where password='"+oldpwd+"' and username ='"+user+"'";
                  		Statement stmt=con.createStatement();
                  			ResultSet rs=stmt.executeQuery(query);
 							String dbpwd="";
                  			while(rs.next()){
             			     		dbpwd=rs.getString("password");
                  				}
                  			int n1=newpwd.compareTo(confirmpwd);
                  			int n2=oldpwd.compareTo(dbpwd);
                  			if(n1==0 && n2==0){
                  				
							String q="update tbluser set password='"+newpwd+"' where username = '"+user+"'";
                  				int execute=stmt.executeUpdate(q);	
                  				out.println("password changed successfully");
                  			}else{
                  				out.print("Invalid values");
                  			}
	                   	}else{
                  				out.print("Fields must not be empty");
                  			}	
                    }
                    
                    
                    
                    
                    %>
                    
                    
                    
                    
                    
                    
                  </div>
                </div>
              </div>
            <div class="divider"></div>
            
          </div>
        <!--end container-->

      </section>
      <!-- END CONTENT -->
    </div>
    <!-- END WRAPPER -->

  </mdiv>
  
  
  <jsp:include page="template/footer.jsp"></jsp:include>
