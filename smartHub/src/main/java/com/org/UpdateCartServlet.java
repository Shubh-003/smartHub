package com.org;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateCartServlet")
public class UpdateCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public UpdateCartServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
        String action = request.getParameter("action"); // "update" or "remove"
        int cartId = Integer.parseInt(request.getParameter("cart_id"));

        try (Connection con = DBConnection.getConnection()) {

            if ("update".equalsIgnoreCase(action)) {
                String qtyParam = request.getParameter("quantity");
                if (qtyParam != null && !qtyParam.isEmpty()) {
                    int quantity = Integer.parseInt(qtyParam);
                    try (PreparedStatement ps = con.prepareStatement("UPDATE cart SET quantity=? WHERE cart_id=?")) {
                        ps.setInt(1, quantity);
                        ps.setInt(2, cartId);
                        ps.executeUpdate();
                    }
                }

            } else if ("remove".equalsIgnoreCase(action)) {
                try (PreparedStatement ps = con.prepareStatement("DELETE FROM cart WHERE cart_id=?")) {
                    ps.setInt(1, cartId);
                    ps.executeUpdate();
                }
            }

            // Redirect back to cart page after operation
            response.sendRedirect("cart.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // optional, for error handling
        }
    }
}