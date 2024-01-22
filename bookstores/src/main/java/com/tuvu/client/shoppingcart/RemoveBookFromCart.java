package com.tuvu.client.shoppingcart;


	import java.io.IOException;
	import javax.servlet.ServletException;
	import javax.servlet.annotation.WebServlet;
	import javax.servlet.http.HttpServlet;
	import javax.servlet.http.HttpServletRequest;
	import javax.servlet.http.HttpServletResponse;
import com.tuvu.entity.Book;

@WebServlet("/remove_from_cart")
	public class RemoveBookFromCart extends HttpServlet {
		private static final long serialVersionUID = 1L;
	       
	    /**
	     * @see HttpServlet#HttpServlet()
	     */
	    public RemoveBookFromCart() {
	        super();
	        // TODO Auto-generated constructor stub
	    }

	    protected void doGet(HttpServletRequest request, HttpServletResponse response)
				throws ServletException, IOException {
			Integer bookId = Integer.parseInt(request.getParameter("book_id"));
			
			Object cartObject = request.getSession().getAttribute("cart");
			
			ShoppingCart shoppingCart =  (ShoppingCart) cartObject;
			
			shoppingCart.removeItem(new Book(bookId));
			
			String cartPage = request.getContextPath().concat("/view_cart");
			response.sendRedirect(cartPage);
		}
	
	}


