package com.org;

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ProcessPaymentServlet")
public class ProcessPaymentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
    public ProcessPaymentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Integer userId = session != null ? (Integer) session.getAttribute("userId") : null;
        if (userId == null) {
            response.sendRedirect("logIn.jsp");
            return;
        }

        String paymentMethod = request.getParameter("payment_method");
        // card fields are UI-only; we don't store them
        String cardNumber = request.getParameter("card_number");
        String cardName = request.getParameter("card_name");

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false); // transaction start

            // 1) Get cart items for user and compute totals
            String cartSql = "SELECT c.product_id, c.quantity, c.mrp, c.discount_price, p.prod_name " +
                             "FROM cart c JOIN products p ON c.product_id = p.prodId WHERE c.user_id=?";
            ps = con.prepareStatement(cartSql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();

            double totalMrp = 0.0;
            double finalAmount = 0.0;
            double discountAmount = 0.0;

            // store cart rows in memory to insert into order_items later
            java.util.List<CartRow> items = new java.util.ArrayList<>();

            while (rs.next()) {
                int prodId = rs.getInt("product_id");
                int qty = rs.getInt("quantity");
                double mrp = rs.getDouble("mrp");
                double discPrice = rs.getDouble("discount_price");

                double rowMrpTotal = mrp * qty;
                double rowFinal = discPrice * qty;
                totalMrp += rowMrpTotal;
                finalAmount += rowFinal;
                discountAmount += (rowMrpTotal - rowFinal);

                items.add(new CartRow(prodId, qty, mrp, discPrice));
            }
            rs.close();
            ps.close();

            if (items.isEmpty()) {
                // no items in cart — redirect back
                response.sendRedirect("cart.jsp");
                return;
            }

            // 2) Insert into orders and get generated order_id
            String paymentStatus = "Pending";
            if ("Credit Card".equalsIgnoreCase(paymentMethod)) paymentStatus = "Paid";
            else if ("Cash On Delivery".equalsIgnoreCase(paymentMethod)) paymentStatus = "Pending";

            String insertOrder = "INSERT INTO orders (user_id, discount_amount, final_amount, payment_method, payment_status, order_status, total_amount, status) " +
                                 "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            ps = con.prepareStatement(insertOrder, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, userId);
            ps.setDouble(2, discountAmount);
            ps.setDouble(3, finalAmount);
            ps.setString(4, paymentMethod);
            ps.setString(5, paymentStatus);
            ps.setString(6, "Processing"); // order_status
            ps.setDouble(7, totalMrp);
            ps.setString(8, "Pending"); // status
            ps.executeUpdate();

            ResultSet gk = ps.getGeneratedKeys();
            int orderId = -1;
            if (gk.next()) orderId = gk.getInt(1);
            gk.close();
            ps.close();

            if (orderId == -1) throw new SQLException("Failed to create order");

            // 3) Insert order_items
            String insertItem = "INSERT INTO order_items (order_id, product_id, quantity, mrp, discount_price, total_price) VALUES (?, ?, ?, ?, ?, ?)";
            ps = con.prepareStatement(insertItem);
            for (CartRow it : items) {
                double totalPrice = it.discountPrice * it.quantity;
                ps.setInt(1, orderId);
                ps.setInt(2, it.productId);
                ps.setInt(3, it.quantity);
                ps.setDouble(4, it.mrp);
                ps.setDouble(5, it.discountPrice);
                ps.setDouble(6, totalPrice);
                ps.addBatch();
            }
            ps.executeBatch();
            ps.close();

            // 4) Clear user's cart
            ps = con.prepareStatement("DELETE FROM cart WHERE user_id=?");
            ps.setInt(1, userId);
            ps.executeUpdate();
            ps.close();

            // Commit transaction
            con.commit();

            // Redirect to success page with order id
            response.sendRedirect("orderSuccess.jsp?orderId=" + orderId);

        } catch (Exception e) {
            e.printStackTrace();
            try { if (con != null) con.rollback(); } catch (Exception ex) {}
            response.sendRedirect("paymentError.jsp");
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ignored) {}
            try { if (ps != null) ps.close(); } catch (Exception ignored) {}
            try { if (con != null) con.setAutoCommit(true); con.close(); } catch (Exception ignored) {}
        }
    }

    // helper class to hold cart rows in memory
    private static class CartRow {
        int productId;
        int quantity;
        double mrp;
        double discountPrice;
        CartRow(int p, int q, double m, double d) { productId=p; quantity=q; mrp=m; discountPrice=d; }
        }
    
	

}
