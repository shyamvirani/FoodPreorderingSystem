<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <!-- START MAIN -->
 <link href="css/mix.css" type="text/css" rel="stylesheet" media="screen,projection">
  <style>
 
  
  </style>
  
  <div id="main">
    <!-- START WRAPPER -->
    <div class="wrapper">
<%@ include file="../db.jsp" %>
<%
	if((String) session.getAttribute("user")==null){
		response.sendRedirect("login.jsp");
	}
	else{
	String user = (String)session.getAttribute("user");
	Statement stmt = con.createStatement();
	String query = "select admin_name,canteen_name from tbladmin where admin_name = '"+user+"'";
	ResultSet rs = stmt.executeQuery(query);
	rs.next();
%>
      <!-- START LEFT SIDEBAR NAV-->
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
						<%out.print(rs.getString("admin_name"));%>
						</a>
                     </a>                    	    
                    
                    <%} %>
                </div>
            </div>
            </li>
            <li class="bold"><a href="adminpanel.jsp" class="waves-effect waves-cyan"><i class="mdi-editor-border-color"></i> Food Menu</a>
            </li>
                
                     <li class="no-padding">
                    <ul class="collapsible collapsible-accordion">
                        <li class="bold"><a class="collapsible-header waves-effect waves-cyan"><i class="mdi-editor-insert-invitation"></i> Orders</a>
                            <div class="collapsible-body">
                                <ul>
								
                                 <li><a href="allorders.jsp">All orders</a></li>
								 <li><a href="cancelledbyadmin.jsp">Cancelled by Admin</a></li>
								  <li><a href="cancelledbycustomer.jsp">Cancelled by Customer</a></li>
								  	<%--  <li><a href="">Delivered</a></li> --%>
								   <li><a href="yettobedelivered.jsp">Yet to be delivered</a></li>
								     <li><a href="delivered_admin.jsp">Delivered</a></li>
                                </ul>
                            </div>
                        </li>
                    </ul>
                </li>
                 			
          	<li class="bold "><a href="searchorder.jsp" class="waves-effect waves-cyan active"><i class="mdi-action-pageview"></i> Search Order</a>
            </li>
             <li class="bold "><a href="additem.jsp" class="waves-effect waves-cyan"><i class="mdi-av-my-library-add"></i> Add New Food Items</a>
            </li>
            <li class="bold"><a href="addcategory.jsp" class="waves-effect waves-cyan"><i class="mdi-action-note-add "></i> Add Food Category </a>
            </li>
            </li>
              
              <li class="bold"><a href="editmenu.jsp" class="waves-effect waves-cyan"><i class="mdi-maps-local-restaurant "></i>
             Edit Menu</a>
             
             </li> 
           	 <li class="bold"><a href="userregistration.jsp" class="waves-effect waves-cyan"><i class="mdi-social-person-outline prefix"></i>
             User Registration</a>
            </li>
           	 <li class="bold"><a href="userlist.jsp" class="waves-effect waves-cyan"><i class="mdi-action-account-child"></i> Users</a>
            </li>
             <li class="bold"><a href="addbalance.jsp" class="waves-effect waves-cyan"><i class="mdi-action-account-balance-wallet"></i>Add Wallet Balance</a>
            </li>
            
             
            					
        </ul>
        <a href="#" data-activates="slide-out" class="sidebar-collapse btn-floating btn-medium waves-effect waves-light hide-on-large-only cyan"><i class="mdi-navigation-menu"></i></a>
        </aside>
             <!-- END LEFT SIDEBAR NAV-->