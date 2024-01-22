package com.tuvu.admin.order;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.tuvu.dao.BookDAO;
import com.tuvu.entity.Book;
import com.tuvu.entity.BookOrder;
import com.tuvu.entity.OrderDetail;

/**
 * Servlet implementation class AddBookToOrderServlet
 */
@WebServlet("/admin/add_book_to_order")
public class AddBookToOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddBookToOrderServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		int bookId = Integer.parseInt(request.getParameter("bookId"));
		int quantity = Integer.parseInt(request.getParameter("quantity"));

		BookDAO bookDao = new BookDAO();
		Book book = bookDao.get(bookId);

		HttpSession session = request.getSession();
		BookOrder order = (BookOrder) session.getAttribute("order");

		float subtotal = quantity * book.getPrice();

		OrderDetail orderDetail = new OrderDetail();
		orderDetail.setBook(book);
		orderDetail.setQuantity(quantity);
		orderDetail.setSubtotal(subtotal);

		float newTotal = order.getTotal() + subtotal;
		order.setTotal(newTotal);

		order.getOrderDetails().add(orderDetail);

		request.setAttribute("book", book);
		session.setAttribute("NewBookPendingToAddToOrder", true);

		String resultPage = "add_book_result.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(resultPage);
		dispatcher.forward(request, response);
	}

}
