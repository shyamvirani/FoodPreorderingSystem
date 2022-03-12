<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <!-- START MAIN -->
  <div id="main">
    <!-- START WRAPPER -->
    <div class="wrapper">
<%@ include file="../db.jsp" %>

<%
	
	
	if((String)session.getAttribute("user")==null)
		response.sendRedirect("../login.jsp");
	else{
	String user = (String)session.getAttribute("user");	
	Statement stmt = con.createStatement();
	String query = "select username,first_name,last_name from tbluser where username = '"+user+"'";
	ResultSet rs = stmt.executeQuery(query);
	rs.next();
%>  
      <!-- START LEFT SIDEBAR NAV-->
      <aside id="left-sidebar-nav">
        <ul id="slide-out" class="side-nav fixed leftside-navigation">
            <li class="user-details cyan darken-2">
            <div class="row">
                <div class="col col s4 m4 l4">
                    <img src="images/avatar.jpg" alt="" class="circle responsive-img valign profile-image">
                </div>
				 <div class="col col s8 m8 l8">
                    <ul id="profile-dropdown" class="dropdown-content">
                        <li><a href="../logout.jsp"><i class="mdi-hardware-keyboard-tab"></i> Logout</a>
                        </li>
                    </ul>
                </div>
                <div class="col col s8 m8 l8">
                    <a class="btn-flat dropdown-button waves-effect waves-light white-text profile-btn" href="#" data-activates="profile-dropdown">
                		<%out.print(rs.getString("first_name")+" "+ rs.getString("last_name")); %><i class="mdi-navigation-arrow-drop-down right"></i></a>
                    	<p class="user-roal">Customer</p>    
                     <i class="mdi-navigation-arrow-drop-down right"></i></a>
                </div>
            </div>
            </li>
            <li class="bold "><a href="userpanel.jsp" class="waves-effect waves-cyan"><i class="mdi-editor-border-color"></i> Order Food</a>
            </li>
                <li class="no-padding">
                    <ul class="collapsible collapsible-accordion">
                        <li class="bold"><a class="collapsible-header waves-effect waves-cyan" style="text-decoration: none;"><i class="mdi-editor-insert-invitation"></i> Orders</a>
                            <div class="collapsible-body">
                                <ul>
								
                               <li><a href="myorders.jsp">My All orders</a></li>
								 <li><a href="cancelledbyadmin_user.jsp">Cancelled by Admin</a></li>
								  <li><a href="cancelledbycustomer_user.jsp">Cancelled by Customer</a></li>
								   <li><a href="yettobedelivered_user.jsp">Yet to be delivered</a></li>
								   <li><a href="delivered_user.jsp">Delivered</a></li>
																				
                                </ul>
                            </div>
                        </li>
                    </ul>
                </li>
               			
            <li class="bold"><a href="editdetails.jsp" class="waves-effect waves-cyan"><i class="mdi-social-person"></i> Edit Details</a>
            </li>	
             <li class="bold"><a href="changepassword.jsp" class="waves-effect waves-cyan"><i class="mdi-action-lock-outline prefix"></i>Change password</a>
            </li>			
        </ul>
        <a href="#" data-activates="slide-out" class="sidebar-collapse btn-floating btn-medium waves-effect waves-light hide-on-large-only cyan"><i class="mdi-navigation-menu"></i></a>
        </aside>
      <%} %>
      <!-- END LEFT SIDEBAR NAV-->
    
