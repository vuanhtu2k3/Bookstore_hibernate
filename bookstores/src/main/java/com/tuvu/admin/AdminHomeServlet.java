package com.tuvu.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tuvu.entity.Book;
import com.tuvu.dao.BookDAO;
import com.tuvu.dao.CustomerDAO;
import com.tuvu.dao.OrderDAO;
import com.tuvu.dao.ReviewDAO;
import com.tuvu.dao.UserDAO;
import com.tuvu.entity.BookOrder;
import com.tuvu.entity.Review;


@WebServlet("/admin/")
public class AdminHomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public AdminHomeServlet() {
        super();      
    }

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		UserDAO userDao = new UserDAO();
		OrderDAO orderDao = new OrderDAO();
		ReviewDAO reviewDao = new ReviewDAO();
		BookDAO bookDao = new BookDAO();
		CustomerDAO customerDao = new CustomerDAO();
		
		long totalUsers = userDao.count();
		long totalBooks = bookDao.count();
		long totalCustomers = customerDao.count();
		long totalReviews = reviewDao.count();
		long totalOrders = orderDao.count();
		
		request.setAttribute("totalUsers", totalUsers);
		request.setAttribute("totalBooks", totalBooks);
		request.setAttribute("totalCustomers", totalCustomers);
		request.setAttribute("totalReviews", totalReviews);
		request.setAttribute("totalOrders", totalOrders);
		
		List<BookOrder> listMostRecentSales = orderDao.listMostRecentSales();
		List<Review> listMostRecentReviews = reviewDao.listMostRecent();
		List<Book> listBestSellingBooks = bookDao.listBestSellingBooks();
		List<Book> listFavoredBooks = bookDao.listMostFavoredBooks();
		
  
		
		request.setAttribute("listBestSellingBooks", listBestSellingBooks);
		request.setAttribute("listFavoredBooks", listFavoredBooks);
		request.setAttribute("listMostRecentSales", listMostRecentSales);
		request.setAttribute("listMostRecentReviews", listMostRecentReviews);
		
		
		String homePage = "index.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(homePage);
		dispatcher.forward(request, response);
	}

}
