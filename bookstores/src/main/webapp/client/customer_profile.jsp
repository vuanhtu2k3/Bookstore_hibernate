<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html class="no-js" lang="zxx">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>EBookStore | Thông tin khách hàng</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="shortcut icon" type="image/x-icon" href="assets/img/icon.jpeg">

    <!-- CSS here -->
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/owl.carousel.min.css">
    <link rel="stylesheet" href="assets/css/flaticon.css">
    <link rel="stylesheet" href="assets/css/slicknav.css">
    <link rel="stylesheet" href="assets/css/animate.min.css">
    <link rel="stylesheet" href="assets/css/magnific-popup.css">
    <link rel="stylesheet" href="assets/css/fontawesome-all.min.css">
    <link rel="stylesheet" href="assets/css/themify-icons.css">
    <link rel="stylesheet" href="assets/css/slick.css">
    <link rel="stylesheet" href="assets/css/nice-select.css">
    <%@ include file="/includes/header.jsp"%>
</head>
<body>
   

 <header>
      	<jsp:directive.include file="/includes/navbar.jsp" />

    </header>

    <main>
 
        <!--================login_part Area =================-->
        <style>
        
        .login_part_form {
        background-color: #ffffff;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        margin: 70px;
        padding-left:200px; /* Căn giữa theo chiều ngang */
        max-width: 600px; /* Đảm bảo rằng nội dung không bị quá rộng */
    }

    .login_part_form h3 {
        font-size: 24px;
        font-weight: bold;
        color: #333;
        margin-bottom: 20px;
    }
    .login_part_text {
        padding: 20px; /* Khoảng cách giữa phần text và form */
    }

    .login_part_form {
        background-color: #ffffff; /* Màu nền của form */
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .login_part_form h3 {
        font-size: 24px;
        font-weight: bold;
        color: #333; /* Màu chữ của tiêu đề form */
        margin-bottom: 20px;
    }

    .login_part_form label {
        font-weight: bold;
        color: #333; /* Màu chữ của label */
    }

    .login_part_form .form-control {
        margin-bottom: 20px;
    }

    .login_part_form .btn_3 {
        background-color: #007bff;
        color: #fff;
        font-weight: bold;
    }
</style>
       
        <section class="login_part ">
        
            <div class="container">
                <div class="row align-items-center">
                    <!--  <div class="col-lg-6 col-md-6">
                        <div class="login_part_text text-center">
                            <div class="login_part_text_iner">
                                <a href="${pageContext.request.contextPath}/" class="btn_3">Home Page</a>
                            </div>
                        </div>-->
                    </div>
                    <div class="col-lg-6 col-md-6">
                        <div class="login_part_form">
                            <div class="login_part_form_iner">
                                <h3>Thông tin và cài đặt cá nhân</h3>
  
                                    <h3>${message}</h3>
                                <form class="row contact_form" action="update_profile" method="post" id="customerForm">
                                    <div class="col-md-12 form-group p_star ">
                                    <label style="color: red;">Email(*)</label>
                                        <input type="text" class="form-control" placeholder="${loggedCustomer.email}" readonly="readonly">
                                    </div>
                                    <div class="col-md-12 form-group p_star">
                                        <input type="text" class="form-control" id="fullname" name="fullname" size="45"
                                            placeholder="Tên người dùng(*)" value="${loggedCustomer.fullname}">
                                    </div>
                                    
                                    <div class="col-md-12 form-group p_star">
                                        <input type="password" class="form-control" id="password" name="password" size="15" 
                                            placeholder="Mật khẩu">
                                    </div>
                                    <div class="col-md-12 form-group p_star">
                                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" size="15" 
                                            placeholder="Nhập lại mật khẩu">
                                    </div>
                                     <div class="col-md-12 form-group p_star">
                                        <input type="text" class="form-control" id="phone" name="phone" size="15"
                                            placeholder=" Số điện thoại(*)" value="${loggedCustomer.phone}">
                                    </div>
                                    
                                    <div class="col-md-12 form-group p_star">
                                        <input type="text" class="form-control" id="addressline1" name="addressline1" size="45"
                                            placeholder="Địa chỉ (*)" value="${loggedCustomer.addressLine1}">
                                    </div>
                                    
                                    
                                   
                                    
                                    <div class="col-md-12 form-group">                                      
                                        <button type="submit" value="submit" class="btn_3">
                                            Cập nhật tài khoản 
                                        </button>
                                       
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--================login_part end =================-->
    </main>
    
        <!-- Footer Start-->
 	<%@ include file="/includes/footer.jsp"%>
</body>
    
</html>