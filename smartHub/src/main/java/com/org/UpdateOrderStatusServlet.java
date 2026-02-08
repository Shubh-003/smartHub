package com.org;

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Admin/UpdateOrderStatusServlet")
public class UpdateOrderStatusServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public UpdateOrderStatusServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int orderId = Integer.parseInt(request.getParameter("order_id"));
        String status = request.getParameter("order_status");
        System.out.println(status);
        String paymentStatus = request.getParameter("status");
        System.out.println(paymentStatus);
       //  String paymentStatus = "Pending"; // default
        if ("Delivered".equalsIgnoreCase(status)) {
            paymentStatus = "Paid";
            System.out.println("e1");

        try (Connection con = DBConnection.getConnection()) {
            String sql = "UPDATE orders SET order_status=?, payment_status=? WHERE order_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, status);
            ps.setString(2, paymentStatus);
            ps.setInt(3, orderId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        }else  {
         paymentStatus = "Pending";
         System.out.println("e2");
         try (Connection con1 = DBConnection.getConnection()) {
             String sql1 = "UPDATE orders SET order_status=?, payment_status=? WHERE order_id=?";
             PreparedStatement ps1 = con1.prepareStatement(sql1);
             ps1.setString(1, status);
             ps1.setString(2, paymentStatus);
             ps1.setInt(3, orderId);
             ps1.executeUpdate();
         } catch (Exception e) {
             e.printStackTrace();
         }
        }
        response.sendRedirect("order.jsp");
    }
	

}
