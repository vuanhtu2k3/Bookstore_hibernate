package com.tuvu.service;



import java.io.IOException;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.tuvu.dao.UserDAO;
import com.tuvu.entity.Users;

public class UserServices {
	private UserDAO userDAO;
	private HttpServletRequest request;
	private HttpServletResponse response;

	public UserServices(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
		userDAO = new UserDAO();
	}

	public void listUser() throws ServletException, IOException {
		listUser(null);
	}

	public void listUser(String message) throws ServletException, IOException {
		List<Users> listUsers = userDAO.listAll();

		request.setAttribute("listUsers", listUsers);

		if (message != null) {
			request.setAttribute("message", message);
		}

		String listPage = "user_list.jsp";
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(listPage);

		requestDispatcher.forward(request, response);

	}

	public void createUser() throws ServletException, IOException {
		String email = request.getParameter("email");
		String fullName = request.getParameter("fullName");
		String password = request.getParameter("password");

		Users existUser = userDAO.findByEmail(email);

		if (existUser != null) {
			String message = "Email " + email + " đã tồn tại";
			request.setAttribute("message", message);
			RequestDispatcher dispatcher = request.getRequestDispatcher("sign_up.jsp");
			dispatcher.forward(request, response);
		} else {
			Users newUser = new Users(email, fullName, password);
			userDAO.create(newUser);
			listUser("Người dùng được tạo mới thành công");
		}

	}

	public void editUser() throws ServletException, IOException {
		int userId = Integer.parseInt(request.getParameter("id"));
		Users user = userDAO.get(userId);

		String destPage = "sign_up.jsp";

		if (user == null) {
			destPage = "message.jsp";
			String errorMessage = "Không thể tìm kiếm người dùng với ID " + userId;
			request.setAttribute("message", errorMessage);
		} else {
			request.setAttribute("user", user);
		}

		RequestDispatcher requestDispatcher = request.getRequestDispatcher(destPage);
		requestDispatcher.forward(request, response);
	}

	public void updateUser() throws ServletException, IOException {
		int userId = Integer.parseInt(request.getParameter("userId"));
		String email = request.getParameter("email");
		String fullName = request.getParameter("fullName");
		String password = request.getParameter("password");

		Users userById = userDAO.get(userId);

		Users userByEmail = userDAO.findByEmail(email);

		if (userByEmail != null && userByEmail.getUserId() != userById.getUserId()) {
			String message = "Email " + email + "đã tồn tại.";
			request.setAttribute("message", message);
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("sign_up.jsp");
			requestDispatcher.forward(request, response);

		} else {
			userById.setEmail(email);
			userById.setFullName(fullName);
			if (password != null && !password.isEmpty()) {
				userById.setPassword(password);
			}

			userDAO.update(userById);
			String message = "Người dùng được cập nhật thành công";
			listUser(message);
		}
	}

	public void deleteUser() throws ServletException, IOException {
		int userId = Integer.parseInt(request.getParameter("id"));
		
		Users user = userDAO.get(userId);
		String message = "User has been deleted successfully";
		
		if (user == null) {
			message = "Không thể tìm thấy người dùng có ID" + userId
					+ ", hoặc nó có thể đã bị quản trị viên khác xóa";
			
			request.setAttribute("message", message);
			request.getRequestDispatcher("sign_up.jsp").forward(request, response);			
		} else {
			userDAO.delete(userId);
			listUser(message);
		}		
	}

	public void login() throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		boolean loginResult = userDAO.checkLogin(email, password);
		
		if (loginResult) {
			request.getSession().setAttribute("useremail", email);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/");
			dispatcher.forward(request, response);
			
		} else {
			String message = "Tài khoản hoặc mật khẩu không chính xác";
			request.setAttribute("message", message);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("sign_in.jsp");
			dispatcher.forward(request, response);			
		}
	}
}
