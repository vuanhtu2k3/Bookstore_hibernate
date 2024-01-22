package com.tuvu.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import static com.tuvu.common.Utitlity.*;

import com.tuvu.dao.BookDAO;
import com.tuvu.dao.ReviewDAO;
import com.tuvu.entity.Book;
import com.tuvu.entity.Customer;
import com.tuvu.entity.Review;

public class ReviewService {
	private ReviewDAO reviewDAO;
	private HttpServletRequest request;
	private HttpServletResponse response;
	
	public ReviewService(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
		this.reviewDAO = new ReviewDAO();
	}
	
	public void listAllReview() throws ServletException, IOException {
		listAllReview(null);
	}
	
	public void listAllReview(String message) throws ServletException, IOException {
		List<Review> listReviews = reviewDAO.listAll();
		
		request.setAttribute("listReviews", listReviews);
		forwardToPage("review_list.jsp", message, request, response);		
	}

	public void editReview() throws ServletException, IOException {
		Integer reviewId = Integer.parseInt(request.getParameter("id"));
		Review review = reviewDAO.get(reviewId);
		
		if (review != null) {		
			request.setAttribute("review", review);		
			forwardToPage("review_form.jsp", request, response);
		} else {
			String message = "Không thể tìm thấy bài đánh giá có ID" + reviewId;
			showMessageBackend(message, request, response);
		}
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
	}
	
	public void updateReview() throws ServletException, IOException {
		Integer reviewId = Integer.parseInt(request.getParameter("reviewId"));
		String headline = request.getParameter("headline");
		String comment = request.getParameter("comment");
		
		Review review = reviewDAO.get(reviewId);
		review.setHeadline(headline);
		review.setComment(comment);
		
		reviewDAO.update(review);
		
		String message = "Đánh giá đã được cập nhật thành công.";
		
		listAllReview(message);
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
	}
	
	public void deleteReview() throws ServletException, IOException {
		Integer reviewId = Integer.parseInt(request.getParameter("id"));
		Review review = reviewDAO.get(reviewId);
		
		if (review != null) {
			reviewDAO.delete(reviewId);
			String message = "Đánh giá đã được xóa thành công.";
			listAllReview(message);
		} else {
			String message = "Bạn có thể tìm thấy đánh giá với ID" + reviewId
					+ ", hoặc có thể nó đã bị quản trị viên khác xóa";
			showMessageBackend(message, request, response);
		}		
	}

	public void showReviewForm() throws ServletException, IOException {
		Integer bookId = Integer.parseInt(request.getParameter("book_id"));
		BookDAO bookDao = new BookDAO();
		Book book = bookDao.get(bookId);
		
		HttpSession session = request.getSession(); 
		session.setAttribute("book", book);
		
		Customer customer = (Customer) session.getAttribute("loggedCustomer");
		
		Review existReview = reviewDAO.findByCustomerAndBook(customer.getCustomerId(), bookId);
		
		String targetPage = "client/review_form.jsp";
		
		if (existReview != null) {
			request.setAttribute("review", existReview);
			targetPage = "client/review_info.jsp";
		}

		forwardToPage(targetPage, request, response);	
	}

	public void submitReview() throws ServletException, IOException {
		Integer bookId = Integer.parseInt(request.getParameter("bookId"));
		Integer rating = Integer.parseInt(request.getParameter("rating"));
		String headline = request.getParameter("headline");
		String comment = request.getParameter("comment");
		
		Review newReview = new Review();
		newReview.setHeadline(headline);
		newReview.setComment(comment);
		newReview.setRating(rating);
		
		Book book = new Book();
		book.setBookId(bookId);
		newReview.setBook(book);
		
		Customer customer = (Customer) request.getSession().getAttribute("loggedCustomer");
		newReview.setCustomer(customer);
		
		reviewDAO.create(newReview);
		
		forwardToPage("client/review_done.jsp", request, response);		
	}

}
