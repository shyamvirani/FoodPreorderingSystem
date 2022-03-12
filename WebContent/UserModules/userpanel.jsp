<%@page import="java.io.Console"%>
<%@page import="fps.Order"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@ page buffer="100kb" autoFlush="false" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     
<jsp:include page="template/userpanel_header.jsp"></jsp:include>

<jsp:include page="template/usersidebar.jsp"></jsp:include>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<style>
html{font-size:14px;}
a:link{text-decoration: none;}

	

</style>
<%@ include file="db.jsp" %>
		<div id="breadcrumbs-wrapper">
          <div class="container">
            <div class="row">
              <div class="col s12 m12 l12">
                <h5 class="breadcrumbs-title">Order</h5>
              </div>
            </div>
          </div>
        </div>
        <!--breadcrumbs end-->
<%
	if((String)session.getAttribute("user")==null)
		response.sendRedirect("../login.jsp");
	else{
	Statement stmt = con.createStatement();
	Statement stmt2 = con.createStatement();
	String user = (String)session.getAttribute("user");
	String query = "select pkuser_id,fkcanteen_id from tbluser where username = '"+user+"'";
	ResultSet rs = stmt.executeQuery(query);
	rs.next();
	int userId = rs.getInt("pkuser_id");
	String canteen_name = rs.getString("fkcanteen_id");	
	int index = 0,i=0;
	query = "select pkcanteen_id from tbladmin where canteen_name = '"+canteen_name+"'";
	rs = stmt.executeQuery(query);
	rs.next();
	int canteen_id = Integer.parseInt(rs.getString("pkcanteen_id"));
	query = "select distinct category from tblmenu where fkcanteen_id = "+canteen_id+" and status = 1";
	rs = stmt.executeQuery(query);
%>

	
        <!--start container-->
        <div class="container">
        
          <p class="caption">Select category to order Food</p>
          <div class="divider"></div>
           <div class="divider"></div>
		  <form class="formValidate" id="formValidate" method="post" action="" novalidate="novalidate">
		   <input type="submit" name="submit" class="btn waves-effect waves-light col s12 " style="margin-left:88%;" value="order"/>			  
            <div class="panel-group" id="accordion">
		    <%while(rs.next()){ %>
		    <div class="panel panel-default">
		    <a data-toggle="collapse" data-parent="#accordion" href="#collapse<%=index %>"  style="color: black">
		     <div class="panel-heading" style="background-color:#f5f5f5">
		      
		       
		        <h4 class="panel-title">
		         <%=rs.getString("category") %>	       
		         </h4>
		        
	
		     
		      </div>
		      </a>
		      <div id="collapse<%=index %>" class="panel-collapse collapse ">
		        <div class="panel-body" >
		      <div>
              <div class="col s12 m4 l3">
                <h4 class="header">Order Food</h4>
              </div>
              <div>
                  <table id="" class="" cellspacing="0">
                    <thead>
                      <tr>
                        <th>Name</th>
                        <th>Item Price/Piece</th>
                        <th>Quantity</th>
                      </tr>
                    </thead>

					<%
							query = "select pkmenu,food_name,price from tblmenu where fkcanteen_id = "+canteen_id+" and category = '"+rs.getString("category")+"' and status=1";
							ResultSet rs2 = stmt2.executeQuery(query);
							while(rs2.next()){						
					%>

                    <tbody>				
					<tr><td><%=rs2.getString("food_name") %></td>
						<td>
							<input type="hidden" name="price<%=i %>" value="<%=rs2.getString("price")%>">													
							<% out.print(rs2.getInt("price"));
							%>
						</td>                      
						<td>
						<div class="input-field col s12">
							<label for="" class="">Quantity</label>
							<input id="" name="quantity<%=i %>" type="number" value="0" data-error="errorTxt"><div class="errorTxt"></div>
							<input type="hidden" name="pkmenu<%=i %>" value="<%=rs2.getString("pkmenu")%>">						
						</td>
					</tr>
                    </tbody>
                    <%i++;} %>
			</table>
              </div>
			  <div class="input-field col s12">
              
			  </div>
			  </div>
		        </div>
		      </div>		      
		    </div>
		    
		    <div class="divider"></div>
		    <div class="divider"></div>
          
          <%index++;} %>
          <div>
			<input type="hidden" name="i" value="<%=i%>">          
           
          </div>
         </div>
           </form>

<%
		if(request.getParameter("submit")!=null){
			String qty = "";
			String menu = "";
			String price = "";
			Order temp = new Order();
			temp.userId = userId;
			temp.canteenId = canteen_id;
			while(i>0){
				i--;				
				if(Integer.parseInt(request.getParameter("quantity"+i))>0){
					 qty = qty + Integer.parseInt(request.getParameter("quantity"+i)) +",";					
					 menu = menu + Integer.parseInt(request.getParameter("pkmenu"+i)) + ",";
					 price = price + Integer.parseInt(request.getParameter("price"+i)) + ",";
				}
			}			
			temp.quantity = csvToArray(qty);
			temp.refMenu = csvToArray(menu);
			temp.price = csvToArray(price);
			temp.totalItem = temp.quantity.length;
			session.setAttribute("temp", temp); 
			Boolean s =response.isCommitted();
		
			response.sendRedirect("placeorder.jsp");
				
						
		}

%>         
            
          </div>
       <%} %>
        <!--end container-->
<%!
	public static int [] csvToArray(String str){
		String str2 [] = str.split(",");
		int arr[] = new int [str2.length];
		for(int i=0;i<str2.length;i++){
			arr[i] = Integer.parseInt(str2[i]);
		}
		return arr;	
	}
%>
      
      <!-- END CONTENT -->
		

    
 
<jsp:include page="template/footer.jsp"></jsp:include>      