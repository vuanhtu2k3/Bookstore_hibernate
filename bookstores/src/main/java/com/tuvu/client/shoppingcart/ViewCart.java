package com.tuvu.client.shoppingcart;


	import java.io.IOException;

	import javax.servlet.RequestDispatcher;
	import javax.servlet.ServletException;
	import javax.servlet.annotation.WebServlet;
	import javax.servlet.http.HttpServlet;
	import javax.servlet.http.HttpServletRequest;
	import javax.servlet.http.HttpServletResponse;

	/**
	 * Servlet implementation class ViewCartServlet
	 */
	@WebServlet("/view_cart")
	public class ViewCart  extends HttpServlet {
		private static final long serialVersionUID = 1L;

		/**
		 * @see HttpServlet#HttpServlet()
		 */
		public ViewCart() {
			super();
			// TODO Auto-generated constructor stub
		}

		/**
		 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
		 *      response)
		 */
		protected void doGet(HttpServletRequest request, HttpServletResponse response)
				throws ServletException, IOException {
			Object cartObject = request.getSession().getAttribute("cart");

			if (cartObject == null) {
				ShoppingCart shoppingCart = new ShoppingCart();
				request.getSession().setAttribute("cart", shoppingCart);
			}

			String cartPage = "client/shopping_cart.jsp";
			RequestDispatcher dispatcher = request.getRequestDispatcher(cartPage);
			dispatcher.forward(request, response);
		}

}
