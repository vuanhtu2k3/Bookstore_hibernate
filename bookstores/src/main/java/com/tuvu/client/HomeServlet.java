package com.tuvu.client;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tuvu.dao.BookDAO;
import com.tuvu.entity.Book;

@WebServlet("/index.jsp")
public class HomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public HomeServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		BookDAO bookDAO = new BookDAO();

		List<Book> listNewBooks = bookDAO.listNewBooks();
		List<Book> listFavoredBooks = bookDAO.listMostFavoredBooks();
		
		request.setAttribute("listNewBooks", listNewBooks);
		request.setAttribute("listFavoredBooks", listFavoredBooks);
		
	
		String homePage = "client/index.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(homePage);
		dispatcher.forward(request, response);
	}

}
