<%@ page import="java.sql.*" %>
<%@ page import="com.org.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
int userId = Integer.parseInt(request.getParameter("userId"));
try (Connection con = DBConnection.getConnection()) {
    String sql = "SELECT order_id, order_date, total_amount, order_status FROM orders WHERE user_id = ? ORDER BY order_date DESC";
    PreparedStatement ps = con.prepareStatement(sql);
    ps.setInt(1, userId);
    ResultSet rs = ps.executeQuery();

    if (!rs.isBeforeFirst()) {
%>
    <p class="text-center text-muted my-3">No orders found for this customer.</p>
<%
    } else {
%>
<div class="table-responsive">
<table class="table table-bordered">
  <thead>
    <tr>
      <th>Order ID</th>
      <th>Date</th>
      <th>Total</th>
      <th>Status</th>
    </tr>
  </thead>
  <tbody>
<%
      while (rs.next()) {
%>
    <tr>
      <td>#<%= rs.getInt("order_id") %></td>
      <td><%= rs.getDate("order_date") %></td>
      <td>₹<%= rs.getDouble("total_amount") %></td>
      <td><span class="badge bg-info text-dark"><%= rs.getString("order_status") %></span></td>
    </tr>
<%
      }
%>
  </tbody>
</table>
</div>
<%
    }
} catch (Exception e) {
    e.printStackTrace();
    out.println("<p class='text-danger text-center'>Error loading orders: " + e.getMessage() + "</p>");
}
%>
