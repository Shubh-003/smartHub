package com.org;


import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public CartServlet() {
        super();
    }


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId"); // must be set during login

        if (userId == null) {
            response.sendRedirect("logIn.jsp");
            return;
        }

        int prodId = Integer.parseInt(request.getParameter("prodId"));
        double discountPrice = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();

            // ✅ Get product MRP (since discountPrice is passed)
            ps = con.prepareStatement("SELECT prod_mrp FROM products WHERE prodId = ?");
            ps.setInt(1, prodId);
            rs = ps.executeQuery();
            double mrp = 0.0;
            if (rs.next()) {
                mrp = rs.getDouble("prod_mrp");
            }
            rs.close();
            ps.close();

            // ✅ Check if item already exists in cart
            ps = con.prepareStatement("SELECT quantity FROM cart WHERE user_id=? AND product_id=?");
            ps.setInt(1, userId);
            ps.setInt(2, prodId);
            rs = ps.executeQuery();

            if (rs.next()) {
                // If already in cart → update quantity
                int existingQty = rs.getInt("quantity");
                ps = con.prepareStatement(
                        "UPDATE cart SET quantity=? WHERE user_id=? AND product_id=?");
                ps.setInt(1, existingQty + quantity);
                ps.setInt(2, userId);
                ps.setInt(3, prodId);
                ps.executeUpdate();
            } else {
                // Insert new product into cart
                ps = con.prepareStatement(
                        "INSERT INTO cart (user_id, product_id, quantity, mrp, discount_price) VALUES (?,?,?,?,?)");
                ps.setInt(1, userId);
                ps.setInt(2, prodId);
                ps.setInt(3, quantity);
                ps.setDouble(4, mrp);
                ps.setDouble(5, discountPrice);
                ps.executeUpdate();
            }

            // Redirect back to cart page
            response.sendRedirect("cart.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }	
		
	}

}
