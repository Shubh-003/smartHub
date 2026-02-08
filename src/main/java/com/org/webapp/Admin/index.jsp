<%@ page import="java.sql.*" %>
<%@ page import="com.org.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Panel - Dashboard</title>

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

  <!-- Bootstrap Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

  <link rel="stylesheet" href="admin.css">
</head>
<body>

  <!-- Sidebar -->
  <div class="sidebar" id="sidebar">
    <h4 class="fw-bold text-center my-4 gradient-heading">SmartHub</h4>
    <a href="./index.jsp" class="active"><i class="bi bi-speedometer2"></i> Dashboard</a>
    <a href="./product.jsp"><i class="bi bi-phone"></i> Products</a>
    <a href="./order.jsp"><i class="bi bi-basket"></i> Orders</a>
    <a href="./customers.jsp"><i class="bi bi-people"></i> Customers</a>
    <a href="./offers.jsp"><i class="bi bi-tag"></i> Offers/Deals</a>
    <a href="./AdminLogin.jsp"><i class="bi bi-box-arrow-right"></i> Logout</a>
  </div>

  <!-- Main Content -->
  <div class="main-content" id="main-content">

    <!-- Top Navbar -->
    <div class="top-navbar d-flex justify-content-between align-items-center">
      <div class="d-flex align-items-center">
        <button class="btn btn-light me-2" id="sidebarToggleBtn">
          <i class="bi bi-list"></i>
        </button>
        <form class="d-flex search-bar">
          <input class="form-control me-2" type="search" placeholder="Search..." aria-label="Search">
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
            <li><a class="dropdown-item" href="./AdminLogin.jsp">Logout</a></li>
          </ul>
        </div>
      </div>
    </div>

    <!-- Dashboard Section -->
    <div class="container-fluid mt-4">
      <h3 class="mb-4"><i class="bi bi-speedometer2"></i> Dashboard Overview</h3>

      <%
        int productCount = 0, orderCount = 0, customerCount = 0;
        double totalRevenue = 0.0;

        try (Connection con = DBConnection.getConnection()) {
            // Product count
            PreparedStatement ps1 = con.prepareStatement("SELECT COUNT(*) FROM products");
            ResultSet rs1 = ps1.executeQuery();
            if (rs1.next()) productCount = rs1.getInt(1);

            // Order count
            PreparedStatement ps2 = con.prepareStatement("SELECT COUNT(*) FROM orders");
            ResultSet rs2 = ps2.executeQuery();
            if (rs2.next()) orderCount = rs2.getInt(1);

            // Customer count
            PreparedStatement ps3 = con.prepareStatement("SELECT COUNT(*) FROM registration");
            ResultSet rs3 = ps3.executeQuery();
            if (rs3.next()) customerCount = rs3.getInt(1);

            // Total revenue (sum of final_amount for Paid orders)
            PreparedStatement ps4 = con.prepareStatement("SELECT SUM(final_amount) FROM orders WHERE payment_status='Paid'");
            ResultSet rs4 = ps4.executeQuery();
            if (rs4.next()) totalRevenue = rs4.getDouble(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
      %>

      <!-- Stats Cards -->
      <div class="row g-3">
        <div class="col-md-3 col-sm-6">
          <div class="card text-center shadow-sm">
            <div class="card-body">
              <h5 class="card-title">Products</h5>
              <p class="display-6"><%= productCount %></p>
            </div>
          </div>
        </div>

        <div class="col-md-3 col-sm-6">
          <div class="card text-center shadow-sm">
            <div class="card-body">
              <h5 class="card-title">Orders</h5>
              <p class="display-6"><%= orderCount %></p>
            </div>
          </div>
        </div>

        <div class="col-md-3 col-sm-6">
          <div class="card text-center shadow-sm">
            <div class="card-body">
              <h5 class="card-title">Customers</h5>
              <p class="display-6"><%= customerCount %></p>
            </div>
          </div>
        </div>

        <div class="col-md-3 col-sm-6">
          <div class="card text-center shadow-sm">
            <div class="card-body">
              <h5 class="card-title">Revenue</h5>
              <p class="display-6">₹<%= String.format("%.2f", totalRevenue) %></p>
            </div>
          </div>
        </div>
      </div>

      <!-- Charts -->
      <div class="row mt-4">
        <div class="col-lg-8">
          <div class="card shadow-sm">
            <div class="card-body">
              <h5 class="card-title">Sales Overview</h5>
              <canvas id="salesChart"></canvas>
            </div>
          </div>
        </div>

        <div class="col-lg-4">
          <div class="card shadow-sm">
            <div class="card-body">
              <h5 class="card-title">Order Status</h5>
              <canvas id="ordersChart"></canvas>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

  <!-- Chart.js -->
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

  <script>
    document.addEventListener('DOMContentLoaded', function() {
      const sidebarToggleBtn = document.getElementById('sidebarToggleBtn');
      if (sidebarToggleBtn) {
        sidebarToggleBtn.addEventListener('click', function() {
          document.getElementById('sidebar').classList.toggle('active');
        });
      }
    });

    // Example Charts
    const ctx1 = document.getElementById('salesChart');
    new Chart(ctx1, {
      type: 'line',
      data: {
        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
        datasets: [{
          label: 'Sales (₹)',
          data: [12000, 15000, 18000, 22000, 20000, 25000],
          borderColor: '#007bff',
          tension: 0.4,
          fill: true,
          backgroundColor: 'rgba(0,123,255,0.1)'
        }]
      }
    });

    const ctx2 = document.getElementById('ordersChart');
    new Chart(ctx2, {
      type: 'doughnut',
      data: {
        labels: ['Delivered', 'Processing', 'Cancelled'],
        datasets: [{
          data: [120, 60, 15],
          backgroundColor: ['#28a745', '#ffc107', '#dc3545']
        }]
      }
    });
  </script>
</body>
</html>
