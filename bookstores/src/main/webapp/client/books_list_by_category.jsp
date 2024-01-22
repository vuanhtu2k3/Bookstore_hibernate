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
        h2.text-center {
        margin-top: 20px;
        margin-bottom: 20px; /* Thêm khoảng cách dưới cho tiêu đề */
    }
    </style>
</head>
<body>
    <%@ include file="/includes/navbar.jsp"%>
    <div class="container">
      <h2 class="text-center">Sách trong ${category.name} - EBookStores</h2>
        <div class="product-content">
            <c:forEach items="${listBooks}" var="book">
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
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        </div>
        <%@ include file="/includes/footer.jsp"%>
        </body>
        </html>