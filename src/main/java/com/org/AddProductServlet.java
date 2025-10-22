package com.org;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet("/Admin/AddProductServlet")
@MultipartConfig
public class AddProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form fields
        String prodName = request.getParameter("prodName");
        String prod_category = request.getParameter("prod_category");
        String prodMrp = request.getParameter("prodMrp");
        String prodStock = request.getParameter("prodStock");
        String prod_storage = request.getParameter("prod_storage");
        String prod_colour = request.getParameter("prod_colour");
        String prodDesc = request.getParameter("prodDesc");

        // Convert storage and colour to JSON array strings
        String storageJson = toJsonArray(prod_storage);
        String colourJson = toJsonArray(prod_colour);

        // Handle file upload
        Part filePart = request.getPart("prodImg");
        String fileName = filePart.getSubmittedFileName();

        // Save image inside /uploads folder
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);

        try {
            // DB connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/smarthub", "root", "root"
            );

            String sql = "INSERT INTO products " +
                         "(prod_name, prod_category, prod_mrp, prod_stock, prod_storage, prod_colour, prod_desc, prod_img) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, prodName);
            ps.setString(2, prod_category);
            ps.setDouble(3, Double.parseDouble(prodMrp));
            ps.setInt(4, Integer.parseInt(prodStock));
            ps.setString(5, storageJson);   // store as JSON string
            ps.setString(6, colourJson);    // store as JSON string
            ps.setString(7, prodDesc);
            ps.setString(8, "uploads/" + fileName); // relative path for JSP

            int rows = ps.executeUpdate();
            con.close();

            if (rows > 0) {
                response.sendRedirect("product.jsp?status=success");
            } else {
                response.sendRedirect("product.jsp?status=error");
            }


        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }

    // Helper function to convert comma-separated string into JSON array
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
