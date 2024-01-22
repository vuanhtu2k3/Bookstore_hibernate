 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
	<div class="container">
		<a class="navbar-brand" href="index.jsp">E-BookStore</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
	
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item"><a class="nav-link" href="index.jsp">  <i class="fas fa-home"></i>&nbsp; Trang chủ</a></li>
				
<style>
    .submenu {
        display: none;
        position: absolute;
        background-color: #ffffff; /* Màu nền cho submenu */
        padding: 10px; /* Khoảng cách giữa các mục trong submenu */
        border: 1px solid #cccccc; /* Viền cho submenu */
    }

    /* Hiển thị danh sách thể loại khi hover vào nút "Thể loại" */
    li.nav-item:hover .submenu {
        display: block;
    }

    .submenu li {
        margin-bottom: 5px; /* Khoảng cách giữa các mục trong submenu */
    }

    .submenu a {
        color: #333333; /* Màu chữ cho các mục trong submenu */
        font-size: 12px; /* Kích thước font cho các mục trong submenu */
        text-decoration: none; /* Loại bỏ gạch chân cho liên kết */
    }

    .submenu a:hover {
        text-decoration: underline; /* Gạch chân khi di chuột qua liên kết */
    }
    .submenu a:active {
        font-size: 10px; /* Kích thước font khi click */
    }
</style>

<li class="nav-item">
    <a class="nav-link" href="#"> <i class="fa fa-list"></i>&nbsp; Thể loại</a>
    <ul class="submenu">
        <c:forEach var="category" items="${listCategory}" varStatus="status">
            <li>
                <a href="view_category?id=${category.categoryId}">
                    <font size="+1"><b><c:out value="${category.name}" /></b></font>
                </a>
            </li>
        </c:forEach>
    </ul>
</li>
<style>
    /* Hiệu ứng hover cho submenu */
    .nav-item:hover .submenu {
        display: block;
    }

    /* Style cho submenu */
    .submenu {
        display: none;
        position: absolute;
        background-color: #fff;
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
        z-index: 1;
    }

    .submenu a {
        display: block;
        padding: 10px;
        text-decoration: none;
        color: #333;
    }

    .submenu a:hover {
        background-color: #f5f5f5;
        color: red;
    }

    /* Badge style */
    .badge {
        background-color: red;
        color: white;
        border-radius: 50%;
        padding: 5px 10px;
        font-size: 12px;
        margin-left: 5px;
    }
</style>
    

				 
				<li class="nav-item"><a class="nav-link" href="view_cart">  <i class="fa fa-shopping-cart"></i>&nbsp; Giỏ hàng <span class="badge badge-danger">${cart_list.size()}</span> </a></li>
				<%
				
				%>
				<li class="nav-item"><a class="nav-link" href="view_orders"> <i class="fas fa-file-alt"></i>&nbsp; Đơn hàng</a></li>
				<c:choose>
    <c:when test="${loggedCustomer != null}">
        <li class = "nav-item">
            <a class="nav-link" href="#">
             <i class="fa fa-user"></i>&nbsp;Tài khoản</a>
            <ul class="submenu">
                <li><a href="view_profile"><i class="fa fa-user"></i>&nbsp; ${loggedCustomer.fullname}</a></li>
<li><a href="view_orders"><i class="fa fa-list-alt"></i>&nbsp;Đơn hàng của tôi</a></li>
<li><a href="logout"><i class="fa fa-sign-out"></i>&nbsp;Đăng xuất</a></li>
            </ul>                                   
        </li>
        
    </c:when>
    <c:otherwise>
        <li class="nav-item"><a class="nav-link" href="login"> <i class="fas fa-sign-in-alt"></i>&nbsp;Đăng nhập</a></li>
    </c:otherwise>
</c:choose>
				  
			</ul>
		</div>
	</div>
</nav>