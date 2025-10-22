package com.org;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.*;

import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public LoginServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            // ✅ Load JDBC Driver and connect
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/smarthub", "root", "root");

            // ✅ Get the hashed password from DB for the given email
            String sql = "SELECT * FROM registration WHERE userEmail = ?";
            pst = con.prepareStatement(sql);
            pst.setString(1, email);
            rs = pst.executeQuery();

            if (rs.next()) {
                String hashedPassword = rs.getString("userPassword");

                // ✅ Compare entered password with hashed password
                if (BCrypt.checkpw(password, hashedPassword)) {
                    // ✅ Login success → Create session
                    HttpSession session = request.getSession();
                    session.setAttribute("userId", rs.getInt("userId")); 
                    session.setAttribute("userName", rs.getString("userName"));
                    session.setAttribute("userEmail", rs.getString("userEmail"));

                    // ✅ Optional: set timeout (e.g., 30 mins)
                    session.setMaxInactiveInterval(30 * 60);

                    // ✅ Redirect to home/shop
                    response.sendRedirect("index.jsp");
                } else {
                    // ❌ Wrong password
                    request.setAttribute("errorMessage", "Invalid Email or Password!");
                    request.getRequestDispatcher("logIn.jsp").forward(request, response);
                }
            } else {
                // ❌ Email not found
                request.setAttribute("errorMessage", "Invalid Email or Password!");
                request.getRequestDispatcher("logIn.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Login failed!");
            request.getRequestDispatcher("logIn.jsp").forward(request, response);
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (pst != null) pst.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}
