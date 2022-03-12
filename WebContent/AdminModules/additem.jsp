<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="db.jsp" %>
<jsp:include page="template/adminpanel_header.jsp"></jsp:include>
<jsp:include page="template/adminsidebar.jsp"></jsp:include>

<style>
.optdown{
	margin-top:12px;
}
.page-footer {
  position: absolute;
  right: 0;
  bottom: 0;
  left: 0;
  
  text-align: center;
}



</style>
 

<!--breadcrumbs start-->
      <div id="breadcrumbs-wrapper">
          <div class="container">
            <div class="row">
              <div class="col s12 m12 l12">
                <h5 class="breadcrumbs-title">Add Food Items</h5>
              </div>
            </div>
          </div>
        </div>
        <form class="formValidate" id="formValidate1" method="post" action="" novalidate="novalidate">
          <div class="divider"></div><table>
        <thead>
          <tr>
            <th data-field="id">Name</th>
            <th data-field="name">Item Price(Rs.)</th>
			<th data-field="id">Category</th>
          </tr>
        </thead>

        <tbody>
        <tr>
<td>
<div class="input-field col s12">
	<label for="foodName">Name</label>
		<input id="foodName" name="foodName" type="text" data-error=".errorTxt01">
	<div class="errorTxt01">
	</div>
</div>
</td>					
<td>
<div class="input-field col s12 ">
	<label for="price" class="">Price</label>
		<input id="price" name="price" type="number" data-error=".errorTxt02">
<div class="errorTxt02">
</div>
</div>
</td>
<td>
  

<%
if((String)session.getAttribute("user")==null)
	response.sendRedirect("../login.jsp");
else{
	String username = session.getAttribute("user").toString();
	Statement stmt = con.createStatement();
	
	String query = "select pkcanteen_id from tbladmin where admin_name = '"+username+"'";
	ResultSet rs = stmt.executeQuery(query);	
	rs.next();
	int canteen_id = rs.getInt("pkcanteen_id");
	query = "select distinct category from tblmenu where fkcanteen_id = "+canteen_id ;
	rs = stmt.executeQuery(query);
%>

<select class="optdown"name="category">
<% while(rs.next()) {%>
	 <option value="<%= rs.getString("category") %>"><%=rs.getString("category") %></option>
<%}
	if(session.getAttribute("category")!=null){
	String category = session.getAttribute("category").toString();
%>
		<option value="<%= category %>"><%= category %></option>
<%} %>	
</select>

</td>                   
<td>
 
</tr>
  </tbody>
</table>
			  <div class="input-field col s12">
                              <button class="btn  waves-light right" type="submit" style="margin-top: -3%;" value="Add" name="submit">Add
                                <i class="mdi-content-send right"></i>
                              </button>
            </div>
 </form>	
   
   <%
   		 if(request.getParameter("submit")!=null){
			String foodName = (String)request.getParameter("foodName");
			int price = Integer.parseInt(request.getParameter("price"));
			String category = request.getParameter("category");
			int status=0;
			query = "INSERT INTO tblmenu (fkcanteen_id,food_name,price,status,category) VALUES ("+canteen_id+",'"+foodName+"',"+price+","+status+",'"+category+"');";
			int inserted = stmt.executeUpdate(query);
   		} 
   %>
<%} %>   
<jsp:include page="template/footer.jsp"></jsp:include>