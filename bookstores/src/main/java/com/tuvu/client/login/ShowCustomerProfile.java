package com.tuvu.client.login;


	import java.io.IOException;
	import javax.servlet.ServletException;
	import javax.servlet.annotation.WebServlet;
	import javax.servlet.http.HttpServlet;
	import javax.servlet.http.HttpServletRequest;
	import javax.servlet.http.HttpServletResponse;

	import com.tuvu.service.CustomerService;

	/**
	 * Servlet implementation class ShowCustomerProfileServlet
	 */
	@WebServlet("/view_profile")
	public class ShowCustomerProfile  extends HttpServlet {
		private static final long serialVersionUID = 1L;
	       
	    /**
	     * @see HttpServlet#HttpServlet()
	     */
	    public ShowCustomerProfile() {
	        super();
	        // TODO Auto-generated constructor stub
	    }

		/**
		 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
		 */
		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			request.setCharacterEncoding("UTF-8");
			CustomerService customerServices = new CustomerService(request, response);
			customerServices.showCustomerProfile();
		}

		
	}

