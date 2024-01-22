package com.tuvu.entity;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name ="review",catalog="bookstores")
@NamedQueries({	
	@NamedQuery(
		name = "Review.mostFavoredBooks",
		query = "SELECT r.book, COUNT(r.book.bookId) AS ReviewCount, AVG(r.rating) AS AvgRating "
				+ "FROM Review r "
				+ "GROUP BY r.book.bookId "
				+ "HAVING AVG(r.rating) >= 3.0 "
				+ "ORDER BY ReviewCount DESC, AvgRating DESC"
	),
	@NamedQuery(name = "Review.findByCustomerAndBook", 
	query = "SELECT r FROM Review r WHERE r.customer.customerId =:customerId"
			+ " AND r.book.bookId =:bookId"),
	@NamedQuery(name = "Review.listAll", query = "SELECT r FROM Review r"),
	@NamedQuery(name = "Review.countAll", query = "SELECT COUNT(r) FROM Review r")
})

public class Review {
	
private Integer review_id;
private Book book;
private Customer customer;
private int rating;
private String headline;
private String comment;

@Id
@GeneratedValue(strategy = IDENTITY)

@Column(name = "review_id", unique = true, nullable = false)
public Integer getReview_id() {
	return review_id;
}
public void setReview_id(Integer review_id) {
	this.review_id = review_id;
}
@ManyToOne(fetch = FetchType.EAGER)
@JoinColumn(name = "book_id", nullable = false)
public Book getBook() {
	return book;
}
public void setBook(Book book) {
	this.book = book;
}
@ManyToOne(fetch = FetchType.EAGER)
@JoinColumn(name = "customer_id", nullable = false)
public Customer getCustomer() {
	return customer;
}
public void setCustomer(Customer customer) {
	this.customer = customer;
}
@Column(name = "rating", nullable = false)
public int getRating() {
	return rating;
}
public void setRating(int rating) {
	this.rating = rating;
}
@Column(name = "headline", nullable = false, length = 128)
public String getHeadline() {
	return headline;
}
public void setHeadline(String headline) {
	this.headline = headline;
}
@Column(name = "comment", nullable = false, length = 500)
public String getComment() {
	return comment;
}
public void setComment(String comment) {
	this.comment = comment;
}
@Transient
public String getStars() {
	String result = "";
	
	int numberOfStarsOn = (int) rating;
	
	for (int i = 1; i <= numberOfStarsOn; i++) {
		result += "on,";
	}
	
	for (int j = numberOfStarsOn + 1; j <= 5; j++) {
		result += "off,";
	}
	
	return result.substring(0, result.length() - 1);
}	
}
