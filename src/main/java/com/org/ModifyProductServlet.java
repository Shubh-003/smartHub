package com.org;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Admin/ModifyProductServlet")
public class ModifyProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ModifyProductServlet() { super(); }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Redirect GET to product page — avoid blank pages if user hits URL directly.
        response.sendRedirect(request.getContextPath() + "/Admin/product.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        Connection con = null;
        PreparedStatement ps = null;

        try {
            // Try to get DB connection (adjust if your DBConnection class is different)
            try {
                con = DBConnection.getConnection();
            } catch (Throwable t) {
                // fallback to DriverManager if DBConnection not available
//                Class.forName("com.mysql.cj.jdbc.Driver");
//                con = java.sql.DriverManager.getConnection("jdbc:mysql://localhost:3306/smarthub", "root", "root");
            	con = DBConnection.getConnection();
            }

            if ("edit".equalsIgnoreCase(action)) {
                String idStr = request.getParameter("prod_id");
                if (idStr == null || idStr.trim().isEmpty()) {
                    response.sendRedirect(request.getContextPath() + "/Admin/product.jsp?status=error");
                    return;
                }
                int prodId = Integer.parseInt(idStr);

                // read fields (use same names as AddProductServlet/form)
                String name = request.getParameter("prodName");
                String category = request.getParameter("prod_category");
                String mrpStr = request.getParameter("prodMrp");
                String stockStr = request.getParameter("prodStock");
                String storage = request.getParameter("prod_storage");
                String colour = request.getParameter("prod_colour");
                String desc = request.getParameter("prodDesc");

                double mrp = (mrpStr == null || mrpStr.trim().isEmpty()) ? 0.0 : Double.parseDouble(mrpStr);
                int stock = (stockStr == null || stockStr.trim().isEmpty()) ? 0 : Integer.parseInt(stockStr);

                // ensure storage/colour stored as JSON (if admin typed comma separated values)
                if (storage == null) storage = "[]";
                else if (!storage.trim().startsWith("[")) storage = toJsonArray(storage);

                if (colour == null) colour = "[]";
                else if (!colour.trim().startsWith("[")) colour = toJsonArray(colour);

                String sql = "UPDATE products SET prod_name=?, prod_category=?, prod_mrp=?, prod_stock=?, prod_storage=?, prod_colour=?, prod_desc=? WHERE prodId=?";
                ps = con.prepareStatement(sql);
                ps.setString(1, name);
                ps.setString(2, category);
                ps.setDouble(3, mrp);
                ps.setInt(4, stock);
                ps.setString(5, storage);
                ps.setString(6, colour);
                ps.setString(7, desc);
                ps.setInt(8, prodId);

                int rows = ps.executeUpdate();
                if (rows > 0) {
                    response.sendRedirect(request.getContextPath() + "/Admin/product.jsp?status=edited");
                } else {
                    response.sendRedirect(request.getContextPath() + "/Admin/product.jsp?status=error");
                }
                return;
            }

            else if ("delete".equalsIgnoreCase(action)) {
                String idStr = request.getParameter("prod_id");
                if (idStr == null || idStr.trim().isEmpty()) {
                    response.sendRedirect(request.getContextPath() + "/Admin/product.jsp?status=error");
                    return;
                }
                int prodId = Integer.parseInt(idStr);

                ps = con.prepareStatement("DELETE FROM products WHERE prodId=?");
                ps.setInt(1, prodId);
                int rows = ps.executeUpdate();
                if (rows > 0) {
                    response.sendRedirect(request.getContextPath() + "/Admin/product.jsp?status=deleted");
                } else {
                    response.sendRedirect(request.getContextPath() + "/Admin/product.jsp?status=error");
                }
                return;
            }

            // unknown action -> back to list
            response.sendRedirect(request.getContextPath() + "/Admin/product.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/Admin/product.jsp?status=error");
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception ignore) {}
            try { if (con != null) con.close(); } catch (Exception ignore) {}
        }
    }

    // Helper to convert comma-separated to JSON array string (same as AddProductServlet)
    private String toJsonArray(String input) {
        if (input == null || input.trim().isEmpty()) {
            return "[]";
        }
        String[] parts = input.split(",");
        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < parts.length; i++) {
            json.append("\"").append(parts[i].trim()).append("\"");
            if (i < parts.length - 1) json.append(",");
        }
        json.append("]");
        return json.toString();
    }
}
