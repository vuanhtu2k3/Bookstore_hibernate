package com.tuvu.client.checkout;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.tuvu.service.OrderService;
import com.tuvu.service.PaymentService;
import com.paypal.api.payments.PayerInfo;
import com.paypal.api.payments.Payment;
import com.paypal.api.payments.ShippingAddress;
import com.paypal.api.payments.Transaction;
import com.paypal.base.rest.PayPalRESTException;

/**
 * Servlet implementation class ExecutePayment
 */
@WebServlet("/proceed_payment")
public class ExcutePayment extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ExcutePayment() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		PaymentService paymentService = new PaymentService(request, response);
		try {
			Payment payment = paymentService.executePayment();
			OrderService orderService = new OrderService(request, response);
			Integer orderId = orderService.proceedPaypal(payment);
			
			HttpSession session = request.getSession();
			session.setAttribute("orderId", orderId);
			
			PayerInfo payerInfo = payment.getPayer().getPayerInfo();
			Transaction transaction = payment.getTransactions().get(0);

			request.setAttribute("payer", payerInfo);
			request.setAttribute("transaction", transaction);

			String receiptPage = "client/payment_receipt.jsp";
			request.getRequestDispatcher(receiptPage).forward(request, response);
			
		} catch (PayPalRESTException e) {
			e.printStackTrace();
			throw new ServletException("Error in executing payment.");
		}
	}

}
