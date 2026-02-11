<%@ page import="java.sql.*" %>
<%@ page import="com.org.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Admin Panel - Customers</title>
  <link rel="stylesheet" href="admin.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
  <!-- Sidebar -->
  <div class="sidebar" id="sidebar">
    <h4 class="text-center fw-bold my-4">Admin Panel</h4>
    <a href="./index.jsp"><i class="bi bi-speedometer2"></i> Dashboard</a>
    <a href="./product.jsp"><i class="bi bi-phone"></i> Products</a>
    <a href="./order.jsp"><i class="bi bi-basket"></i> Orders</a>
    <a href="./customers.jsp" class="active"><i class="bi bi-people"></i> Customers</a>
    <a href="./offers.jsp"><i class="bi bi-tag"></i> Offers/Deals</a>
    <a href="AdminLogin.jsp"><i class="bi bi-box-arrow-right"></i> Logout</a>
  </div>

  <!-- Main content -->
  <div class="main-content" id="main-content">
    <div class="top-navbar d-flex justify-content-between align-items-center">
      <div class="d-flex align-items-center">
        <button class="btn btn-light me-2" id="sidebarToggleBtn"><i class="bi bi-list"></i></button>
        <form class="d-flex search-bar" method="get" action="searchCustomer.jsp">
          <input class="form-control me-2" type="search" name="query" placeholder="Search Customers..." aria-label="Search">
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

    <!-- Customers Section -->
    <div class="container-fluid mt-4">
      <h2 class="mb-4"><i class="bi bi-people"></i> Customer Management</h2>

      <div class="card shadow-sm">
        <div class="card-body">
        <div class="table-responsive">
          <table class="table table-striped align-middle">
            <thead>
              <tr>
                <th>Customer</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Join Date</th>
                <th>Order History</th>
              </tr>
            </thead>
            <tbody>
              <%
                try (Connection con = DBConnection.getConnection()) {
                    String sql = "SELECT userId, userName, userEmail, userPhone, created_at FROM registration";
                    PreparedStatement ps = con.prepareStatement(sql);
                    ResultSet rs = ps.executeQuery();
                    while (rs.next()) {
                        int uid = rs.getInt("userId");
              %>
              <tr>
                <td><%= rs.getString("userName") %></td>
                <td><%= rs.getString("userEmail") %></td>
                <td><%= rs.getString("userPhone") %></td>
                <td><%= rs.getTimestamp("created_at") %></td>
                <td>
                  <button 
                    class="btn btn-sm btn-outline-info view-orders-btn" 
                    data-userid="<%= uid %>" 
                    data-bs-toggle="modal" 
                    data-bs-target="#orderHistoryModal">
                    <i class="bi bi-clock-history"></i> View Orders
                  </button>
                </td>
              </tr>
              <% 
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } 
              %>
            </tbody>
          </table>
        </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Order History Modal -->
  <div class="modal fade" id="orderHistoryModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header bg-primary text-white">
          <h5 class="modal-title"><i class="bi bi-clock-history"></i> Order History</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        </div>
        <div class="modal-body" id="orderHistoryBody">
          <div class="text-center py-4">
            <div class="spinner-border text-primary"></div>
            <p class="mt-3">Loading order history...</p>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Bootstrap + JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

  <!-- AJAX for fetching order history -->
  <script>
  document.addEventListener("DOMContentLoaded", () => {
    document.querySelectorAll(".view-orders-btn").forEach(btn => {
      btn.addEventListener("click", () => {
        const userId = btn.dataset.userid;
        const modalBody = document.getElementById("orderHistoryBody");
        modalBody.innerHTML = `
          <div class="text-center py-4">
            <div class="spinner-border text-primary"></div>
            <p class="mt-3">Loading order history...</p>
          </div>`;
        
        fetch("getCustomerOrders.jsp?userId=" + userId)
          .then(res => res.text())
          .then(html => modalBody.innerHTML = html)
          .catch(() => modalBody.innerHTML = `<p class='text-danger text-center'>Failed to load order history.</p>`);
      });
    });
  });
  </script>
</body>
</html>
