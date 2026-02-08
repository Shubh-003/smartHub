package com.org;



import java.io.IOException;
//import org.mindrot.jbcrypt.BCrypt;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SignUpServlet")
public class SignUpServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public SignUpServlet() {
        super();
    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.getWriter().println("✅ SignUpServlet is deployed correctly!");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        try {
            // 1. Confirm password check
            if (!password.equals(confirmPassword)) {
                request.setAttribute("errorMessage", "⚠️ Password and Confirm Password do not match!");
                request.getRequestDispatcher("signUp.jsp").forward(request, response);
                return;
            }

            // 2. Load Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // 3. Create Connection
//            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/smarthub", "root", "root");
            Connection con = com.org.DBConnection.getConnection();
            
            // 4. Check if email already exists
            String checkSql = "SELECT * FROM registration WHERE userEmail = ?";
            PreparedStatement checkPs = con.prepareStatement(checkSql);
            checkPs.setString(1, email);
            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {
                // User already exists
                request.setAttribute("errorMessage", "⚠️ User already exists, please login.");
                request.getRequestDispatcher("signUp.jsp").forward(request, response);
                rs.close();
                checkPs.close();
                con.close();
                return;
            }

            rs.close();
            checkPs.close();

         // Encrypt password
            String hashedPassword = PasswordUtil.hashPassword(password);

            // 6. Insert new user
            String insertSql = "INSERT INTO registration(userName, userEmail, userPassword) VALUES (?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(insertSql);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, hashedPassword);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                request.setAttribute("successMessage", "✅ Registration successful! Please login.");
                request.getRequestDispatcher("logIn.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "❌ Registration failed. Please try again.");
                request.getRequestDispatcher("signUp.jsp").forward(request, response);
            }

            ps.close();
            con.close();

        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error: " + e.getMessage());
            request.getRequestDispatcher("signUp.jsp").forward(request, response);
        }
    }
}
