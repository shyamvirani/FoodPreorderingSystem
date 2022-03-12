<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<jsp:include page="template/adminpanel_header.jsp"></jsp:include>

<jsp:include page="template/adminsidebar.jsp"></jsp:include> 

<center>
<style>
.row{
	margin-left:33%;
	margin-right:33%;
	
}
.optright{
	margin-left:45px; 
}
.mdi-maps-restaurant-menu{margin-left: -47%;}
</style>

<%@ include file="db.jsp" %>
<%
if((String)session.getAttribute("user")==null)
	response.sendRedirect("../login.jsp");
else{
%>
  <div id="login-page" class="row">
      <form class="formValidate" id="formValidate" method="post" action="" novalidate="novalidate" class="">
        <div class="row">
          <div class="input-field col s12 center">
            <h4>Register</h4>
            <p class="center">Join us now!</p>
          </div>
        </div>
         <div class="form-row">
       
          <div class="input-field col s6">
            <i class="mdi-social-person prefix"></i>
            <input name="firstname" id="firstname" type="text" data-error=".errorTxt1">
            <label for="firstname" class="center-align">First Name</label>
			<div class="errorTxt1"></div>			
          </div>
          <div class="input-field col s6">
            <i class="mdi-social-person prefix"></i>
            <input name="lastname" id="lastname" type="text" data-error=".errorTxt2">
            <label for="lastname" class="center-align">Last Name</label>
			<div class="errorTxt2"></div>			
          </div>
      
        
        
          <div class="input-field col s6">
            <i class="mdi-social-person-outline prefix"></i>
            <input name="username" id="username" type="text" data-error=".errorTxt3">
            <label for="username" class="center-align">Username</label>
			<div class="errorTxt3"></div>			
        </div>
        
          <div class="input-field col s6">
            <i class="mdi-action-lock-outline prefix"></i>
            <input name="password" id="password" type="password" data-error=".errorTxt4">
            <label for="password">Password</label>
			<div class="errorTxt4"></div>			
          </div>

          <div class="input-field col s6">
            <i class="mdi-communication-phone prefix"></i>
            <input name="phone" id="phone" type="number" data-error=".errorTxt5">
            <label for="phone">Phone</label>
			<div class="errorTxt5"></div>			
          </div>
		
          <div class="input-field col s6">
            <i class="mdi-content-mail prefix"></i>
            <input name="email" id="email" type="text" data-error=".errorTxt6">
            <label for="email">Email</label>
			<div class="errorTxt6"></div>			
          </div>
        	       
        
        <div class="row margin">
          <div class="input-field col s12">
          <i class="mdi-maps-restaurant-menu prefix"></i>
            <select class="optright" name="canteenname">
            	<option value="" selected>Select your canteen</option>
        <%
        		Statement stmt = con.createStatement();
            	ResultSet rs = stmt.executeQuery("select canteen_name from tbladmin");
        
				while(rs.next()){
					out.print("<option value='"+rs.getString("canteen_name")+"'>");
					out.print(rs.getString("canteen_name"));
					out.print("</option>");
            	}
        %>    	
            </select>
           
			<div class="errorTxt7"></div>			
          </div>
        </div>
        </div>
        <div class="row">
          <div class="input-field col s12">
          <input class="btn waves-effect waves-light col s12" type="submit" name="submit" value="Register"/>
		<!--  <a href="javascript:void(0);" onclick="document.getElementById('formValidate').submit();" class="btn waves-effect waves-light col s12">Register</a>  -->
          </div>
          
        </div>
      </form>
    </div>
  </div>

</center>

<%

	if(request.getParameter("submit")!=null){
		if(!request.getParameter("firstname").isEmpty() && !request.getParameter("lastname").isEmpty() && 
				!request.getParameter("username").isEmpty() && !request.getParameter("password").isEmpty() && 
				!request.getParameter("phone").isEmpty() && !request.getParameter("email").isEmpty() && 
				!request.getParameter("canteenname").isEmpty()){
			
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
				if(!((unicode>=64 && unicode <=90)||(unicode >=97 && unicode<=122)||(unicode==95)||(unicode==46)||(unicode>=48&& unicode<=57))){
					out.println("<center><font color='red'>Special symbol is not allowed in the email address.</font></center>");
					error = true;
				}
			}
			
			if(!(email.indexOf('.')+3<=email.length())){
				out.println("<center><font color='red'>Invalid domain name in email.</font></center>");
				error = true;
			}
			
			//unique username is checked.
			String username = request.getParameter("username");
			stmt = con.createStatement();			
			rs = stmt.executeQuery("select * from tbladmin where admin_name='"+username+"'");
			if(rs.next()){
				out.print("<center><font color='red'>Please try another Username.</font></center>");
				error = true;
			}
			rs = stmt.executeQuery("select * from tbluser where username='"+username+"'");
			if(rs.next()){
				out.print("<center><font color='red'>Please try another Username.</font></center>");
				error = true;
			}
		
			if(error==false){
				String firstname = request.getParameter("firstname");
				String lastname = request.getParameter("lastname");
				username = request.getParameter("username");
				String password = request.getParameter("password");
				String phone = request.getParameter("phone");
				email = request.getParameter("email");
				String canteenname = request.getParameter("canteenname");								
					
				String query="INSERT INTO tbluser (username,first_name,last_name,password,phone_number,email,fkcanteen_id) VALUES ('"+username+"','"+firstname+"','"+lastname+"','"+password+"','"+phone+"','"+email+"','"+canteenname+"');";
                stmt = con.createStatement();
				int inserted= stmt.executeUpdate(query);
				if(inserted==1){
							out.println("Registered successfully");
				}
				else{
							out.println("Try again");
				}			
			}
		}else{
			out.print("<center><font color='red'>All the fields are required.</font></center>");
		}		
	}

%>
<%} %>
  <!-- ================================================
    Scripts
    ================================================ -->

  <!-- jQuery Library -->
  <script type="text/javascript" src="js/plugins/jquery-1.11.2.min.js"></script>
  <!--materialize js-->
  <script type="text/javascript" src="js/materialize.min.js"></script>
  <!--scrollbar-->
  <script type="text/javascript" src="js/plugins/perfect-scrollbar/perfect-scrollbar.min.js"></script>
     <script type="text/javascript" src="js/plugins/jquery-validation/jquery.validate.min.js"></script>
    <script type="text/javascript" src="js/plugins/jquery-validation/additional-methods.min.js"></script>
     
      <!--plugins.js - Some Specific JS codes for Plugin Settings-->
    <script type="text/javascript" src="js/plugins.min.js"></script>
    <!--custom-script.js - Add your own theme custom JS-->
    <script type="text/javascript" src="js/custom-script.js"></script>
    <script type="text/javascript">
    $("#formValidate").validate({
        rules: {
            username: {
                required: true,
                minlength: 5
            },
            firstname:{
                required: true

            },
            lastname:{
                required: true,

            },
            name: {
                required: true,
                minlength: 5				
            },
			password: {
				required: true,
				minlength: 5
			},
            phone: {
				required: true,
				minlength: 10,
				maxlength:10
			},
			email:{
				required:true
			}
        },
        messages: {
        	
             
            username: {
                minlength: "Minimum 5 characters are required."
            },
           
			password: {
				minlength: "Minimum 5 characters are required."
			},
            phone:{
				minlength: "10  characters are required."
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
 <jsp:include page="template/footer.jsp"></jsp:include>
    