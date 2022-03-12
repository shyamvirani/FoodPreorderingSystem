<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
<%
if((String)session.getAttribute("user")==null)
	response.sendRedirect("../login.jsp");
%>
<!-- START CONTENT -->
      <section id="content">

        <!--breadcrumbs start-->
        <div id="breadcrumbs-wrapper">
          <div class="container">
            <div class="row">
              <div class="col s12 m12 l12">
                <h5 class="breadcrumbs-title">Add Food Category</h5>
              </div>
            </div>
          </div>
        </div>
        <!--breadcrumbs end-->


        <!--start container-->
        <div class="container">
        
          <div class="divider"></div>
			 <form class="formValidate" id="formValidate1" method="post" action="" novalidate="novalidate">
            <div class="row">
              <div>
			<table>
                    <thead>
                      <tr>
                        <th data-field="id"></th>
                 
                      </tr>
                    </thead>

                    <tbody>
			
			
					<tr>
						<td>
						
							<div class="input-field col s12">
								<label for="category">Category Name</label>
									<input id="category" name="category" type="text" data-error=".errorTxt01">
								<div class="errorTxt01">
								</div>
							</div>	
						</td>
						<td>
							 <div class="input-field col s12">
                     			 <button class="btn cyan waves-effect waves-light " type="submit" name="submit">Add
                          			 <i class="mdi-content-send right"></i>
                     			</button>
        			         </div>
					</td>					
                    </tbody>
			  </table>
              </div>
            </div>
			</form>			
            <div class="divider"></div>
          </div>     
        <!--end container-->
<%
		if(request.getParameter("submit")!=null){
			String category = request.getParameter("category");			
			session.setAttribute("category", category);
		}
%>
      </section>
      <!-- END CONTENT -->

<jsp:include page="template/footer.jsp"></jsp:include>