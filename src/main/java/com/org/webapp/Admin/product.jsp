<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%!
  // small helper to safely put values into data-attributes / inputs
  public static String esc(String s) {
    if (s==null) return "";
    return s.replace("\"","&quot;").replace("'","&#39;").replace("\r"," ").replace("\n"," ");
  }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Panel - Products</title>

  <link rel="stylesheet" href="admin.css">

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">


</head>
<body>
  <div class="sidebar" id="sidebar">
    <h4 class="text-center fw-bold my-4">Admin Panel</h4>
    <a href="./index.jsp"><i class="bi bi-speedometer2"></i> Dashboard</a>
    <a href="./product.jsp" class="active"><i class="bi bi-phone"></i> Products</a>
    <a href="./order.jsp"><i class="bi bi-basket"></i> Orders</a>
    <a href="./customers.jsp"><i class="bi bi-people"></i> Customers</a>
    <a href="./offers.jsp"><i class="bi bi-tag"></i> Offers/Deals</a>
    <a href="AdminLogin.jsp"><i class="bi bi-box-arrow-right"></i> Logout</a>
  </div>

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

    <div class="container-fluid mt-4">
      <h2 class="mb-4"><i class="bi bi-phone"></i> Products Management</h2>

      <button class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#addProductModal" onclick="openAddModal()">
        <i class="bi bi-plus-circle"></i> Add New Product
      </button>

      <div class="card shadow-sm">
        <div class="card-body table-responsive">
          <table class="table table-striped table-hover align-middle">
            <thead>
              <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Category</th>
                <th>Price</th>
                <th>Stock</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody id="productTable">
<%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/smarthub", "root", "root");
        String sql = "SELECT * FROM products ORDER BY prodId DESC";
        ps = con.prepareStatement(sql);
        rs = ps.executeQuery();
        while (rs.next()) {
            int id = rs.getInt("prodId");
            String name = rs.getString("prod_name");
            String category = rs.getString("prod_category");
            String mrp = rs.getString("prod_mrp");
            int stock = rs.getInt("prod_stock");
            String storage = rs.getString("prod_storage");
            String colour = rs.getString("prod_colour");
            String desc = rs.getString("prod_desc");
%>
              <tr>
                <td><%= id %></td>
                <td><%= esc(name) %></td>
                <td><%= esc(category) %></td>
                <td>₹<%= mrp %></td>
                <td><%= stock %></td>
                <td>
                  <button type="button" class="btn btn-sm btn-warning editBtn"
                          data-prod_id="<%= id %>"
                          data-prodName="<%= esc(name) %>"
                          data-prod_category="<%= esc(category) %>"
                          data-prodMrp="<%= mrp %>"
                          data-prodStock="<%= stock %>"
                          data-prod_storage="<%= esc(storage) %>"
                          data-prod_colour="<%= esc(colour) %>"
                          data-prodDesc="<%= esc(desc) %>">
                    <i class="bi bi-pencil-square"></i>
                  </button>
                  <form method="post" action="<%= request.getContextPath() %>/Admin/ModifyProductServlet" style="display:inline-block;" onsubmit="return confirm('Delete this product?');">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="prod_id" value="<%= id %>">
                    <button type="submit" class="btn btn-sm btn-danger"><i class="bi bi-trash"></i></button>
                  </form>
                </td>
              </tr>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch(Exception ignore){}
        if (ps != null) try { ps.close(); } catch(Exception ignore){}
        if (con != null) try { con.close(); } catch(Exception ignore){}
    }
%>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>

  <div class="modal fade" id="addProductModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="modalTitle"><i class="bi bi-plus-circle"></i> Add Product</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        </div>
        <div class="modal-body">
        
          <form id="productForm" method="post" action="AddProductServlet" enctype="multipart/form-data">
            <input type="hidden" id="prod_id" name="prod_id">
            <input type="hidden" id="form_action" name="action">
            <div class="row">
              <div class="col-md-6 mb-3">
                <label class="form-label">Product Name</label>
                <input type="text" id="prodName" name="prodName" class="form-control" required>
              </div>
              <div class="col-md-6 mb-3">
                <label class="form-label">Category</label>
                <select id="prod_category" name="prod_category" class="form-select" required>
                  <option>Smartphones</option>
                  <option>Accessories</option>
                  <option>Smartwatch</option>
                  <option>Audio Device</option>
                </select>
              </div>
              <div class="col-md-6 mb-3">
                <label class="form-label">MRP (₹)</label>
                <input type="number" id="prodMrp" name="prodMrp" class="form-control" required>
              </div>
              <div class="col-md-6 mb-3">
                <label class="form-label">Stock</label>
                <input type="number" id="prodStock" name="prodStock" class="form-control" min="0" required>
              </div>
              <div class="col-md-6 mb-3">
                <label class="form-label">Storage</label>
                <input type="text" id="prod_storage" name="prod_storage" class="form-control">
              </div>
              <div class="col-md-6 mb-3">
                <label class="form-label">Colour</label>
                <input type="text" id="prod_colour" name="prod_colour" class="form-control">
              </div>
              <div class="col-12 mb-3">
                <label class="form-label">Description</label>
                <textarea id="prodDesc" name="prodDesc" class="form-control" rows="3"></textarea>
              </div>
              <div class="col-12 mb-3">
                <label class="form-label">Upload Product Image</label>
                <input type="file" id="prodImg" name="prodImg" class="form-control">
              </div>
            </div>
            <button type="submit" class="btn btn-success">Save Product</button>
          </form>
        </div>
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

  <script>
    document.addEventListener('DOMContentLoaded', function() {
      // **NEW** - Sidebar Toggle Functionality
      const sidebarToggleBtn = document.getElementById('sidebarToggleBtn');
      if (sidebarToggleBtn) {
        sidebarToggleBtn.addEventListener('click', function() {
          document.getElementById('sidebar').classList.toggle('active');
        });
      }

      // Your existing modal logic (unchanged)
      const edits = document.querySelectorAll('.editBtn');
      edits.forEach(btn => {
        btn.addEventListener('click', function() {
          document.getElementById('modalTitle').innerHTML = '<i class="bi bi-pencil-square"></i> Edit Product';
          const pid = this.getAttribute('data-prod_id');
          document.getElementById('prod_id').value = pid;
          document.getElementById('prodName').value = this.getAttribute('data-prodName') || '';
          document.getElementById('prod_category').value = this.getAttribute('data-prod_category') || '';
          document.getElementById('prodMrp').value = this.getAttribute('data-prodMrp') || '';
          document.getElementById('prodStock').value = this.getAttribute('data-prodStock') || '';
          document.getElementById('prod_storage').value = this.getAttribute('data-prod_storage') || '';
          document.getElementById('prod_colour').value = this.getAttribute('data-prod_colour') || '';
          document.getElementById('prodDesc').value = this.getAttribute('data-prodDesc') || '';
          document.getElementById('productForm').action = '<%= request.getContextPath() %>/Admin/ModifyProductServlet';
          document.getElementById('form_action').value = 'edit';
          var modal = new bootstrap.Modal(document.getElementById('addProductModal'));
          modal.show();
        });
      });
    });

    // Your existing add modal function (with a small change to update title)
    function openAddModal() {
      document.getElementById('modalTitle').innerHTML = '<i class="bi bi-plus-circle"></i> Add Product';
      document.getElementById('productForm').action = '<%= request.getContextPath() %>/Admin/AddProductServlet';
      document.getElementById('form_action').value = '';
      document.getElementById('prod_id').value = '';
      document.getElementById('productForm').reset();
    }
  </script>

</body>
</html>