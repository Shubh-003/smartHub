package com.org;

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Admin/DiscountServlet")
public class DiscountServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // JDBC credentials
    private static final String DB_URL = "jdbc:mysql://localhost:3306/smarthub";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "root";

    public DiscountServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/Admin/offers.jsp");
            System.out.print("Action null");
            return;
        }

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {

            if ("add".equalsIgnoreCase(action)) {
                // Read form parameters
                String name = request.getParameter("discountName");
                String category = request.getParameter("productCategory");
                int percent = Integer.parseInt(request.getParameter("discountPercent"));
                String startDate = request.getParameter("startDate");
                String endDate = request.getParameter("endDate");

                // Insert into database
                String sql = "INSERT INTO discounts (discount_name, product_category, discount_percent, start_date, end_date) "
                           + "VALUES (?, ?, ?, ?, ?)";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setString(1, name);
                    ps.setString(2, category);
                    ps.setInt(3, percent);
                    ps.setDate(4, Date.valueOf(startDate));
                    ps.setDate(5, Date.valueOf(endDate));
                    ps.executeUpdate();
//                    System.out.print("Added");
                }

            } else if ("delete".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("id"));

                String sql = "DELETE FROM discounts WHERE id=?";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setInt(1, id);
                    ps.executeUpdate();
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.print(e);
        }

        // Redirect back to offers page
//        System.out.print("Added");
        response.sendRedirect(request.getContextPath() + "/Admin/offers.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doPost(request, response);
    }
}
