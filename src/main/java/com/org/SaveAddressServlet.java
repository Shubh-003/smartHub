package com.org;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/SaveAddressServlet")
public class SaveAddressServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public SaveAddressServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");  // from login session
        if (userId == null) {
            response.sendRedirect("logIn.jsp");
            return;
        }

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String address1 = request.getParameter("address1");
        String address2 = request.getParameter("address2");
        String landmark = request.getParameter("landmark");
        String pinCode = request.getParameter("pinCode");
        String city = request.getParameter("city");
        String state = request.getParameter("state");        
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");

        // Combine address lines for storage
        String fullAddress = address1;
        if (address2 != null && !address2.isEmpty()) fullAddress += ", " + address2;
        if (landmark != null && !landmark.isEmpty()) fullAddress += ", " + landmark;

        try (Connection con = DBConnection.getConnection()) {
            String sql = "UPDATE registration SET userName=?, userEmail=?, userPhone=?, userAddress=?, userPincode=? , userCity=?  ,userState=? WHERE userId=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, firstName + " " + lastName);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, fullAddress);
            ps.setString(5, pinCode);
            ps.setString(6, city);
            ps.setString(7, state);
            ps.setInt(8, userId);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                response.sendRedirect("confirmAddress.jsp");
            } else {
                response.getWriter().println("Error updating address!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
	}

}
