 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html class="no-js" lang="zxx">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>EBooksStore</title>
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
			<h1 class="text-center">Giỏ hàng của bạn</h1> <br>
			
			<c:if test="${message != null}">
				<div align="center">
					<h3 style="color: red;">${message}</h3>
				</div>
			</c:if>
			
			<c:set var="cart" value="${sessionScope['cart']}" />
			
			<c:if test="${cart.totalItems == 0}">
				<h2 class="text-center">Không có vật phẩm nào trong giỏ hàng</h2>
			</c:if>
		
        <div class="container">
        
         <c:if test="${cart.totalItems > 0}">
         <form action="update_cart" method="post" id="cartForm">
          <div class="cart_inner">
            <div class="table-responsive">        
              <table class="table">
                <thead>
                  <tr>
                  <th scope="col">Số thứ tự</th> 
                    <th scope="col">Sách</th>                   
                    <th scope="col">Giá</th>
                    <th scope="col">Số lượng</th>
                    <th scope="col">Tổng cộng</th>
                    <th scope="col">Hành động</th>
                  </tr>
                  <style>
  table th {
    text-transform: uppercase;
    font-size: 14px;
  }
</style>
                </thead>
                <tbody>
                <c:forEach items="${cart.items}" var="item" varStatus="status" >
                  <tr>
                  <td>${status.index + 1}</td>
                    <td>
                      <div class="media">
                        <div class="d-flex">
                          
                            
                          <img class="cart-thumbnail" src="images/${item.key.getImage()}" alt="${item.key.getName()} Image">
                </div>
                <style>
    .cart-thumbnail {
        width: 50px; /* Adjust the width as needed */
        height: auto; /* Maintain aspect ratio */
        border: 1px solid #ccc; /* Optional border for styling */
        margin-right: 10px; /* Optional margin for spacing */
    }
</style>
                        
                        </div>
                        <div class="media-body">
                          <p id="book-title">${item.key.name}</p>
                        </div>
                     
                    </td>
                    <td>
                      <h5>${item.key.price}</h5>
                    </td>
                    <td>
                      <div class="product_count">
                       <input type="hidden" name="bookId" value="${item.key.bookId}" />
                       <input type="text" name="quantity${status.index + 1}" value="${item.value}" size="5" />
                      </div>
                    </td>
                    <td>
                      <h5> ${item.value * item.key.price} VND</h5>
                    </td>
                    <td><a style="color: red;" href="remove_from_cart?book_id=${item.key.bookId}">Xóa</a></td>
                  </tr>
                
                  </c:forEach>
                  <tr class="bottom_button">
                    <td>
                      <button class="btn primary" type="submit">Cập nhật giỏ hàng</button>
                    </td>
                    <td></td>
                    <td></td>
                    <td>
                      <div class="cupon_text float-right">
                      <input class="btn primary" type="button" id="clearCart" value="Xóa tất cả mặt hàng"/>
                      </div>
                    </td>
                  </tr>
                  <tr>
                    <td></td>
                    <td></td>
                    <td><h5>Vật phẩm:  ${cart.totalQuantity} cuốn sách</h5></td> <br>
                    <td>
                      <h5>Tổng:  ${cart.totalAmount} VND</h5>
                    </td>
                    
                  </tr>
                 
                </tbody>
              </table>
              <div class="checkout_btn_inner float-right">
                <a class="btn primary" href="${pageContext.request.contextPath}/">Tiếp tục mua sắm</a>
                <a class="btn primary checkout_btn_1" href="checkout">Vui lòng thanh toán</a>
              </div>
            </div>
          </div>
          </form>
          </c:if>

      <!--================End Cart Area =================-->
    </main>
    <footer>
        <!-- Footer Start-->
 <%@include file="/includes/footer.jsp"%>
        <!-- Footer End-->
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
			$("#clearCart").click(function() {
				window.location = 'clear_cart';
			});
			
			$("#cartForm").validate({
				rules : {
					<c:forEach items="${cart.items}" var="item" varStatus="status">
						quantity${status.index + 1}: {
							required: true, number: true, min: 1
						},
					</c:forEach>
				},

				messages : {
					<c:forEach items="${cart.items}" var="item" varStatus="status">
						quantity${status.index + 1}: { 
							required: "Vui lòng nhập số lượng",
							number: "Số lượng phải là một con số",
							min: "Số lượng phải lớn hơn 0"
						},
					</c:forEach>					
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