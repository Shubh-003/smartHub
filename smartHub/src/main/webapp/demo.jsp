<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.org.DBConnection" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Shop - Smartphones</title>

        <!-- CSS -->
        <link rel="stylesheet" href="CSS/style.css">
        <link rel="stylesheet" href="CSS/shop.css">

        <!-- Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <style>
            .product-card-img-area {
                min-height: 275px !important;
                background: #e9ecef;
                border-radius: 16px;
                padding: 50px 0; 
                text-align: center;
            }
        </style>
    </head>

    <body>
        <section class="header">
            <nav class="navbar navbar-expand-lg">
                <div class="container">
                    <a class="navbar-brand text-white fw-bold gradient-heading" href="#">SmartHub</a>
                    <div class="collapse navbar-collapse justify-content-center" id="navbarSupportedContent">
                        <ul class="navbar-nav mb-2 mb-lg-0">
                            <li class="nav-item"><a class="nav-link" href="index.jsp">HOME</a></li>
                            <li class="nav-item"><a class="nav-link" href="shop.jsp">SHOP</a></li>
                            <li class="nav-item"><a class="nav-link" href="#">BLOG</a></li>
                            <li class="nav-item"><a class="nav-link" href="#">PAGES</a></li>
                            <li class="nav-item"><a class="nav-link" href="#">ABOUT</a></li>
                            <li class="nav-item"><a class="nav-link" href="./contact.jsp">CONTACT</a></li>
                        </ul>
                    </div>
                    <div class="d-flex align-items-center">
                        <ul class="navbar-nav flex-row">
                            <li class="nav-item px-2"><a class="nav-link" href="#"><i class="bi bi-search"></i></a></li>
                            <li class="nav-item px-2"><a class="nav-link" href="#"><i class="bi bi-heart"></i></a></li>
                            <li class="nav-item px-2"><a class="nav-link" href="./cart.jsp"><i class="bi bi-bag"></i></a></li>
                            <li class="nav-item px-2">
                                <a class="nav-link" href="LogoutServlet"
                                    data-bs-toggle="tooltip"
                                    data-bs-placement="bottom"
                                    title="<%= session.getAttribute("userName") %>">
                                    <i class="bi bi-person"></i>
                                </a>
                            </li>
                        </ul>
                        <button class="navbar-toggler" type="button"
                            data-bs-toggle="collapse"
                            data-bs-target="#navbarSupportedContent"
                            aria-controls="navbarSupportedContent"
                            aria-expanded="false"
                            aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                    </div>
                </div>
            </nav>
        </section>

        <div class="container mt-4">

            <!-- 🔎 Search & Filter Bar -->
            <form method="get" action="shop.jsp">
                <div class="filter-bar row align-items-center mb-3">
                    <div class="col-md-4">
                        <input type="text" name="search" class="search-bar"
                            placeholder="Search for iPhone, Galaxy..." 
                            value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
                    </div>
                    <div class="col-md-5 col-sm-12 d-flex">
                        <div class="product-filter col-md-4">
                            <select name="brand" class="form-select">
                                <option value="">Brand</option>
                                <option <%= "Apple".equals(request.getParameter("brand")) ? "selected" : "" %>>Apple</option>
                                <option <%= "Samsung".equals(request.getParameter("brand")) ? "selected" : "" %>>Samsung</option>
                                <option <%= "OnePlus".equals(request.getParameter("brand")) ? "selected" : "" %>>OnePlus</option>
                                <option <%= "Google".equals(request.getParameter("brand")) ? "selected" : "" %>>Google</option>
                            </select>
                        </div>
                        <div class="product-filter col-md-4">
                            <select name="storage" class="form-select">
                                <option value="">Storage</option>
                                <option <%= "128".equals(request.getParameter("storage")) ? "selected" : "" %>>128</option>
                                <option <%= "256".equals(request.getParameter("storage")) ? "selected" : "" %>>256</option>
                                <option <%= "512".equals(request.getParameter("storage")) ? "selected" : "" %>>512</option>
                            </select>
                        </div>
                        <div class="product-filter col-md-4">
                            <select name="sort" class="form-select">
                                <option value="">Sort by</option>
                                <option value="low" <%= "low".equals(request.getParameter("sort")) ? "selected" : "" %>>Low → High</option>
                                <option value="high" <%= "high".equals(request.getParameter("sort")) ? "selected" : "" %>>High → Low</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <button class="btn-apply w-100" type="submit">Apply Filters</button>
                    </div>
                </div>
            </form>

            <!-- 📱 Product Grid -->
            <div class="row g-4">
                <%
                    String search = request.getParameter("search");
                    String brand = request.getParameter("brand");
                    String storage = request.getParameter("storage");
                    String sort = request.getParameter("sort");

                    String query = "SELECT * FROM products WHERE 1=1";

                    if (search != null && !search.trim().isEmpty()) {
                        query += " AND LOWER(prod_name) LIKE LOWER('%" + search + "%')";
                    }
                    if (brand != null && !brand.trim().isEmpty()) {
                        query += " AND LOWER(prod_category) LIKE LOWER('%" + brand + "%')";
                    }
                    if (storage != null && !storage.trim().isEmpty()) {
                        query += " AND prod_storage LIKE '%" + storage + "%'";
                    }
                    if ("low".equals(sort)) {
                        query += " ORDER BY prod_mrp ASC";
                    } else if ("high".equals(sort)) {
                        query += " ORDER BY prod_mrp DESC";
                    }

                    Connection con = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;
                    try {
                        con = DBConnection.getConnection();
                        ps = con.prepareStatement(query);
                        rs = ps.executeQuery();

                        while (rs.next()) {
                            int id = rs.getInt("prodId");
                            String name = rs.getString("prod_name");
                            String desc = rs.getString("prod_desc");
                            String img = rs.getString("prod_img");
                            double mrp = rs.getDouble("prod_mrp");
                            String storageVal = rs.getString("prod_storage");
                            String colour = rs.getString("prod_colour");
                %>

                <!-- 🛒 Product Card -->
                <div class="col-6 col-md-4 col-lg-3">
                    <div class="product-card position-relative">
                        <div class="product-card-img-area">
                            <img src="<%= img %>" class="card-img-top" alt="<%= name %>"
                                data-bs-toggle="modal"
                                data-bs-target="#productModal<%= id %>">
                        </div>
                        <div class="card-body text-start mt-0">
                            <h6 class="card-title fw-bold fs-5"><%= name %></h6>
                            <p class="card-text"><%= desc %></p>
                            <p class="card-text mt-3">MRP (Inclusive of all
                                taxes) <br>
                                <del class="text-black">₹<%= mrp %></del>
                                <span class="text-primary fw-bold">Save
                                    ₹19,999.00</span>
                            </p>
                            <p class="card-text fw-bold fs-5">₹<%= mrp %></p>
                            <p>No Cost EMI starts from ₹912.18/ month</p>
                            <button class="btn btn-outline-dark btn-sm mt-2"
                                data-bs-toggle="modal"
                                data-bs-target="#productModal<%= id %>">
                                View Details
                            </button>
                        </div>
                    </div>
                </div>

                        <!-- 🔍 Product Quick View Modal (iPhone 15 Pro) -->
<div  class="modal fade" id="productModal<%= id %>" tabindex="-1">
  <div class="modal-dialog modal-lg modal-dialog-scrollable">
    <div class="modal-content glass-white">
      <div class="modal-header border-0">
        <h5 class="fw-bold"><%= name %></h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      
      <!-- Scrollable Content -->
      <div class="modal-body row">
        
        <!-- Product Image -->
        <div class="col-md-4 px-4">
          <img src="<%= img %>" class="card-img-top img-fluid" alt="<%= name %>">
        </div>

        <!-- Product Info -->
        <div class="col-md-8">
          <p id="specs"><strong>Specs: </strong> <span><%= desc %></span></p>
          <!-- Sprice is a variable to calculate selling price from mrp and discount-->
          <p id="price"><strong>Price:</strong> ₹<span><%= mrp %></span></p> <!-- Selling price after discount-->
          <p class="card-text mt-2">
            MRP (Inclusive of all taxes) <br>
            <del class="text-muted">₹ <%= mrp %></del>
            <span class="text-primary fw-bold"> Save ₹19,999.00</span> <!-- save = mrp - Sprice -->
          </p>
          <p><strong>Offers:</strong> 10% Bank Discount | EMI from ₹5000/mo</p> <!-- emi = Sprice/12  -->

          <!-- Storage Options -->
          <div class="mt-3">
            <h6><strong>Storage</strong></h6>
            <div class="d-flex flex-column gap-2" id="storage-options">
              <button class="btn btn-outline-secondary disabled text-muted">128 GB | 12 GB</button>
              <button class="btn btn-outline-dark storage-option d-flex justify-content-between" data-price="<%= mrp %>" data-storage="256GB | 12GB">
                256 GB | 12 GB <span>₹<%= mrp %></span>
              </button>
              <button class="btn btn-outline-dark storage-option d-flex justify-content-between active" data-price="<%= mrp+10000 %>" data-storage="512GB | 12GB">
                512 GB | 12 GB <span>₹<%= mrp+10000 %></span>
              </button>
            </div>
          </div>

          <!-- Color Options -->
          <div class="mt-3">
            <h6><strong>Colour</strong></h6>
            <div class="d-flex gap-3" id="color-options">
              <div class="text-center">
                <div class="color-circle bg-secondary color-option" data-color="Gray"></div>
                <small>Gray</small>
              </div>
              <div class="text-center">
                <div class="color-circle bg-light color-option active" data-color="Silver"></div>
                <small>Silver</small>
              </div>
            </div>
          </div>

          <!-- Delivery Pincode -->
          <div class="mt-3">
            <h6><strong>Delivery Details</strong></h6>
            <div class="input-group" style="max-width: 250px;">
              <input type="text" class="form-control" placeholder="Enter Pincode" id="pincode">
              <button class="btn btn-outline-primary">Check</button>
            </div>
          </div>

          <!-- Actions -->
          <div class="mt-4">
            <button class="btn btn-outline-danger">❤️ Add to Wishlist</button>
            <button class="btn btn-success" id="addToCartBtn">Add to Cart</button>
          </div>
        </div>
      </div> <!-- End Modal Body -->

    </div>
  </div>
</div>

                <%
                        }
                    } catch (Exception e) {
                        out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
                    } finally {
                        if (rs != null) rs.close();
                        if (ps != null) ps.close();
                        if (con != null) con.close();
                    }
                %>
            </div>
        </div>

        <!-- footer -->
        <footer class="footer mt-5 bg-dark">
            <div class="container">
                <div class="mb-3">
                    <a href="#">About Us</a> |
                    <a href="#">Contact</a> |
                    <a href="#">FAQs</a> |
                    <a href="#">Policies</a>
                </div>
                <div class="social-icons mb-3">
                    <a href="#"><i class="bi bi-facebook"></i></a>
                    <a href="#"><i class="bi bi-twitter-x"></i></a>
                    <a href="#"><i class="bi bi-instagram"></i></a>
                    <a href="#"><i class="bi bi-youtube"></i></a>
                </div>
                <p class="mb-0">&copy; 2026 smartHub. All Rights Reserved.</p>
            </div>
        </footer>
    </body>
</html>
