<%@page import="com.sun.net.httpserver.Authenticator.Success"%>
<%@page import="fps.Order"%>
<%@page import="com.sun.crypto.provider.RSACipher"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@ page buffer="500kb" autoFlush="false" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<jsp:include page="template/userpanel_header.jsp"></jsp:include>
<jsp:include page="template/usersidebar.jsp"></jsp:include>
<link rel="stylesheet" href="hr-timePicker.min.css">
<script src="//code.jquery.com/jquery.min.js"></script>
<script src="hr.timePicker.min.js"></script>

<%@ include file="db.jsp" %>
      <!-- START CONTENT -->
      <section id="content">

        <!--breadcrumbs start-->
        <div id="breadcrumbs-wrapper">
          <div class="container">
            <div class="row">
              <div class="col s12 m12 l12">
                <h5 class="breadcrumbs-title">Provide Order Details</h5>
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
			Statement stmt = con.createStatement();			
			ResultSet rs = null;
			String foodName[] = new String [temp.totalItem];
			int j=0;
			for(int i=0;i<temp.refMenu.length;i++){				
				String query = "select food_name from tblmenu where pkmenu = " + temp.refMenu[i] +" and fkcanteen_id = "+temp.canteenId;
				rs = stmt.executeQuery(query);
				rs.next();
				foodName[j] = rs.getString("food_name");
				j++;
			}
			
%>
 

        <div class="container">
          <p class="caption">Estimated Receipt</p>
          <div class="divider"></div>
          <!--editableTable-->
<div id="work-collections" class="seaction">
<div class="row">
<div>
<ul id="issues-collection" class="collection">

    <li class="collection-item avatar">
        <i class="mdi-content-content-paste red circle"></i>
        <p><strong>Username:</strong> <%=user %></p>
<%-- 		<p><strong>Order ID:</strong><%=temp.orderId %></p>
 --%>        <a href="#" class="secondary-content"><i class="mdi-action-grade"></i></a>
		
	
	<li class="collection-item">
        <table>
        <th>
        	Sr no.
        </th>
        <th>
        	Item Name        	
        </th>
        <th>
        	Price/Piece
        </th>
         <th>
        	Quantity
        </th>
          <th>
        	Price (Rs)
        </th>

  <% 
		int total = 0;
  		for(int i=0;i<temp.totalItem;i++){
  %>
        <tr>
        
        <td>
              <strong> <%=i+1 %> </strong>
         
        
        </td>
        <td>
        	<span><%=foodName[i] %></span>
        </td>
        <td>
        	<span><%=temp.price[i] %></span>          
        </td>
        <td>
        	
            <strong><%=temp.quantity[i] %></strong>   
          
        </td>
        <td>
        	 
              <span>
              		<%
              			total = total + temp.price[i]*temp.quantity[i];
              			out.print(temp.price[i]*temp.quantity[i]);              			
              		%>
              </span>
            
        </td>
        </tr>
        <%} %>
        </table>
       
    </li>
	
 <li class="collection-item">
        <div class="row">
            <div class="col s7">
                <p class="collections-title"> Total</p>
            </div>
            <div class="col s2">
                <span>
                </span>
            </div>
            <div class="col s3">
                <span><strong>Rs. </strong><%
                		temp.totalPrice=total;
                		out.print(total); 
                	  %></span>
            </div>
        </div>
    </li>
</ul>


                </div>
				</div>
                </div>
              </div>
	
			  
			  
			  
			  
			  
			  
 <!--start container-->
	<div class="container">
          <p class="caption">Provide required delivery and payment details.</p>
          <div class="divider"></div>
            <div class="row">
              <div class="col s12 m4 l3">
                <h4 class="header">Details</h4>
              </div>
<div>
                <div class="card-panel">
                  <div class="row">
                    <form class="formValidate col s12 m12 l6" id="formValidate" method="post" action="" novalidate="novalidate">
                      <div class="row">
                        <div class="input-field col s12">
							<label for="payment_type">Payment Type</label><br><br>
							<select id="payment_type" name="payment_type">
									<option value="Wallet" selected>Wallet</option>
									<option value="Cash On Delivery" >Cash on Delivery</option>							
							</select>
                        </div>
                      </div>
                        <div class="row">
                        <div class="input-field col s12">
							<label for="time">Choose food delivery time </label><br>
							<input id="time" type="time" name="time" value="11:30">
                        </div>
                      </div>
            
                      <div class="row">
                        <div class="row">
                          <div class="input-field col s12">
                            <button class="btn cyan waves-effect waves-light right" type="submit" name="submit">Submit
                              <i class="mdi-content-send right"></i>
                            </button>
                          </div>
                        </div>
                      </div>
					 

                    </form>
<%
	String query="";
	if(request.getParameter("submit")!=null){
		temp.paymentType = request.getParameter("payment_type");
		temp.deliveryTime = request.getParameter("time");
		String refMenu = arrayToCsv(temp.refMenu);
		String qty = arrayToCsv(temp.quantity);
		String price = arrayToCsv(temp.price);
		Statement stmt2 = con.createStatement();
		int balance = 0;
		
		if(temp.paymentType.equals("Wallet")){
			 query = "select balance from tbluser where pkuser_id = "+temp.userId;
			rs = stmt.executeQuery(query);
			rs.next();
			balance = rs.getInt("balance");
			out.println(balance-total);
			if(balance-total <= 0){
				response.sendRedirect("success.jsp?status=failure&msg=lowBalance");
				return;
			}
			else{
				query = "insert into tblorder (fkuser_id,fkcanteen_id,total_item,delivery_time,payment_type,ref_menu,status,quantity,price,total_price) values ("+temp.userId+","+temp.canteenId+","+temp.totalItem+",'"+temp.deliveryTime+"','"+temp.paymentType+"','"+refMenu+"','yet to be delivered','"+qty+"','"+price+"',"+temp.totalPrice+")";
				out.print(query);
				int inserted = stmt2.executeUpdate(query);
				query = "select pkorder_id,dateTime from tblorder where fkuser_id = "+temp.userId;
				rs = stmt.executeQuery(query);
				rs.next();
				rs.last();
				temp.orderId= rs.getInt("pkorder_id");
				temp.dateTime = rs.getString("dateTime");
				session.setAttribute("temp", temp);
				query = "update tbluser set balance = "+(balance-total)+" where pkuser_id = "+temp.userId;
				int updated = stmt.executeUpdate(query);
				response.sendRedirect("success.jsp?status=success");
				return;
			}
		}else{
			query = "insert into tblorder (fkuser_id,fkcanteen_id,total_item,delivery_time,payment_type,ref_menu,status,quantity,price,total_price) values ("+temp.userId+","+temp.canteenId+","+temp.totalItem+",'"+temp.deliveryTime+"','"+temp.paymentType+"','"+refMenu+"','yet to be delivered','"+qty+"','"+price+"',"+temp.totalPrice+")";
			out.print(query);
			int inserted = stmt2.executeUpdate(query);
			query = "select pkorder_id,dateTime from tblorder where fkuser_id = "+temp.userId;
			rs = stmt.executeQuery(query);
			rs.next();
			rs.last();
			temp.orderId= rs.getInt("pkorder_id");
			temp.dateTime = rs.getString("dateTime");
			session.setAttribute("temp", temp);
			response.sendRedirect("success.jsp?status=success");
			return;
		}
		
		/**if(temp.paymentType.equals("Wallet") && balance-total>=0){
			//query = "update tbluser set balance = "+(balance-total)+" where pkuser_id = "+temp.userId;
			//int updated = stmt.executeUpdate(query);
		}*/
		//response.sendRedirect("success.jsp?status=success");
	}

%>
                  </div>
                </div>
              </div>
            <div class="divider"></div>
            
          </div>
        <!--end container-->

      </div>
      <%} %>
<%!
		public static String arrayToCsv(int arr[]){
			String str = "";
			for(int i=0;i<arr.length;i++){
				str = str + arr[i] +",";
			}
			return str;
		}
%>	
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