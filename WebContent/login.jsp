<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<jsp:include page="template/login_header.jsp"></jsp:include>


<center>
<style>

.login-form{
margin-top:10%;

}
.login{
margin-left:35%;
margin-right:35%;
} 
.s{

border:1px solid black;
}

</style>



<div class="login">
<br>
    <div class="col s12 z-depth-3 card">

      <form method="post" action="" class="login-form" id="form">
        <div class="row">
          <div class="input-field col s12 center">
            <p class="center login-form-text"><h3 style="color:#a82128;">Login</h3> <br><b > Food PreOrdering System</b></p>
          </div>
			<!-- <div class="input-field col s12 ">
			<img src="images/fps2.jpg" alt="not found" style="float:right" heigh=10px >
			</div> -->
      
          <div class="input-field col s12">
            <i class="mdi-social-person-outline prefix"></i>
            <input name="username" id="username" type="text">
            <label for="username" class="center-align">Username</label>
          </div>
       
       
          <div class="input-field col s12">
            <i class="mdi-action-lock-outline prefix"></i>
            <input name="password" id="password" type="password">
            <label for="password">Password</label>
          </div>
        
        <div class="row">
        <input type="submit" name="submit" class="btn waves-effect waves-light col s12" value="Login"/>
			<!-- <a href="javascript:void(0);" onclick="document.getElementById('form').submit();" class="btn waves-effect waves-light col s12">Login</a> -->          </div>
		  		<div class="row">
          <div class="input-field col s6 m6 l6">
<!--             <p class="margin medium-small"><a href="userregistration.jsp">Register Now!</a></p>
 -->          </div>         
        </div>
        </div>

      </form>
    </div>
  </div>
</center>

<%@ include file="db.jsp" %>
<%
	if(request.getParameter("submit")!=null){
		if(!request.getParameter("username").isEmpty() && !request.getParameter("password").isEmpty()){
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			
			String query = "select * from tbladmin where admin_name = '"+username+"' and password = '"+password+"'";
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			if(rs.next()){						
				session.setAttribute("user", rs.getString("admin_name"));
				response.sendRedirect("AdminModules/adminpanel.jsp");
			}			
			
			query = "select * from tbluser where username = '"+username+"' and password = '"+password+"'";
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			if(rs.next()){
				session.setAttribute("user", rs.getString("username"));
				response.sendRedirect("UserModules/userpanel.jsp");
			}
			else{
				out.print("<center><font color='red'>Please enter correct Username and Password</font></center>");	
			}
		
		}else{
			out.print("<center><font color='red'>Please enter Username or Password</font></center>");
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

      <!--plugins.js - Some Specific JS codes for Plugin Settings-->
    <script type="text/javascript" src="js/plugins.min.js"></script>
    <!--custom-script.js - Add your own theme custom JS-->
    <script type="text/javascript" src="js/custom-script.js"></script>

<jsp:include page="template/footer.jsp"></jsp:include> 