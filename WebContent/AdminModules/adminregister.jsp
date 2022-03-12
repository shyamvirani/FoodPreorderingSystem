<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<jsp:include page="template/adminregistration_header.jsp"></jsp:include>
<center>
<style>
.row{
	margin-left:30%;
	margin-right:30%;
}
.mdi-maps-restaurant-menu{
margin-left: 0px;
}

</style>




<div id="login-page" class="row">
<br>
    <div class="col s12 z-depth-3 card-panel">
      <form class="formValidate" id="formValidate" method="post" action="" novalidate="novalidate" class="col s12">
        <div class="row">
          <div class="input-field col s12 center">
            <h4 style="color:#a82128;">Register</h4>
          </div>
        </div>
		
	 <div class="form-row">
		
          <div class="input-field col s6">
            <i class="mdi-action-account-circle prefix"></i>
            <input name="adminname" id="aname" type="text" data-error=".errorTxt2">
            <label for="adminname" class="center-align">admin name</label>
			<div class="errorTxt2"></div>			
          </div>
        
       
        
          <div class="input-field col s6">
            <i class="mdi-maps-restaurant-menu prefix"></i>
            <input name="canteenname" id="cname" type="text" data-error=".errorTxt2">
            <label for="canteenname" class="center-align">Canteen Name</label>
			<div class="errorTxt2"></div>			
          </div>
       
		
          <div class="input-field col s6">
            <i class="mdi-action-lock-outline prefix"></i>
            <input name="password" id="password" type="password" data-error=".errorTxt3">
            <label for="password">Password</label>
			<div class="errorTxt3"></div>			
          </div>
          <div class="input-field col s6">
            <i class="mdi-communication-phone prefix"></i>
            <input name="phone" id="phone" type="number" data-error=".errorTxt4">
            <label for="phone">Phone</label>
			<div class="errorTxt4"></div>			
          </div>
          <div class="input-field col s6">
            <i class="mdi-content-mail prefix"></i>
            <input name="email" id="address" type="text" data-error=".errorTxt4">
            <label for="email">email</label>
			<div class="errorTxt4"></div>			
          </div>
          <div class="input-field col s6">
            <i class="mdi-maps-place prefix"></i>
            <input name="address" id="address" type="text" data-error=".errorTxt4">
            <label for="address">address</label>
			<div class="errorTxt4"></div>			
          </div>
        <div class="row">
          <div class="input-field col s12">
          		<input class="btn waves-effect waves-light col s12" type="submit" name="submit" value="Register"/>
			<!--<a href="javascript:void(0);" onclick="document.getElementById('formValidate').submit();" class="btn waves-effect waves-light col s12"  name="submit">Register</a>-->
          </div>
          <div class="input-field col s12">
            <p class="margin center medium-small sign-up">Already have an account? <a href="../login.jsp">Login</a></p>
          </div>
        </div>
                </div>	
        
      </form>
    </div>
  </div>
</center>

<%@ include file="db.jsp" %>

<%
		
		if(request.getParameter("submit")!=null){			
			if(!request.getParameter("adminname").isEmpty() && !request.getParameter("canteenname").isEmpty() && 
					!request.getParameter("password").isEmpty() && !request.getParameter("phone").isEmpty() && 
					!request.getParameter("email").isEmpty() && !request.getParameter("address").isEmpty()){
				
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
				
				//unique adminname is checked.
				String adminname = request.getParameter("adminname");
				Statement stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery("select * from tbladmin where admin_name='"+adminname+"'");
				if(rs.next()){
					out.print("<center><font color='red'>Please try another Admin Name.</font></center>");
					error = true;
				}
				rs = stmt.executeQuery("select * from tbluser where username='"+adminname+"'");
				if(rs.next()){
					out.print("<center><font color='red'>Please try another Admin Name.</font></center>");
					error = true;
				}
				
				if(error==false){
					adminname = request.getParameter("adminname");
					String canteenname = request.getParameter("canteenname");
					String password = request.getParameter("password");
					String phone = request.getParameter("phone");
					email = request.getParameter("email");
					String address = request.getParameter("address");
						
					String query="INSERT INTO tbladmin (canteen_name,admin_name,password,email,phone_number,address) VALUES ('"+canteenname+"','"+adminname+"','"+password+"','"+email+"','"+phone+"','"+address+"');";
                    stmt = con.createStatement();
					int inserted= stmt.executeUpdate(query);
					if(inserted==1){
						response.sendRedirect("../login.jsp");
					}
					else{
						response.sendRedirect("adminregister.jsp");
					}
					
				}
			}
			else{
				out.print("<center><font color='red'>All the fields are required</font></center>");
			}  
		}
	
	%>







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
				minlength: 4
			},
        },
        messages: {
            username: {
                required: "Enter username",
                minlength: "Minimum 5 characters are required."
            },
            name: {
                required: "Enter name",
                minlength: "Minimum 5 characters are required."
            },
			password: {
				required: "Enter password",
				minlength: "Minimum 5 characters are required."
			},
            phone:{
				required: "Specify contact number.",
				minlength: "Minimum 4 characters are required."
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

