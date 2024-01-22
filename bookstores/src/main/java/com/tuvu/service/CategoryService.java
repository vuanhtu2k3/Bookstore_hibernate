package com.tuvu.service;

import static com.tuvu.common.Utitlity.*;

import java.io.IOException;
import java.util.List;

import javax.persistence.EntityManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tuvu.dao.BookDAO;
import com.tuvu.dao.CategoryDAO;
import com.tuvu.entity.Category;

public class CategoryService {
	private CategoryDAO categoryDAO;
	private HttpServletRequest request;
	private HttpServletResponse response;
	
	public CategoryService(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
		
		categoryDAO = new CategoryDAO();
	}
	
	public void listCategory(String message) throws ServletException, IOException {
		List<Category> listCategory = categoryDAO.listAll();
		
		request.setAttribute("listCategory", listCategory);
		
		forwardToPage("category_list.jsp", request, response);				
	}
	
	public void listCategory() throws ServletException, IOException {
		listCategory(null);
	}
	
	public void createCategory() throws ServletException, IOException {
		String name = request.getParameter("name");
		Category existCategory = categoryDAO.findByName(name);
		
		if (existCategory != null) {
			String message = "Không thể tạo danh mục."
					+ " Một danh mục có tên " + name + " đã tồn tại.";
			showMessageBackend(message, request, response);
		} else {
			Category newCategory = new Category(name);
			categoryDAO.create(newCategory);
			String message = "Danh mục mới được tạo thành công.";
			listCategory(message);
		}
	}
	
	public void editCategory() throws ServletException, IOException {
		int categoryId = Integer.parseInt(request.getParameter("id"));
		Category category = categoryDAO.get(categoryId);
		
		if (category != null) {
			request.setAttribute("category", category);
			forwardToPage("category_form.jsp", request, response);
		} else {
			String message = "Không thể tìm thấy danh mục có ID:" + categoryId;
			showMessageBackend(message, request, response);
		}
		
	}

	public void updateCategory() throws ServletException, IOException {
		int categoryId = Integer.parseInt(request.getParameter("categoryId"));
		String categoryName = request.getParameter("name");
		
		Category categoryById = categoryDAO.get(categoryId);
		Category categoryByName = categoryDAO.findByName(categoryName);
		
		if (categoryByName != null && categoryById.getCategoryId() != categoryByName.getCategoryId()) {
			String message = "Không thể cập nhật danh mục."
					+ " Một danh mục có tên " + categoryName + "đã tồn tại.";
			
			showMessageBackend(message, request, response);			
		} else {
			categoryById.setName(categoryName);
			categoryDAO.update(categoryById);
			String message = "Danh mục đã được cập nhật thành công";
			listCategory(message);
		}
	}

	public void deleteCategory() throws ServletException, IOException {
		int categoryId = Integer.parseInt(request.getParameter("id"));
		String message;
		
		Category category = categoryDAO.get(categoryId);
		
		if (category == null) {
			message = "Không thể tìm thấy danh mục có ID " + categoryId
					+ ", hoặc nó có thể đã bị xóa";
			showMessageBackend(message, request, response);
			return;
		}
		
		BookDAO bookDAO = new BookDAO();
		long numberOfBooks = bookDAO.countByCategory(categoryId);
				
		if (numberOfBooks > 0) {
			message = "Không thể xóa danh mục (ID: %d)bởi vì nó hiện chứa một số cuốn sách.";
			message = String.format(message, numberOfBooks);
		} else {
			categoryDAO.delete(categoryId);		
			message = "Danh mục có ID " + categoryId + " đã được gỡ bỏ thành công.";
		}
		
		listCategory(message);
		
	}
	
}
