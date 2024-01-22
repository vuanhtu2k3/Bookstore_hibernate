 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>	
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
  <h2 style="margin-top: 30px;"class="text-center">Mô tả sách  ${book.name}</h2>
      <!--================Blog Area =================-->
      <section class="blog_area single-post-area section-padding">
         <div class="container">
            <div class="row">
               <div class="col-lg-8 posts-list">
                  <div class="single-post">
                     <div class="feature-img">
                     <img style="height: 360px;"src="images/${book.getImage()}" alt="${book.getName()} Image">
                     </div>
                     <div class="blog_details">
                        <h2>${book.name}</h2>
                        <div><jsp:directive.include file="book_rating.jsp" /></div>
                        <ul class="blog-info-link mt-3 mb-4">
                           <li><a style="color: blue;" href="#"><i class="fa fa-user"></i> viết bởi ${book.author}</a></li>
                           <li><a style="color: red;" href="#"><i class="fa fa-comments"></i>${fn:length(book.reviews)} đánh giá</a></li>
                        </ul>
                        
                         <p class="excert">
                           ${book.description}
                        </p>
                       
                       
                     </div>
                  </div>
                                 
                  <div class="comments-area">
                     <h4>Đánh giá từ khách hàng</h4>
                     <c:forEach items="${book.reviews}" var="review">
                     <div class="comment-list">
                        <div class="single-comment justify-content-between d-flex">
                           <div class="user justify-content-between d-flex">
                             
                             
                             
                             		<c:forTokens items="${review.stars}" delims="," var="star">
										<c:if test="${star eq 'on'}">
											<img src="images/rating_on.png" style="width: 20px; height: 20px;" />
										</c:if>
										<c:if test="${star eq 'off'}">
											<img src="images/rating_on.png" style="width: 20px; height: 20px;" />
										</c:if>
									</c:forTokens>
									
									&nbsp;&nbsp;&nbsp;
                              <div class="desc">
                                 <p class="comment">
                                    - <b>${review.headline}</b>
                                 </p>
                                 <div class="d-flex justify-content-between">
                                    <div class="d-flex align-items-center">
                                       <h5>
                                          <a href="#" style="color: red;">by ${review.customer.fullname}</a>
                                       </h5>
                                      
                                    </div>
                                   
                                 </div>
                                 <p class="comment">
                                   <i>${review.comment}</i>
                                 </p>
                              </div>
                             
                              
                           </div>
                        </div>
                     </div>
                     </c:forEach>
                    
                  </div>
                        <div class="form-group">
                           <button type="submit" class="button button-contactForm btn_1 boxed-btn" id="buttonWriteReview">Viết bình luận của bạn</button>
                        </div>                   
               </div>
               <div class="col-lg-4" style="margin-top: 180px; ">
                  <div class="blog_right_sidebar">
                     <aside class="single_sidebar_widget search_widget">                   
                             <h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Giá: ${book.price} VND</h4>
                           <button class="button rounded-0 primary-bg text-white w-100 btn_1 boxed-btn" id="buttonAddToCart">Thêm vào giỏ hàng</button>                       
                     </aside>
                    
                  </div>
               </div>
            </div>
         </div>
      </section>
      <!--================ Blog Area end =================-->
   </main>
   <footer>
      <!-- Footer Start-->
   <%@include file="/includes/footer.jsp"%>
      <!-- Footer End-->
   </footer>
      <!--? Search model Begin -->
   
    <!-- Search model end -->
  
   <!-- JS here -->
   <script type="text/javascript">
		$(document).ready(function() {
			$("#buttonWriteReview").click(function() {
				window.location = 'write_review?book_id=' + ${book.bookId};
			});
			
			$("#buttonAddToCart").click(function() {
				window.location = 'add_to_cart?book_id=' + ${book.bookId};
			});				
		});
	</script>
	
      <script src="./assets/js/vendor/modernizr-3.5.0.min.js"></script>
		<!-- Jquery, Popper, Bootstrap -->
		<script src="./assets/js/vendor/jquery-1.12.4.min.js"></script>
      <script src="./assets/js/popper.min.js"></script>
      <script src="./assets/js/bootstrap.min.js"></script>
      <!-- Jquery Mobile Menu -->
      <script src="./assets/js/jquery.slicknav.min.js"></script>

		<!-- Jquery Slick , Owl-Carousel Plugins -->
      <script src="./assets/js/owl.carousel.min.js"></script>
      <script src="./assets/js/slick.min.js"></script>
      <!-- Date Picker -->
		<!-- One Page, Animated-HeadLin -->
      <script src="./assets/js/wow.min.js"></script>
		<script src="./assets/js/animated.headline.js"></script>
      <script src="./assets/js/jquery.magnific-popup.js"></script>

		<!-- Scrollup, nice-select, sticky -->
      <script src="./assets/js/jquery.scrollUp.min.js"></script>
      <script src="./assets/js/jquery.nice-select.min.js"></script>
		<script src="./assets/js/jquery.sticky.js"></script>
        
      <!-- contact js -->
      <script src="./assets/js/jquery.form.js"></script>
      <script src="./assets/js/jquery.validate.min.js"></script>
      <script src="./assets/js/mail-script.js"></script>
      <script src="./assets/js/jquery.ajaxchimp.min.js"></script>
        
		<!-- Jquery Plugins, main Jquery -->	
      <script src="./assets/js/plugins.js"></script>
      <script src="./assets/js/main.js"></script>
      
</body>

</html>