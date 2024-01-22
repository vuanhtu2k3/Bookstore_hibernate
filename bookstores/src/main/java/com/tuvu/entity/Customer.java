package com.tuvu.entity;

import static javax.persistence.GenerationType.IDENTITY;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

@Entity
@Table(name = "customer", catalog = "bookstores", uniqueConstraints = @UniqueConstraint(columnNames = "email"))
@NamedQueries({ @NamedQuery(name = "Customer.findAll", query = "SELECT c FROM Customer c "),
		@NamedQuery(name = "Customer.countAll", query = "SELECT COUNT(c.email) FROM Customer c"),
		@NamedQuery(name = "Customer.findByEmail", query = "SELECT c FROM Customer c WHERE c.email = :email"),
		@NamedQuery(name = "Customer.checkLogin", query = "SELECT c FROM Customer c WHERE c.email = :email AND c.password = :password") })
public class Customer implements java.io.Serializable {
	private static final long serialVersionUID = 1L;
private Integer customerId;
private String email;
private String password;
private String fullname;
private String addressLine1;
private String phone;

private Set<Review> reviews = new HashSet<Review>(0);
public Customer() {
}

public Customer(Integer customerId, String email,String password, String fullname, String addressLine1, String phone, Set<Review> reviews) {
	super();
	this.customerId = customerId;
	this.email = email;
	this.password = password;
	this.fullname = fullname;
	this.addressLine1 = addressLine1;
	this.phone = phone;
	this.reviews = reviews;
}

@Id
@GeneratedValue(strategy = IDENTITY)

@Column(name = "customer_id", unique = true, nullable = false)
public Integer getCustomerId() {
	return customerId;
}
public void setCustomerId(Integer customerId) {
	this.customerId = customerId;
}
@Column(name = "email", unique = true, nullable = false, length = 45)
public String getEmail() {
	return email;
}
public void setEmail(String email) {
	this.email = email;
}
@Column(name = "password", length = 45)
public String getPassword() {
	return password;
}

public void setPassword(String password) {
	this.password = password;
}

@Column(name = "fullname", nullable = false, length = 25)
public String getFullname() {
	return fullname;
}
public void setFullname(String fullname) {
	this.fullname = fullname;
}
@Column(name = "address_line1", nullable = false, length = 25)
public String getAddressLine1() {
	return addressLine1;
}
public void setAddressLine1(String addressLine1) {
	this.addressLine1 = addressLine1;
}
@Column(name = "phone", nullable = false, length = 45)
public String getPhone() {
	return phone;
}
public void setPhone(String phone) {
	this.phone = phone;
}
@OneToMany(fetch = FetchType.LAZY, mappedBy = "customer")
public Set<Review> getReviews() {
	return this.reviews;
}

public void setReviews(Set<Review> reviews) {
	this.reviews = reviews;
}

}
