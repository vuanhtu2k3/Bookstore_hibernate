<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html>
<head>
    <link rel="shortcut icon" type="image/x-icon" href="assets/img/icon.jpeg">
    <meta charset="UTF-8">
    <%@ include file="/includes/header.jsp"%>
    <title>E-BookStore</title>
    <style>
        .product-content {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            margin: 0 -1%; /* Compensate for negative margin */
        }

        .card {
            width: 85%; /* Set the width to distribute cards evenly */
            margin: 1%; /* Add some margin between cards */
            display: flex;
            flex-direction: column;
            align-items: center; /* Center items horizontally */
            text-align: center; /* Center text content */
            border: 1px solid #ddd; /* Add border for better separation */
            box-sizing: border-box; /* Include padding in width calculation */
        }

        .card img {
            width: 100%; /* Make images fill the entire width of the card */
            height: auto; /* Maintain aspect ratio */
            border-bottom: 1px solid #ddd; /* Add a border between image and text content */
            padding: 10px; /* Add padding to separate image and text content */
        }

        .card-text {
            padding: 10px; /* Add padding to text content */
        }

        .button-container {
            margin-top: 10px; /* Add margin to separate buttons from text content */
        }
    </style>
</head>
<body>
    <%@ include file="/includes/navbar.jsp"%>
    <div class="container">
        <div class="card-header my-3">Tất cả sản phẩm</div>
        <div class="product-content">
            <c:forEach items="${listNewBooks}" var="book">
                <div class="col-md-4 my-3">
                    <div class="card">
                        <img src="images/${book.getImage()}" alt="${book.getName()} Image">
                        <div class="card-text">
                            <h5 class="card-title"><i>${book.getName()}</i></h5>
                            <h6 class="author">Tác giả: <i>${book.getAuthor()}</i></h6>
                            <h6 class="category">Giá: <i>${book.getPrice()} VND</i></h6>
                            <div class="button-container mt">
                               <a class="btn btn-dark" href="add_to_cart?book_id=${book.bookId}">Thêm vào giỏ hàng</a>
                 
                                <a class="btn btn-primary" href="view_book?id=${book.bookId}">Chi tiết</a>
                                <div><jsp:directive.include file="book_rating.jsp" /></div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
         		
				<style>
        /* Add this style for the button */
        .view-btn1 {
            background-color: red; /* Initial background color */
            color: #fff; /* Initial text color */
            padding: 15px 30px; /* Adjust padding for size */
            border-radius: 8px; /* Add border-radius for rounded corners */
            text-transform: uppercase; /* Make text uppercase */
            font-weight: bold; /* Add font weight for emphasis */
            transition: background-color 0.3s ease; /* Add transition for a smooth effect */
        }

        .view-btn1:hover {
            background-color: red; /* Change to your desired hover color */
        }

        .view-btn1.clicked {
            background-color: #ff0000; /* Change to red when clicked */
            color: #fff; /* Change to your desired text color when clicked */
        }
    </style>
    <script>
        // Add this script to handle button click
        document.addEventListener('DOMContentLoaded', function() {
            var bestSellingBtn = document.getElementById('bestSellingBtn');

            bestSellingBtn.addEventListener('click', function() {
                bestSellingBtn.classList.toggle('clicked');
            });
        });
    </script>


<div class="row justify-content-center">
    <div class="room-btn pt-70">
        <a href="${pageContext.request.contextPath}/" id="bestSellingBtn" class="btn view-btn1">Sách bán chạy nhất</a>
    </div>
</div>
                <br>
                <div class="row">
							<c:forEach items="${listFavoredBooks}" var="book">
								<div class="col-md-4 my-3">
                    <div class="card">
                        <img src="images/${book.getImage()}" alt="${book.getName()} Image">
                        <div class="card-text">
                            <h5 class="card-title"><i>${book.getName()}</i></h5>
                            <h6 class="author">Tác giả: <i>${book.getAuthor()}</i></h6>
                            <h6 class="category">Giá: <i>${book.getPrice()} VND</i></h6>
                            <div class="button-container mt">
                                <a class="btn btn-dark" href="#">Thêm vào giỏ hàng</a>
                                <a class="btn btn-primary" href="#">Mua ngay</a>
                                <div><jsp:directive.include file="book_rating.jsp" /></div>
                            </div>
                        </div>
                    </div>
                </div>
							</c:forEach>
						</div>
                
                
            </div>
    	<%@ include file="/includes/footer.jsp"%>
    	<script src="./assets/js/vendor/modernizr-3.5.0.min.js"></script>
    <!-- Jquery, Popper, Bootstrap -->
    
   
</body>
</html>
