 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html class="no-js" lang="zxx">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Thanh toán - EBookStore</title>
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
             <h1 class="text-center">Hóa đơn thanh toán</h1> <br> <br>
              <div class="check_title">           
              	<c:if test="${message != null}">
                	<h2 class="text-center" style="color: red;">${message}</h2>
                </c:if>
                
                <c:set var="cart" value="${sessionScope['cart']}" />
                
                <c:if test="${cart.totalItems == 0}">
					<h2 class="text-center" style="color: red;">Không có đơn hàng trong giỏ hàng</h2>
		        </c:if>    
              </div>
            
             
            </div>
           
            <div class="billing_details">
              <div class="row">
                <div class="col-lg-8">
                  <h3>Địa chỉ thanh toán</h3>
                  <form class="row contact_form" id="orderForm" action="place_order" method="post">
                    <div class="col-md-6 form-group p_star">
                      <input type="text" class="form-control" name="fullname" value="${loggedCustomer.fullname}" placeholder="Tên đầy đủ"/>
                    </div>
                   
                    <div class="col-md-6 form-group p_star">
                      <input type="text" class="form-control" name="phone" value="${loggedCustomer.phone}" placeholder="Số điện thoại"/>
                    </div>
                   
                    <div class="col-md-12 form-group">
                      <input type="text" class="form-control" name="addressLine1" value="${loggedCustomer.addressLine1}" placeholder="Địa chỉ" />
                    </div>
                    
                    
                    
                   
                   
                  
                </div>
                <div class="col-lg-4">
                  <div class="order_box">
                    <h2>Đơn hàng của bạn</h2>
                    <ul class="list">
                     
                      <c:forEach items="${cart.items}" var="item">
                      <li>
                        <a href="#">${item.key.name}
                          <span class="middle">x ${item.value}</span>
                          <span class="last">${item.key.price} VND</span>
                        </a>
                      </li>      
                      
                      </c:forEach>
                     
                    </ul>
                    <ul class="list list_2">
                      <li>
                        <a href="#">Tổng phụ
                          <span>${cart.totalAmount} VND</span>
                        </a>
                      </li>
                      <li>
                        <a href="#">Phí vận chuyển
                          <span>${shippingFee} VND</span>
                        </a>
                      </li>
                      
                      <li>
                        <a href="#">Tổng cộng
                          <span>${total} VND</span>
                        </a>
                      </li>
                    </ul>
                    
                      <div class="payment_item">
                      <div class="radion_btn">
                        <input type="radio" id="f-option5" name="selector" />
                        <label for="f-option5">Chọn thẻ thanh toán</label>
                        <select name="paymentMethod" class="form-select">
							<option value="Cash On Delivery">Cash On Delivery</option>
							
						</select>
                      </div>
                   
                    </div>
                    <br><br>
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <button class="btn primary checkout_btn_1" type="submit">Hoàn tất thanh toán</button>
                  </div>
                </div>
              </div>
              </form>
            </div>
          </div>
        </section>
        <!--================End Checkout Area =================-->
    </main>
    <footer>
        <!-- Footer Start-->
 <%@include file="/includes/footer.jsp"%>
    </footer>
    <!--? Search model Begin -->
    <div class="search-model-box">
        <div class="h-100 d-flex align-items-center justify-content-center">
            <div class="search-close-btn">+</div>
            <form class="search-model-form" action="search" method="get">
                <input type="text" id="search-input" placeholder="Search for anything....." name="keyword" size="50" >
            </form>
        </div>
    </div>
    <!-- Search model end -->
    
    <!-- JS here -->
    	<script type="text/javascript">
	
		$(document).ready(function() {
			$("#orderForm").validate({
				rules: {
					firstname: "required",
					lastname: "required",
					phone: "required",
					addressLine1: "required",
					addressLine2: "required",
					city: "required",
					state: "required",
					zipcode: "required",
					country: "required",
				},
				
				messages: {
					firstname: "Please enter first name",
					lastname: "Please enter last name",
					phone: "Please enter phone number",
					addressLine1: "Please enter street addressLine1",
					addressLine2: "Please enter street addressLine1",
					city: "Please enter city",
					state: "Please enter state",
					zipcode: "Please enter zip code",
					country: "Please enter country",					
				}
				
			});

		});
	</script>

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