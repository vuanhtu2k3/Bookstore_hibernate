<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE unspecified PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Quản lý thể loại - EBookStore</title>
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900|Roboto+Slab:400,700" />
  <!-- Nucleo Icons -->
  <link href="../assets/css/nucleo-icons.css" rel="stylesheet" />
  <link href="../assets/css/nucleo-svg.css" rel="stylesheet" />
  <link rel="shortcut icon" type="image/x-icon" href="../assets/img/icon.png">

  <!-- Font Awesome Icons -->
  <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
  <!-- Material Icons -->
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
  <!-- CSS Files -->
  <link id="pagestyle" href="../assets/css/material-dashboard.css?v=3.0.4" rel="stylesheet" />
   <script type="text/javascript" src="../assets/js/jquery-3.3.1.min.js"></script>
  <script type="text/javascript" src="../assets/js/jquery.validate.min.js"></script>
</head>
<body class="g-sidenav-show  bg-gray-200">
<jsp:directive.include file="sidebar.jsp" />
<main class="main-content position-relative max-height-vh-100 h-100 border-radius-lg ">

	<main class="main-content  mt-0">
    <section>
      <div class="page-header min-vh-100">
        <div class="container">
          <div class="row">
              <div class="card card-plain">
                <div class="card-header">
                <c:if test="${category == null}">
                  <h4 class="font-weight-bolder">Tạo thể loại mới</h4>
                  </c:if>
                   <c:if test="${category != null}">
                  <h4 class="font-weight-bolder">Cập nhật thể loại</h4>
                  </c:if>
                </div>
                 <br>
                <p class="text-center" style="color: red;">${message }</p> <br>
                <div class="card-body">
                <c:if test="${category == null}">
                  	<form action="create_category" method="post" onsubmit="return validateFormInput()" id="categoryForm">
                  </c:if>
                  <c:if test="${category != null}">
                  	<form action="update_category" method="post" onsubmit="return validateFormInput()" id="categoryForm">
                  	<input type="hidden" name="categoryId" value="${category.categoryId}">
                  </c:if>
                  
                  	<div class="input-group input-group-outline mb-3">  
                      <input type="text" id="name" name="name" value="${category.name }" class="form-control" placeholder="Name">
                    </div>
                   
                    <div class="text-center">
                      <button type="submit" class="btn btn-lg bg-gradient-warning">Gửi</button> &nbsp;&nbsp;&nbsp;
                      <button type="button" class="btn btn-lg bg-gradient-warning " onclick="javascript:history.go(-1);">Hủy</button>
                    </div>
                  </form>
                </div>      
              </div>
            </div>
          
        </div>
      </div>
    </section>
    <!-- start-footer -->
      <jsp:directive.include file="footerAdmin.jsp" />
      <!-- end-footer -->
  </main>
	
	
		
	</main>
</body>
<script type="text/javascript">
	function validateFormInput(){
		var fieldName = document.getElementById("name");
		if(fieldName.value.length == 0){
			alert("Tên danh mục là bắt buộc! ");
			fieldName.focus();
			return false;
		}
		return true;
	}
</script>
</html>