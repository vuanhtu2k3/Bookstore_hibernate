<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html class="no-js" lang="zxx">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Hóa đơn thanh toán - EBooksStore</title>
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
    <link rel="stylesheet" href="assets/css/style.css">
    <script type="text/javascript" src="./assets/js/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="./assets/js/jquery.validate.min.js"></script>
</head>
<body>
   
 <%@include file="/includes/header.jsp"%>
 <header>
        <!-- Header Start -->
	<jsp:directive.include file="/includes/navbar.jsp" />
        <!-- Header End -->

    </header>     
          <main>
       
          <!--================Checkout Area =================-->
        <section class="checkout_area">
          <div class="container">
            <div class="returning_customer">
              <div class="check_title">
                <h2 class="text-center">
                Bạn đã thanh toán thành công. Cảm ơn bạn đã mua hàng!
                </h2>
              </div>
             
            </div>
          <br>
            <div class="billing_details ">
              <div class="row">
              <h2>Biên nhận thanh toán của bạn</h2>
              <table class="table table-hover">
				<tr>
					<td><b>Tên đầy đủ </b></td>
					<td>${payer.firstName}</td>
				</tr>		
							
				<tr>
					<td><b>Email: </b></td>
					<td>${payer.email}</td>
				</tr>
										
			</table>
			
			<h2>Chi tiết đặt hàng</h2>
              <table class="table table-hover">
				<tr>
					<td><b>Mã đặt hàng </b></td>
					<td>${orderId}</td>
				</tr>		
				<tr>
					<td><b>Tên khách hàng </b></td>
					<td>${loggedCustomer.fullname}</td>
				</tr>	
				<tr>
					<td><b>Description: </b></td>
					<td>${transaction.description}</td>
				</tr>
					
			</table>
                
                <table border="1" cellpadding="5" class="table table-striped">
				<tr>
					<th>Số thứ tự</th>
					<th>Tên</th>
					<th>Số lượng</th>
					<th>Giá</th>
					<th>Tổng cộng</th>
				</tr>
				<c:forEach items="${transaction.itemList.items}" var="item" varStatus="status">
				<tr>
					<td>${status.index + 1}</td>
				<td>${item.name}</td>
				<td>${item.quantity}</td>
				<td>${item.price} VND</td>
				<td>${item.quantity * item.price} VND</td>

				</tr>
				</c:forEach>
				<tr>
				<td>
				Giá gốc::
					<b>${transaction.amount.details.subtotal} VND</b>
				</td>
				<td>
						Phí vận chuyển:
					<b>${transaction.amount.details.shipping}VND</b>
				</td>
				<td>
				<b><i>Tổng cộng:</i></b>
					<b>${transaction.amount.total}VND</b>
				</td>
			</tr>
			</table>
            </div>
           
          </div>
        </section>
        <!--================End Checkout Area =================-->
    </main>
    <footer>
        <!-- Footer Start-->
<%@include file="/includes/footer.jsp"%>
        <!-- Footer End-->
    </footer>
    <!--? Search model Begin -->
    
    <!-- Search model end -->
    
    <!-- JS here -->

    <script src="./assets/js/vendor/modernizr-3.5.0.min.js"></script>
    <!-- Jquery, Popper, Bootstrap -->
    
    <script src="./assets/js/popper.min.js"></script>
    <script src="./assets/js/bootstrap.min.js"></script>
    <!-- Jquery Mobile Menu -->
    <script src="./assets/js/jquery.slicknav.min.js"></script>

    <!-- Jquery Slick , Owl-Carousel Plugins -->
    <script src="./assets/js/owl.carousel.min.js"></script>
    <script src="./assets/js/slick.min.js"></script>

    <!-- One Page, Animated-HeadLin -->
    <script src="./assets/js/wow.min.js"></script>
    <script src="./assets/js/animated.headline.js"></script>
    
    <!-- Scroll up, nice-select, sticky -->
    <script src="./assets/js/jquery.scrollUp.min.js"></script>
    <script src="./assets/js/jquery.nice-select.min.js"></script>
    <script src="./assets/js/jquery.sticky.js"></script>
    <script src="./assets/js/jquery.magnific-popup.js"></script>

    <!-- contact js -->
    <script src="./assets/js/contact.js"></script>
    <script src="./assets/js/jquery.form.js"></script>
    <script src="./assets/js/mail-script.js"></script>
    <script src="./assets/js/jquery.ajaxchimp.min.js"></script>
    
    <!-- Jquery Plugins, main Jquery -->	
    <script src="./assets/js/plugins.js"></script>
    <script src="./assets/js/main.js"></script>

</body>
    
</html>