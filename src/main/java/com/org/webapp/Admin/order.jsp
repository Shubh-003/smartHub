<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.org.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Orders Management - Admin Panel</title>

  <link rel="stylesheet" href="admin.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
  <!-- Sidebar -->
  <div class="sidebar" id="sidebar">
    <h4 class="text-center fw-bold my-4">Admin Panel</h4>
    <a href="./index.jsp"><i class="bi bi-speedometer2"></i> Dashboard</a>
    <a href="./product.jsp"><i class="bi bi-phone"></i> Products</a>
    <a href="./order.jsp" class="active"><i class="bi bi-basket"></i> Orders</a>
    <a href="./customers.jsp"><i class="bi bi-people"></i> Customers</a>
    <a href="./offers.jsp"><i class="bi bi-tag"></i> Offers/Deals</a>
    <a href="AdminLogin.jsp"><i class="bi bi-box-arrow-right"></i> Logout</a>
  </div>

  <!-- Main content -->
  <div class="main-content" id="main-content">
    <div class="top-navbar d-flex justify-content-between align-items-center">
      <div class="d-flex align-items-center">
        <button class="btn btn-light me-2" id="sidebarToggleBtn">
          <i class="bi bi-list"></i>
        </button>
        <form class="d-flex search-bar" method="get" action="searchProduct.jsp">
          <input class="form-control me-2" type="search" name="query" placeholder="Search Products..." aria-label="Search">
          <button class="btn btn-outline-primary" type="submit"><i class="bi bi-search"></i></button>
        </form>
      </div>
      <div class="d-flex align-items-center">
        <button class="btn btn-light me-3"><i class="bi bi-bell fs-6"></i></button>
        <div class="dropdown">
          <button class="btn btn-light dropdown-toggle" data-bs-toggle="dropdown">
            <i class="bi bi-person-circle"></i> Admin
          </button>
          <ul class="dropdown-menu dropdown-menu-end">
            <li><a class="dropdown-item" href="./profile.jsp">Profile</a></li>
            <li><a class="dropdown-item" href="AdminLogin.jsp">Logout</a></li>
          </ul>
        </div>
      </div>
    </div>

    <!-- Orders Table -->
    <div class="container mt-4">
      <h3 class="mb-4">Orders Management</h3>
      <div class="card shadow-sm p-3">
        <div class="table-responsive">
          <table class="table table-hover align-middle">
            <thead class="table-light">
              <tr>
                <th>#Order ID</th>
                <th>Customer</th>
                <th>Product</th>
                <th>Status</th>
                <th>Payment Method</th>
                <th>Payment Status</th>
                <th>Date</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody>
              <%
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                try {
                    con = DBConnection.getConnection();
                    String sql = "SELECT o.order_id, r.userName, p.prod_name, o.order_status, o.payment_method, o.payment_status, o.order_date " +
                                 "FROM orders o " +
                                 "JOIN registration r ON o.user_id = r.userId " +
                                 "JOIN order_items oi ON o.order_id = oi.order_id " +
                                 "JOIN products p ON oi.product_id = p.prodId " +
                                 "ORDER BY o.order_date DESC";
                    ps = con.prepareStatement(sql);
                    rs = ps.executeQuery();
                    while(rs.next()){
                        String orderId = rs.getString("order_id");
                        String customer = rs.getString("userName");
                        String product = rs.getString("prod_name");
                        String status = rs.getString("order_status");
                        String paymentMethod = rs.getString("payment_method");
                        String paymentStatus = paymentMethod.equalsIgnoreCase("Cash on Delivery") ? "Pending" : "Paid";
                        String date = rs.getString("order_date");
              %>
              <form action="<%= request.getContextPath() %>/Admin/UpdateOrderStatusServlet" method="post" >
                <tr>
                  <td>#SH0<%= orderId %></td>
                  <td><%= customer %></td>
                  <td><%= product %></td>
                  <td>
                    <input type="hidden" name="order_id" value="<%= orderId %>">
                    <select class="form-select form-select-sm" name="order_status">
                      <option <%= status.equals("Pending") ? "selected" : "" %>>Pending</option>
                      <option <%= status.equals("Processing") ? "selected" : "" %>>Processing</option>
                      <option <%= status.equals("Shipped") ? "selected" : "" %>>Shipped</option>
                      <option <%= status.equals("Delivered") ? "selected" : "" %>>Delivered</option>
                      <option <%= status.equals("Cancelled") ? "selected" : "" %>>Cancelled</option>
                    </select>
                  </td>
                <td class="text-center">
                <% if ("Cash on Delivery".equalsIgnoreCase(paymentMethod)) { %>
                           <span class="">COD</span>
                 <% } else { %>
                           <span >Card</span>
				        <% } %>
               </td>
                  <td>
                    <% if(paymentStatus.equals("Paid") || status.equals("Delivered") ) { %>
                      <span class="badge bg-success">Paid</span>
                    <% } else if(status.equals("Cancelled")){ %>
                      <span class="badge bg-warning">Cancel</span>
                    <% }  else{ %>
                      <span class="badge bg-danger">Pending</span>
                    <% } %>
                    
                  </td>
                  <td><%= date %></td>
                  <td>
                    <button type="submit" class="btn btn-sm btn-warning">Update</button>
                  </td>
                </tr>
              </form>
              <%  } 
                } catch(Exception e){ 
                    out.println("<tr><td colspan='8' class='text-center text-danger'>Error: "+e.getMessage()+"</td></tr>");
                } finally {
                    if(rs!=null) rs.close();
                    if(ps!=null) ps.close();
                    if(con!=null) con.close();
                }
              %>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script>
  document.addEventListener("DOMContentLoaded", function() {
    const sidebarToggleBtn = document.getElementById("sidebarToggleBtn");
    const sidebar = document.getElementById("sidebar");
    if (sidebarToggleBtn) {
      sidebarToggleBtn.addEventListener("click", function() {
        sidebar.classList.toggle("active");
      });
    }
  });
  </script>
</body>
</html>
