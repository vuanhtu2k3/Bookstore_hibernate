<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE unspecified PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>EBookStore</title>
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
         <br>
          <div class="row">
              <div class="card card-plain">
                <div class="card-header">
                           
                  <h4 class="font-weight-bolder">Cập nhật đơn hàng</h4>               
                </div>
            
                <p class="text-center" style="color: red;">${message }</p> <br>
                <div class="card-body">
                <form action="update_order" method="post" id="orderForm">
                  	<label>Khách hàng:</label>
                  	<div class="input-group input-group-outline mb-3">  
                      <input type="text" value="${order.customer.fullname}" class="form-control" readonly="readonly"/>
                    </div>
                     <label>Ngày đặt hàng:</label>
                    <div class="input-group input-group-outline mb-3">  
                      <input type="text" value="${order.orderDate}" class="form-control" readonly="readonly"/>
                    </div>
                    
                    <label>Tên đầy đủ:</label>
                    <div class="input-group input-group-outline mb-3">  
                      <input type="text" id="firstname" name="firstname" value="${order.fullname}" size="45" class="form-control" placeholder="First Name"/>
                    </div>
                    
                    
                    
                    <label>Số điện thoại:</label>
                    <div class="input-group input-group-outline mb-3">  
                      <input type="text" id="phone" name="phone" value="${order.phone}" size="45" class="form-control" placeholder="Phone"/>
                    </div>
                    <label>Địa chỉ:</label>
                    <div class="input-group input-group-outline mb-3">  
                      <input type="text" id="addressLine1" name="addressLine1" value="${order.addressLine1}" size="45" class="form-control" placeholder="Address Line 1"/>
                    </div>
                    
                    
                    
                    
                    <label>Phương thức thanh toán:</label>
                    <div class="input-group input-group-outline mb-3">  
                     <select name="paymentMethod"  class="form-select">
						<option value="Cash On Delivery" <c:if test="${order.paymentMethod eq 'Cash On Delivery' }">selected='selected'</c:if> >Cash On Delivery</option>
						<option value="PayPal" <c:if test="${order.paymentMethod eq 'PayPal' }">selected='selected'</c:if>>PayPal</option>
					</select>
                    </div>
                    
                    <label>Trạng thái đơn hàng:</label>
                    <div class="input-group input-group-outline mb-3">  
                     <select name="orderStatus"  class="form-select">
						<option value="Processing" <c:if test="${order.status eq 'Processing' }">selected='selected'</c:if> >Đang xử lý</option>
						<option value="Shipping" <c:if test="${order.status eq 'Shipping' }">selected='selected'</c:if>>Đang vận chuyển</option>
						<option value="Delivered" <c:if test="${order.status eq 'Delivered' }">selected='selected'</c:if>>Đã giao hàng</option>
						<option value="Completed" <c:if test="${order.status eq 'Completed' }">selected='selected'</c:if>>Đã hoàn thành </option>
						<option value="Cancelled" <c:if test="${order.status eq 'Cancelled' }">selected='selected'</c:if>>Đã hủy</option>
					</select>
                    </div>
                    
                    <div align="center">
				<h3>Đặt hàng sách</h3>
		<table class="table table-striped table-hover">
			  <thead>
			    <tr>
			      <th scope="col">Mã sách</th>
			      <th scope="col">Tên sách</th>
			      <th scope="col">Tác giả</th>
			      <th scope="col">Giá</th>
			      <th scope="col">Số lượng</th>
			      <th scope="col">Tổng</th>
			      <th scope="col">Phí vận chuyển</th>
			      <th scope="col">Hành động</th>
			    </tr>
			  </thead>
			  <tbody>
			  <c:forEach items="${order.orderDetails}" var="orderDetail" varStatus="status">
			    <tr>
			      	<td>${status.index + 1}</td>
					<td>${orderDetail.book.name}</td>
					<td>${orderDetail.book.author}</td>
					<td><input type="hidden" name="price" value="${orderDetail.book.price}" />
						${orderDetail.book.price} VND</td>
					<td>
						<input type="hidden" name="bookId" value="${orderDetail.book.bookId}" />
						<input type="text" name="quantity${status.index + 1}" value="${orderDetail.quantity}" size="3" />
					</td>
					<td>${orderDetail.subtotal} VND</td>
					<td><input type="text" size="3" name="shippingFee" id="shippingFee" value="${order.shippingFee }" /></td>
					<td><a href="remove_book_from_order?id=${orderDetail.book.bookId}">Xóa</a></td>
			    </tr>			   
			   </c:forEach>
			    <tr>
			    
				<td align="center">
					<b><i>Tổng:</i></b>
				</td>
				<td>
					<b>${order.bookCopies}</b>
				</td>
				<td>
					<b>${order.total} VND</b>
				</td>
				<td>
					<a style="color: blue;" href="javascript:showAddBookPopup()"><b>Thêm mặt hàng</b></a>
				</td>
				<td></td>
			</tr>
			  </tbody>
	</table>
	</div>
                   
                    <div class="text-center">
                    
                      <button type="submit" class="btn btn-lg bg-gradient-warning">Gửi</button> &nbsp;&nbsp;&nbsp;
                      <button type="button" class="btn btn-lg bg-gradient-warning " onclick="javascript:window.location.href='list_order';">Hủy</button>
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
<script>
		function showAddBookPopup() {
			var width = 600;
			var height = 250;
			var left = (screen.width - width) / 2;
			var top = (screen.height - height) / 2;
			
			window.open('add_book_form', '_blank', 
					'width=' + width + ', height=' + height + ', top=' + top + ', left=' + left);
		}
		
		$(document).ready(function() {
			$("#orderForm").validate({
				rules: {	
					firstname: "required",
					lastname: "required",
					phone: "required",
					city: "required",
					zipcode: "required",
					state: "required",
					country: "required",
					addressLine1: "required",
					addressLine2: "required",
					
					<c:forEach items="${order.orderDetails}" var="book" varStatus="status">
						quantity${status.index + 1}: {
							required: true, number: true, min: 1
						},
					</c:forEach>	
						
					shippingFee: {required: true, number: true, min: 0},
					tax: {required: true, number: true, min: 0}
				},
				
				messages: {
					firstname: "Please enter first name",
					lastname: "Please enter last name",
					phone: "Please enter phone",
					zipcode: "Please enter zipcode",
					state: "Please enter state",
					city: "Please enter city",
					country: "Please select country",
					addressLine1: "Please enter address line 1",
					addressLine2: "Please enter address line 2",
					
					<c:forEach items="${order.orderDetails}" var="book" varStatus="status">
						quantity${status.index + 1}: { 
							required: "Please enter quantity",
							number: "Quantity must be a number",
							min: "Quantity must be greater than 0"
						},
					</c:forEach>	
						
						shippingFee: {
							required: "Please enter shipping fee",
							number: "Shipping fee must be a number",
							min: "Shipping fee must be greater than 0"
						},
						
						tax: {
							required: "Please enter tax",
							number: "Tax must be a number",
							min: "Tax must be greater than 0"
						}
				}
			});
			
		});		
	</script>
</html>