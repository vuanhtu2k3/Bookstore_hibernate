package com.tuvu.service;

import static com.tuvu.common.Utitlity.*;
import java.io.IOException;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.tuvu.client.shoppingcart.ShoppingCart;
import com.tuvu.dao.OrderDAO;
import com.tuvu.entity.Book;
import com.tuvu.entity.BookOrder;
import com.tuvu.entity.Customer;
import com.tuvu.entity.OrderDetail;
import com.paypal.api.payments.ItemList;
import com.paypal.api.payments.Payment;
import com.paypal.api.payments.ShippingAddress;

public class OrderService {
	private OrderDAO orderDao;
	private HttpServletRequest request;
	private HttpServletResponse response;

	public OrderService(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
		this.orderDao = new OrderDAO();
	}

	public void listAllOrder() throws ServletException, IOException {
		listAllOrder(null);
	}

	public void listAllOrder(String message) throws ServletException, IOException {
		List<BookOrder> listOrder = orderDao.listAll();
		request.setAttribute("listOrder", listOrder);
		forwardToPage("order_list.jsp", message, request, response);
	}

	public void viewOrderDetailForAdmin() throws ServletException, IOException {
		int orderId = Integer.parseInt(request.getParameter("id"));

		BookOrder order = orderDao.get(orderId);

		if (order != null) {
			request.setAttribute("order", order);
			forwardToPage("order_detail.jsp", request, response);
		} else {
			String message = "Could not find order with ID " + orderId;
			showMessageBackend(message, request, response);
		}
	}

	public void showCheckoutForm() throws ServletException, IOException {
	    HttpSession httpSession = request.getSession();
	    ShoppingCart shoppingCart = (ShoppingCart) httpSession.getAttribute("cart");

	    if (shoppingCart != null) {
	        float shippingFee = shoppingCart.getTotalQuantity() * 1.0f;
	        float total = shoppingCart.getTotalAmount() + shippingFee;

	        httpSession.setAttribute("shippingFee", shippingFee);
	        httpSession.setAttribute("total", total);

	        forwardToPage("client/checkout.jsp", request, response);
	    } else {
	        // Handle the case where the shoppingCart is null, e.g., redirect to an error page
	        response.sendRedirect("errorPage.jsp");
	    }
	}

	public void placeOrder() throws ServletException, IOException {
		String paymentMethod = request.getParameter("paymentMethod");
		BookOrder order = readOrderInfor();

		if (paymentMethod.equals("PayPal")) {
			PaymentService paymentService = new PaymentService(request, response);
			request.getSession().setAttribute("order4Paypal", order);
			paymentService.authorizePayment(order);
		} else {
			placeOrderCOD(order);
		}

	}

	private BookOrder readOrderInfor() {
		String paymentMethod = request.getParameter("paymentMethod");
		String fullname = request.getParameter("fullname");
		String phone = request.getParameter("phone");
		String addressLine1 = request.getParameter("addressLine1");

		BookOrder order = new BookOrder();
		order.setFullname(fullname);
		order.setPhone(phone);
		order.setAddressLine1(addressLine1);
		order.setPaymentMethod(paymentMethod);

		HttpSession session = request.getSession();
		Customer customer = (Customer) session.getAttribute("loggedCustomer");
		order.setCustomer(customer);

		ShoppingCart shoppingCart = (ShoppingCart) session.getAttribute("cart");
		Map<Book, Integer> items = shoppingCart.getItems();

		Iterator<Book> iterator = items.keySet().iterator();

		Set<OrderDetail> orderDetails = new HashSet<>();

		while (iterator.hasNext()) {
			Book book = iterator.next();
			Integer quantity = items.get(book);
			float subtotal = quantity * book.getPrice();

			OrderDetail orderDetail = new OrderDetail();
			orderDetail.setBook(book);
			orderDetail.setBookOrder(order);
			orderDetail.setQuantity(quantity);
			orderDetail.setSubtotal(subtotal);
			orderDetails.add(orderDetail);

		}

		order.setOrderDetails(orderDetails);
		float shippingFee = (Float) session.getAttribute("shippingFee");
		float total = (Float) session.getAttribute("total");

		order.setSubtotal(shoppingCart.getTotalAmount());
		order.setShippingFee(shippingFee);
		order.setTotal(total);

		return order;

	}

	private void placeOrderCOD(BookOrder order) throws ServletException, IOException {
		saveOrder(order);

		String message = "Cảm ơn. Đơn đặt hàng của bạn đã được nhận; ";
		showMessageFrontend(message, request, response);

	}

	public void listOrderByCustomer() throws ServletException, IOException {
		HttpSession session = request.getSession();
		Customer customer = (Customer) session.getAttribute("loggedCustomer");
		List<BookOrder> listOrders = orderDao.listByCustomer(customer.getCustomerId());

		request.setAttribute("listOrders", listOrders);
		forwardToPage("client/order_list.jsp", request, response);
	}

	public void showOrderDetailForCustomer() throws ServletException, IOException {
		int orderId = Integer.parseInt(request.getParameter("id"));

		HttpSession session = request.getSession();
		Customer customer = (Customer) session.getAttribute("loggedCustomer");

		BookOrder order = orderDao.get(orderId, customer.getCustomerId());
		request.setAttribute("order", order);
		forwardToPage("client/order_detail.jsp", request, response);
	}

	public void showEditOrderForm() throws ServletException, IOException {
		Integer orderId = Integer.parseInt(request.getParameter("id"));
		BookOrder order = orderDao.get(orderId);

		if (order == null) {
			String message = "Could not find order with ID " + orderId;
			showMessageBackend(message, request, response);
			return;
		}

		HttpSession session = request.getSession();
		Object isPendingBook = session.getAttribute("NewBookPendingToAddToOrder");

		if (isPendingBook == null) {
			session.setAttribute("order", order);
		} else {
			session.removeAttribute("NewBookPendingToAddToOrder");
		}
		forwardToPage("order_form.jsp", request, response);
	}

	public void updateOrder() throws ServletException, IOException {
		HttpSession session = request.getSession();
		BookOrder order = (BookOrder) session.getAttribute("order");

		String fullname = request.getParameter("fullname");
		String phone = request.getParameter("phone");
		String address1 = request.getParameter("addressLine1");
		float shippingFee = Float.parseFloat(request.getParameter("shippingFee"));
		String paymentMethod = request.getParameter("paymentMethod");
		String orderStatus = request.getParameter("orderStatus");

		order.setFullname(fullname);
		
		order.setShippingFee(shippingFee);
		order.setPhone(phone);
		order.setAddressLine1(address1);
		order.setPaymentMethod(paymentMethod);
		order.setStatus(orderStatus);

		String[] arrayBookId = request.getParameterValues("bookId");
		String[] arrayPrice = request.getParameterValues("price");
		String[] arrayQuantity = new String[arrayBookId.length];

		for (int i = 1; i <= arrayQuantity.length; i++) {
			arrayQuantity[i - 1] = request.getParameter("quantity" + i);
		}

		Set<OrderDetail> orderDetails = order.getOrderDetails();
		orderDetails.clear();

		float totalAmount = 0.0f;

		for (int i = 0; i < arrayBookId.length; i++) {
			int bookId = Integer.parseInt(arrayBookId[i]);
			int quantity = Integer.parseInt(arrayQuantity[i]);
			float price = Float.parseFloat(arrayPrice[i]);

			float subtotal = price * quantity;

			OrderDetail orderDetail = new OrderDetail();
			orderDetail.setBook(new Book(bookId));
			orderDetail.setQuantity(quantity);
			orderDetail.setSubtotal(subtotal);
			orderDetail.setBookOrder(order);

			orderDetails.add(orderDetail);

			totalAmount += subtotal;
		}

		order.setSubtotal(totalAmount);
		totalAmount += shippingFee;

		order.setTotal(totalAmount);

		orderDao.update(order);

		String message = "The order " + order.getOrderId() + " has been updated successfully";

		listAllOrder(message);
	}

	public void deleteOrder() throws ServletException, IOException {
		Integer orderId = Integer.parseInt(request.getParameter("id"));

		BookOrder order = orderDao.get(orderId);

		if (order != null) {
			orderDao.delete(orderId);

			String message = "The order ID " + orderId + " has been deleted.";
			listAllOrder(message);
		} else {
			String message = "Could not find order with ID " + orderId
					+ ", or it might have been deleted by another admin.";
			showMessageBackend(message, request, response);
		}
	}

	public Integer proceedPaypal(Payment payment) {
	    BookOrder order = (BookOrder) request.getSession().getAttribute("order4Paypal");

	    ItemList itemList = payment.getTransactions().get(0).getItemList();
	    ShippingAddress shipAddress = itemList.getShippingAddress();
	    String phoneNumber = itemList.getShippingPhoneNumber();
	    String recipientName = shipAddress.getRecipientName();

	    String[] names = recipientName.split(" ");
	    order.setFullname(names[0]);
	    order.setAddressLine1(shipAddress.getLine1());
	    order.setPhone(phoneNumber);

	    return saveOrder(order);
	}


	private Integer saveOrder(BookOrder order) {
	    // Kiểm tra và đặt giá trị cho addressLine1 nếu cần
	    if (order.getAddressLine1() == null) {
	        order.setAddressLine1("Hà Nội");
	    }
	    if (order.getPhone() == null) {
	        order.setPhone("0369944444");
	    }
	    BookOrder savedOrder = orderDao.create(order);

	    ShoppingCart shoppingCart = (ShoppingCart) request.getSession().getAttribute("cart");
	    shoppingCart.clear();

	    return savedOrder.getOrderId();
	}

}
