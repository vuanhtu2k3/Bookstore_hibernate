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
    <title>Đơn hàng của tôi -  EBooksStore</title>
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
                <h3 class="text-center">
                 Chi tiết đơn hàng
                </h3>
              </div>
              
              <c:if test="${order == null}">
	              <p class="text-center" style="color: red;">
	                Rất tiếc, bạn không được phép xem đơn hàng này.
	              </p>
              </c:if>
              
            </div>
          
            <div class="billing_details ">
              <div class="row">
              
              <table class="table table-hover">
			<tr>
				<td><b>Trạng thái đơn hàng: </b></td>
				<td>${order.status}</td>
			</tr>		
			<tr>
				<td><b>Ngày đặt: </b></td>
				<td>${order.orderDate}</td>
			</tr>			
			<tr>
				<td><b>Số lượng: </b></td>
				<td>${order.bookCopies}</td>
			</tr>
			<tr>
				<td><b>Tổng : </b></td>
				<td>${order.total} VND</td>
			</tr>			
			
			<tr>
				<td><b>Tên: </b></td>
				<td>${order.fullname}</td>
			</tr>
			<tr>
				<td><b>Số điện thoại: </b></td>
				<td>${order.phone}</td>
			</tr>
			<tr>
				<td><b>Vận chuyển đến: </b></td>
				<td>${order.addressLine1}</td>
			</tr>			
			<tr>
				<td><b>Phương thức thanh toán: </b></td>
				<td>${order.paymentMethod}</td>
			</tr>
												
		</table>
                
			<table border="1" cellpadding="5" class="table table-striped">
				<tr>
					<th>Số thứ tự</th>
					<th>Sách</th>
					<th>Tác giả</th>
					<th>Giá</th>
					<th>Số lượng</th>
					<th>Tổng</th>
				</tr>
				<c:forEach items="${order.orderDetails}" var="orderDetail" varStatus="status">
				<tr>
					<td>${status.index + 1}</td>
				
            <td><img class="cart-thumbnail" src="images/${orderDetail.book.getImage()}" alt="${orderDetail.book.getImage()} Image" style="width: 50px; height: 50px;" />
        ${orderDetail.book.name}
        </td>
               
                <style>
    .cart-thumbnail {
        width: 50px; 
        height: auto; 
        border: 1px solid #ccc; 
        margin-right: 10px; 
    }
</style>

					
				
				<td>${orderDetail.book.author}</td>
				<td>${orderDetail.book.price}</td>
				<td>${orderDetail.quantity}</td>
				<td>${orderDetail.subtotal} VND</td>
				</tr>
				</c:forEach>
				<tr>
			
				<td>
				Mặt hàng
					<b>${order.bookCopies}</b>
				</td>
				<td>
						Phí vận chuyển
					<b>${order.shippingFee} VND</b>
				</td>
				<td>
				<b><i>Tổng cộng:</i></b>
					<b>${order.total} VND</b>
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
 <%@include file="/includes/footer.jsp"%>>
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