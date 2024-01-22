package com.tuvu.service;

import com.tuvu.entity.Category;


import static com.tuvu.common.Utitlity.forwardToPage;
import static com.tuvu.common.Utitlity.showMessageBackend;
import static com.tuvu.common.Utitlity.showMessageFrontend;


import java.io.IOException;
import java.io.InputStream;
import java.util.Base64;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.tuvu.dao.OrderDAO;
import com.tuvu.dao.BookDAO;
import com.tuvu.dao.CategoryDAO;
import com.tuvu.entity.Book;

public class BookService {
	
		private BookDAO bookDAO;
		private CategoryDAO categoryDAO;
		private HttpServletRequest request;
		private HttpServletResponse response;

		public BookService(HttpServletRequest request, HttpServletResponse response) {
			this.request = request;
			this.response = response;
			bookDAO = new BookDAO();
			categoryDAO = new CategoryDAO();
		}

		public void listBooks() throws ServletException, IOException {
			listBooks(null);
		}
		
		public void listBooks(String message) throws ServletException, IOException {
			List<Book> listBooks = bookDAO.listAll();
			request.setAttribute("listBooks", listBooks);
			
			if (message != null) {
				request.setAttribute("message", message);
			}
			
			forwardToPage("book_list.jsp", message, request, response);
		}
		public void showBookNewForm() throws ServletException, IOException {
			List<Category> listCategory = categoryDAO.listAll();
			request.setAttribute("listCategory", listCategory);
			forwardToPage("book_form.jsp", request, response);
		}

		
		public void listBooksByCategory() throws ServletException, IOException {
			int categoryId = Integer.parseInt(request.getParameter("id"));
			Category category = categoryDAO.get(categoryId);
			
			if (category == null) {
				String message = "Xin lỗi, ID danh mục " + categoryId + " không có sẵn.";
				showMessageFrontend(message, request, response);			
				return;
			}
			
			List<Book> listBooks = bookDAO.listByCategory(categoryId);
			
			request.setAttribute("listBooks", listBooks);
			request.setAttribute("category", category);
			
			forwardToPage("client/books_list_by_category.jsp", request, response);	
		}
		
		public void createBook() throws ServletException, IOException {
			String name = request.getParameter("name");
			
			Book existBook = bookDAO.findByName(name);
			
			if (existBook != null) {
				String message = "Không thể tạo sách mới vì tên sách '"
						+ name + "' đã tồn tại.";
				listBooks(message);
				return;
			}
			
			Book newBook = new Book();
			readBookFields(newBook);
			
			Book createdBook = bookDAO.create(newBook);
			
			if (createdBook.getBookId() > 0) {
				String message = "Một cuốn sách mới đã được tạo thành công.";
				listBooks(message);
			}
		}

		public void readBookFields(Book book) throws ServletException, IOException {
		    String name = request.getParameter("name");
		    String author = request.getParameter("author");
		    String priceParam = request.getParameter("price");

		    try {
		        if (priceParam != null && !priceParam.trim().isEmpty()) {
		            float price = Float.parseFloat(priceParam);
		            book.setName(name);
		            book.setAuthor(author);
		            book.setPrice(price);

		            Integer categoryId = Integer.parseInt(request.getParameter("category"));
		            Category category = categoryDAO.get(categoryId);
		            book.setCategory(category);

		            try {
		                Part part = request.getPart("bookImage");

		                if (part != null && part.getSize() > 0) {
		                    try (InputStream inputStream = part.getInputStream()) {
		                        byte[] imageBytes = inputStream.readAllBytes();
		                        String base64Image = Base64.getEncoder().encodeToString(imageBytes);
		                        book.setImage(base64Image);
		                    } catch (IOException e) {
		                        e.printStackTrace();
		                        System.out.println("Error reading image input stream");
		                    }
		                } else {
		                    // Set a default or fallback image URL
		                    book.setImage("https://tse1.mm.bing.net/th?id=OIP.xqYunaXLEIiIBgbHGncjBQHaHa&pid=Api&P=0&h=180");
		                    System.out.println("No image provided. Using default image.");
		                }
		            } catch (NumberFormatException e) {
		                e.printStackTrace();
		                System.out.println("Invalid price format");
		            }
		        }
		    } catch (NumberFormatException e) {
		        e.printStackTrace();
		        System.out.println("Invalid price format");
		    }
		}
		
		
		public void editBook() throws ServletException, IOException {
			Integer bookId = Integer.parseInt(request.getParameter("id"));
			Book book = bookDAO.get(bookId);
			
			if (book != null) {
				List<Category> listCategory = categoryDAO.listAll();
				
				request.setAttribute("book", book);
				request.setAttribute("listCategory", listCategory);
				forwardToPage("book_form.jsp", request, response);
			} else {
				String message = "Không thể tìm thấy sách có ID " + bookId;
				showMessageBackend(message, request, response);			
			}
			
		}

		public void updateBook() throws ServletException, IOException {
			Integer bookId = Integer.parseInt(request.getParameter("bookId"));
			String name = request.getParameter("name");
			
			Book existBook = bookDAO.get(bookId);
			Book bookByName = bookDAO.findByName(name);
			
			if (bookByName != null && !existBook.equals(bookByName)) {
				String message = "Không thể cập nhật sách vì có một cuốn sách khác có cùng tên.";
				listBooks(message);
				return;
			}
			
			readBookFields(existBook);
			
			bookDAO.update(existBook);
			
			String message = "Sách đã được cập nhật thành công.";
			listBooks(message);
		}

		public void deleteBook() throws ServletException, IOException {
			Integer bookId = Integer.parseInt(request.getParameter("id"));
			Book book =  bookDAO.get(bookId);
			
			if (book == null) {
				String message = "Không thể tìm thấy sách có ID" + bookId
						+ ", hoặc có thể nó đã bị xóa";
				showMessageBackend(message, request, response);
				
			} else {			
				if (!book.getReviews().isEmpty()) {
					String message = "Không thể xóa sách có ID " + bookId
							+ "vì có đánh giá";
					showMessageBackend(message, request, response);
				} else {
					OrderDAO orderDAO = new OrderDAO();
					long countByOrder = orderDAO.countOrderDetailByBook(bookId);
					
					if (countByOrder > 0) {
						String message = "Không thể xóa sách có ID" + bookId
								+ "vì có mệnh lệnh gắn liền với nó.";
						showMessageBackend(message, request, response);
					} else {
						String message = "Cuốn sách được xóa thành công.";
						bookDAO.delete(bookId);			
						listBooks(message);
					}
				}
			}
		}

		
		
public void viewBookDetail() throws ServletException, IOException {
	Integer bookId = Integer.parseInt(request.getParameter("id"));
	Book book = bookDAO.get(bookId);
	
	if (book != null) {
		request.setAttribute("book", book);
		forwardToPage("client/book_detail.jsp", request, response);
	} else {			
		String message = "Xin lỗi, cuốn sách có ID" + bookId + " không có sẵn.";
		showMessageFrontend(message, request, response);			
	}
}
}

