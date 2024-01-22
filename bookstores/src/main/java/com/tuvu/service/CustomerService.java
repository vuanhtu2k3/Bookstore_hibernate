package com.tuvu.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import com.tuvu.dao.CustomerDAO;
import com.tuvu.entity.Customer;
import static com.tuvu.common.Utitlity.*;

public class CustomerService {

	private CustomerDAO customerDAO;
	private HttpServletRequest request;
	private HttpServletResponse response;

	public CustomerService(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
		this.customerDAO = new CustomerDAO();
	}

	public void listCustomers(String message) throws ServletException, IOException {
		List<Customer> listCustomer = customerDAO.listAll();
		request.setAttribute("listCustomer", listCustomer);
		forwardToPage("customer_list.jsp", message, request, response);
	}

	public void listCustomers() throws ServletException, IOException {
		listCustomers(null);
	}

	public void createCustomer() throws ServletException, IOException {
		String email = request.getParameter("email");
		Customer existCustomer = customerDAO.findByEmail(email);

		if (existCustomer != null) {
			String message = "Không thể tạo khách hàng mới: the email " + email
					+ " đã được đăng ký bởi một khách hàng khác.";
			listCustomers(message);

		} else {
			Customer newCustomer = new Customer();
			updateCustomerFieldsFromForm(newCustomer);
			customerDAO.create(newCustomer);

			String message = "Khách hàng mới đã được tạo thành công.";
			listCustomers(message);

		}

	}

	private void updateCustomerFieldsFromForm(Customer customer) {
		String email = request.getParameter("email");
		String fullname = request.getParameter("fullname");
		String password = request.getParameter("password");
		String phone = request.getParameter("phone");
		String address1 = request.getParameter("addressline1");
		
		if (email != null && !email.equals("")) {
			customer.setEmail(email);
		}

		customer.setFullname(fullname);

		if (password != null && !password.isEmpty()) {
			
			customer.setPassword(password);
		}

		customer.setPhone(phone);
		customer.setAddressLine1(address1);
		
	}

	public void editCustomer() throws ServletException, IOException {
		Integer customerId = Integer.parseInt(request.getParameter("id"));
		Customer customer = customerDAO.get(customerId);
		
	

		if (customer == null) {
			String message = "Không thể tìm thấy khách hàng có ID" + customerId;
			showMessageBackend(message, request, response);
		} else {
			request.setAttribute("customer", customer);
			forwardToPage("customer_form.jsp", request, response);
		}
	}

	public void updateCustomer() throws ServletException, IOException {
	    Integer customerId = Integer.parseInt(request.getParameter("customerId"));
	    String email = request.getParameter("email");

	    Customer customerByEmail = customerDAO.findByEmail(email);
	    String message = null;

	    if (customerByEmail != null && customerByEmail.getCustomerId() != customerId) {
	        message = "Không thể cập nhật ID khách hàng" + customerId
	                + " vì hiện có một khách hàng có cùng email.";
	    } else {
	        Customer customerById = customerDAO.get(customerId);

	        String fullname = request.getParameter("fullname");
	        if (fullname != null) {
	            customerById.setFullname(new String(fullname.getBytes("ISO-8859-1"), "UTF-8"));
	        } else {
	        
	        }

	        updateCustomerFieldsFromForm(customerById);

	        customerDAO.update(customerById);

	        message = "Khách hàng đã được cập nhật thành công.";
	    }

	    listCustomers(message);
	}



	public void deleteCustomer() throws ServletException, IOException {
		

	}

	public void registerCustomer() throws ServletException, IOException {
		String email = request.getParameter("email");
		Customer existCustomer = customerDAO.findByEmail(email);
		String message = "";

		if (existCustomer != null) {
			message = "The email " + email + " đã tồn tại.";
		} else {

			Customer newCustomer = new Customer();
			updateCustomerFieldsFromForm(newCustomer);
			customerDAO.create(newCustomer);

			message = "Bạn đã đăng ký thành công!";
		}

		showMessageFrontend(message, request, response);
	}

	public void showLogin() throws ServletException, IOException {
		forwardToPage("client/login.jsp", request, response);
	}

	public void doLogin() throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");

		Customer customer = customerDAO.checkLogin(email, password);

		if (customer == null) {
			String message = "Tài khoản hoặc mật khẩu không chính xác.";
			request.setAttribute("message", message);
			showLogin();

		} else {
			HttpSession session = request.getSession();
			session.setAttribute("loggedCustomer", customer);

			Object objRedirectURL = session.getAttribute("redirectURL");

			if (objRedirectURL != null) {
				String redirectURL = (String) objRedirectURL;
				session.removeAttribute("redirectURL");
				
				response.sendRedirect(redirectURL);
			} else {
			    String successMessage = "Đăng nhập thành công!";
		        request.setAttribute("successMessage", successMessage);
		        showCustomerProfile();
			}
		}
	}

	public void showCustomerProfile() throws ServletException, IOException {
	   
	    RequestDispatcher dispatcher = request.getRequestDispatcher("client/customer_profile.jsp");


	    dispatcher.forward(request, response);
	}


	public void updateCustomerProfile() throws ServletException, IOException {
		Customer customer = (Customer) request.getSession().getAttribute("loggedCustomer");
		updateCustomerFieldsFromForm(customer);
		customerDAO.update(customer);

		showCustomerProfile();

	}

	public void newCustomer() throws ServletException, IOException {


		String customerForm = "customer_form.jsp";
		request.getRequestDispatcher(customerForm).forward(request, response);

	}

}
