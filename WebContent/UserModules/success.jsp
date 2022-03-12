<%@page import="fps.Order"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<jsp:include page="template/userpanel_header.jsp"></jsp:include>
<jsp:include page="template/usersidebar.jsp"></jsp:include>
<%@ page buffer="500kb" autoFlush="false" %>
 
 
 <style>

.page-footer {
  position: absolute;
  right: 0;
  bottom: 0;
  left: 0;  
  text-align: center;
}
 
 
 </style>
 <!-- START CONTENT -->
      <section id="content">

        <!--breadcrumbs start-->
        <div id="breadcrumbs-wrapper">
          <div class="container">
            <div class="row">
              <div class="col s12 m12 l12">
                <h5 class="breadcrumbs-title">Order details</h5>
              </div>
            </div>
          </div>
        </div>
        <!--breadcrumbs end-->
<%
if((String)session.getAttribute("user")==null)
	response.sendRedirect("../login.jsp");
else{
	String user = (String)session.getAttribute("user");
	Order temp = (Order)session.getAttribute("temp");	
%>
        <!--start container-->
        <div class="container">
          <p class="caption"></p>
          <div class="divider"></div>
          <!--editableTable-->
<div id="work-collections" class="seaction">
             
					
		  <div class="row">
                <div>
                    
                    <ul id="issues-collection" class="collection">
				<% if(request.getParameter("status").equals("success")){ %>			
					<li class="collection-item avatar">
                              <i class="mdi-content-content-paste red circle"></i>
                              <span class="collection-header">Order ID: <%=temp.orderId %></span>
                              <p><strong>Username: </strong><%=user %> </p>
                              <p><strong>Date: </strong> <%=temp.dateTime %></p>
                              <p><strong>Time: </strong> <%=temp.dateTime %></p>
                              <p><strong>Payment Type: </strong><%=temp.paymentType %></p>
														  				  
							 <p><strong>Total Amount: </strong><%=temp.totalPrice %></p>						                               
							  <a href="#" class="secondary-content"><i class="mdi-action-grade"></i></a>
                              </li>
				
								<li class="collection-item">
                                        <div class="row">
                                            
                                            <div class="col ">
                                                <strong style="color:green"><h5>Order Placed Successfully....</h5></strong>
                                            </div>
                                            	
								
								
										</div>
								</li>
				<%}
					else if(request.getParameter("status").equals("failure")){
						String reason = request.getParameter("msg");
						if(reason.equals("lowBalance"))
							reason = "	 Due to "+reason+".";
				%>				
								<li class="collection-item">
                                        <div class="row">                                       
                                            <div class="col ">
                                                <strong style="color:red"><h5>Failure in order. <%=reason %></h5></strong>
                                            </div>
                                		</div>
									</li>
							
				<%} %>	
					 </ul>
                </div>
              </div>
            </div>
        </div>
        <!--end container-->
<%} %>
      </section>
      <!-- END CONTENT -->
    </div>
    <!-- END WRAPPER -->

  </div>
  <!-- END MAIN -->
  <jsp:include page="template/footer.jsp"></jsp:include>