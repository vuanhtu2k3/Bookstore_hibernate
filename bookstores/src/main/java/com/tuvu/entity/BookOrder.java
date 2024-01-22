package com.tuvu.entity;

import static javax.persistence.GenerationType.IDENTITY;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import com.tuvu.entity.BookOrder;
@Entity
@Table(name = "book_order", catalog = "bookstores")
@NamedQueries({
		@NamedQuery(name = "BookOrder.findAll", query = "SELECT bo FROM BookOrder bo ORDER BY bo.orderDate DESC"),
		@NamedQuery(name = "BookOrder.countAll", query = "SELECT COUNT(*) FROM BookOrder"),
		@NamedQuery(name = "BookOrder.findByCustomer", query = "SELECT bo FROM BookOrder bo WHERE bo.customer.customerId =:customerId ORDER BY bo.orderDate DESC"),
		@NamedQuery(name = "BookOrder.findByIdAndCustomer", query = "SELECT bo FROM BookOrder bo WHERE bo.orderId =:orderId AND bo.customer.customerId =:customerId"),
		@NamedQuery(name = "BookOrder.countByCustomer", query = "SELECT COUNT(bo.orderId) FROM BookOrder bo WHERE bo.customer.customerId =:customerId") })

public class BookOrder implements java.io.Serializable  {
	private static final long serialVersionUID = 1L;
	private Integer orderId;
	private Customer customer;
	private Date orderDate;
	private String addressLine1;
	private String fullname;
	private String phone;
	private String paymentMethod;
	private float total;
	private float subtotal;
	private float shippingFee;
	private String status;
	private Set<OrderDetail> orderDetails = new HashSet<OrderDetail>(0);
	
	public BookOrder() {
	}

	
	
	public BookOrder(Integer orderId, Customer customer, Date orderDate, String addressLine1, String fullname, String phone,
			String paymentMethod, float total, float subtotal, float shippingFee, String status,
			Set<OrderDetail> orderDetails) {
		super();
		this.orderId = orderId;
		this.customer = customer;
		this.orderDate = orderDate;
		this.addressLine1 = addressLine1;
		this.fullname = fullname;
		this.phone = phone;
		this.paymentMethod = paymentMethod;
		this.total = total;
		this.subtotal = subtotal;
		this.shippingFee = shippingFee;
		this.status = status;
		this.orderDetails = orderDetails;
	}
	@Id
	@GeneratedValue(strategy = IDENTITY)

	@Column(name = "order_id", unique = true, nullable = false)
	public Integer getOrderId() {
		return orderId;
	}
	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "customer_id", nullable = false)
	public Customer getCustomer() {
		return customer;
	}
	public void setCustomer(Customer customer) {
		this.customer = customer;
	}
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "order_date", nullable = false, length = 19)
	public Date getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}
	@Column(name = "address", nullable = false, length = 20)
	public String getAddressLine1() {
		return addressLine1;
	}
	public void setAddressLine1(String addressLine1) {
		this.addressLine1 = addressLine1;
	}
	@Column(name = "fullname", nullable = false, length = 30)
	public String getFullname() {
		return fullname;
	}
	public void setFullname(String fullname) {
		this.fullname = fullname;
	}
	@Column(name = "phone", nullable = false, length = 15)
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	@Column(name = "payment_method", nullable = false, length = 20)
	public String getPaymentMethod() {
		return paymentMethod;
	}
	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}
	@Column(name = "total", nullable = false, precision = 12, scale = 0)
	public float getTotal() {
		return total;
	}
	public void setTotal(float total) {
		this.total = total;
	}
	@Column(name = "subtotal", nullable = false, precision = 12, scale = 0)
	public float getSubtotal() {
		return subtotal;
	}
	public void setSubtotal(float subtotal) {
		this.subtotal = subtotal;
	}
	@Column(name = "shipping_fee", nullable = false, precision = 12, scale = 0)
	public float getShippingFee() {
		return shippingFee;
	}
	public void setShippingFee(float shippingFee) {
		this.shippingFee = shippingFee;
	}
	@Column(name = "status", nullable = false, length = 20)
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	@OneToMany(fetch = FetchType.EAGER, mappedBy = "bookOrder", cascade = CascadeType.ALL, orphanRemoval = true)
	public Set<OrderDetail> getOrderDetails() {
		return orderDetails;
	}
	public void setOrderDetails(Set<OrderDetail> orderDetails) {
		this.orderDetails = orderDetails;
	}
	@Transient
	public int getBookCopies() {
		int total = 0;

		for (OrderDetail orderDetail : orderDetails) {
			total += orderDetail.getQuantity();
		}

		return total;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((orderId == null) ? 0 : orderId.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		BookOrder other = (BookOrder) obj;
		if (orderId == null) {
			if (other.orderId != null)
				return false;
		} else if (!orderId.equals(other.orderId))
			return false;
		return true;
	}


}
