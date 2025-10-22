package com.org;

import java.io.IOException;
import java.sql.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public AdminDashboardServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection con = DBConnection.getConnection()) {
            
            // Total Products
            PreparedStatement ps1 = con.prepareStatement("SELECT COUNT(*) FROM products");
            ResultSet rs1 = ps1.executeQuery();
            rs1.next();
            int productCount = rs1.getInt(1);
            
            // Total Orders
            PreparedStatement ps2 = con.prepareStatement("SELECT COUNT(*) FROM orders");
            ResultSet rs2 = ps2.executeQuery();
            rs2.next();
            int orderCount = rs2.getInt(1);
            
            // Total Customers
            PreparedStatement ps3 = con.prepareStatement("SELECT COUNT(*) FROM registration");
            ResultSet rs3 = ps3.executeQuery();
            rs3.next();
            int customerCount = rs3.getInt(1);
            
            // Total Revenue (sum of all final_amount where payment_status = 'Paid')
            PreparedStatement ps4 = con.prepareStatement("SELECT IFNULL(SUM(final_amount),0) FROM orders WHERE payment_status='Paid'");
            ResultSet rs4 = ps4.executeQuery();
            rs4.next();
            double totalRevenue = rs4.getDouble(1);
            
            // Order status breakdown for chart
            PreparedStatement ps5 = con.prepareStatement(
                "SELECT order_status, COUNT(*) FROM orders GROUP BY order_status");
            ResultSet rs5 = ps5.executeQuery();
            
            StringBuilder labels = new StringBuilder();
            StringBuilder values = new StringBuilder();
            while (rs5.next()) {
                if (labels.length() > 0) {
                    labels.append(",");
                    values.append(",");
                }
                labels.append("'").append(rs5.getString(1)).append("'");
                values.append(rs5.getInt(2));
            }
            
            request.setAttribute("productCount", productCount);
            request.setAttribute("orderCount", orderCount);
            request.setAttribute("customerCount", customerCount);
            request.setAttribute("revenue", String.format("%.2f", totalRevenue));
            request.setAttribute("orderStatusLabels", labels.toString());
            request.setAttribute("orderStatusValues", values.toString());
            
            // Forward to dashboard JSP
            RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
            rd.forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}