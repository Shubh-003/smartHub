<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.sql.*,java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Panel - Offers & Deals</title>

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
    <a href="./customers.jsp"><i class="bi bi-people"></i> Customers</a>
    <a href="./offers.jsp" class="active"><i class="bi bi-tag"></i> Offers/Deals</a>
    <a href="AdminLogin.jsp"><i class="bi bi-box-arrow-right"></i> Logout</a>
  </div>

  <!-- Main Content -->
  <div class="main-content" id="main-content">
    
    <!-- Top Navbar -->
    <div class="top-navbar d-flex justify-content-between align-items-center">
      <div class="d-flex align-items-center">
        <button class="btn btn-light me-2" id="sidebarToggleBtn">
          <i class="bi bi-list"></i>
        </button>
        <form class="d-flex search-bar" method="get" action="searchOffers.jsp">
          <input class="form-control me-2" type="search" name="query" placeholder="Search Offers..." aria-label="Search">
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

    <!-- Offers Section -->
    <div class="container-fluid mt-4">
      <h2 class="mb-4"><i class="bi bi-tag"></i> Offers & Deals Management</h2>

      <!-- Limited Time Discounts -->
      <div class="card shadow-sm mb-4">
        <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
          <h5 class="mb-0">Limited-Time Discounts</h5>
          <button class="btn btn-light btn-sm" data-bs-toggle="modal" data-bs-target="#discountModal">
            <i class="bi bi-plus-circle"></i> Add Discount
          </button>
        </div>
        <div class="card-body table-responsive">
          <table class="table table-hover align-middle">
            <thead>
              <tr>
                <th>Discount Name</th>
                <th>Product/Category</th>
                <th>Discount %</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Status</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <% 
                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/smarthub", "root", "root");
                    String sql = "SELECT * FROM discounts ORDER BY start_date DESC";
                    ps = conn.prepareStatement(sql);
                    rs = ps.executeQuery();

                    while(rs.next()) {
                        int id = rs.getInt("id");
                        String name = rs.getString("discount_name");
                        String category = rs.getString("product_category");
                        int percent = rs.getInt("discount_percent");
                        java.sql.Date startDate = rs.getDate("start_date");
                        java.sql.Date endDate = rs.getDate("end_date");

                        java.util.Date today = new java.util.Date();
                        String status = (today.before(endDate)) ? "Active" : "Expired";
              %>
              <tr>
                <td><%= name %></td>
                <td><%= category %></td>
                <td><%= percent %> %</td>
                <td><%= startDate %></td>
                <td><%= endDate %></td>
                <td>
                  <% if("Active".equals(status)) { %>
                    <span class="badge bg-success">Active</span>
                  <% } else { %>
                    <span class="badge bg-secondary">Expired</span>
                  <% } %>
                </td>
                <td>
                  <form method="post" action="<%=request.getContextPath()%>/Admin/DiscountServlet?action=delete" style="display:inline;" onsubmit="return confirm('Delete this discount?');">
                    <input type="hidden" name="id" value="<%= id %>">
                    <button class="btn btn-sm btn-danger" type="submit"><i class="bi bi-trash"></i></button>
                  </form>
                </td>
              </tr>
              <%
                    }
                } catch(Exception e) {
                    e.printStackTrace();
                } finally {
                    try { if(rs!=null) rs.close(); } catch(Exception e) {}
                    try { if(ps!=null) ps.close(); } catch(Exception e) {}
                    try { if(conn!=null) conn.close(); } catch(Exception e) {}
                }
              %>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>

  <!-- Add Discount Modal -->
  <div class="modal fade" id="discountModal" tabindex="-1">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header bg-primary text-white">
          <h5 class="modal-title"><i class="bi bi-plus-circle"></i> Add New Discount</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        </div>
        <div class="modal-body">
        
          <form method="post" action="<%=request.getContextPath()%>/Admin/DiscountServlet?action=add">
            <div class="mb-3">
              <label class="form-label">Discount Name</label>
              <input type="text" name="discountName" class="form-control" placeholder="Diwali Sale" required>
            </div>
            <div class="mb-3">
              <label class="form-label">Product/Category</label>
              <input type="text" name="productCategory" class="form-control" placeholder="Smartphones" required>
            </div>
            <div class="mb-3">
              <label class="form-label">Discount %</label>
              <input type="number" name="discountPercent" class="form-control" placeholder="20" required>
            </div>
            <div class="mb-3">
              <label class="form-label">Start Date</label>
              <input type="date" name="startDate" class="form-control" required>
            </div>
            <div class="mb-3">
              <label class="form-label">End Date</label>
              <input type="date" name="endDate" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary w-100">Save Discount</button>
          </form>
        </div>
      </div>
    </div>
  </div>

  <!-- Bootstrap & Sidebar Script -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    document.addEventListener('DOMContentLoaded', function() {
      const sidebarToggleBtn = document.getElementById('sidebarToggleBtn');
      if (sidebarToggleBtn) {
        sidebarToggleBtn.addEventListener('click', function() {
          document.getElementById('sidebar').classList.toggle('active');
        });
      }
    });
  </script>
</body>
</html>
