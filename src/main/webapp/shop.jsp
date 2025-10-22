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
        /* -------------------------------------------------------------------------------- // 🎨 Apple-Inspired Dark Mode UI // -------------------------------------------------------------------------------- */
:root {
	--apple-dark-bg: #141417; /* Very dark background */
	--apple-card-bg: rgba(29, 29, 31, 0.8); /* Dark Frosted Glass */
	--apple-text-primary: #f5f5f7; /* Near-white for primary text */
	--apple-text-secondary: #86868b; /* Subtle grey for secondary text */
	--apple-accent-blue: #007aff; /* Apple Blue */
	--apple-success-green: #34c759; /* Apple Success Green */
	--apple-border-color: rgba(68, 68, 70, 0.4);
}


	/* ---------------------------------- // Navbar // ---------------------------------- */
.navbar {
	border-bottom: 1px solid var(--apple-border-color);
	background-color: var(--apple-dark-bg);
	/* Opaque for scrolling clarity */
}

.navbar-brand {
	color: var(--apple-text-primary) !important;
	font-weight: 700;
	letter-spacing: -0.5px;
}
.nav-link.active {
  color: white !important;
}
.nav-link {
	color: var(--apple-text-secondary) !important;
	font-weight: 500;
	padding: 0.5rem 1rem;
	transition: color 0.2s, background-color 0.2s;
}
.nav-link.active {
  color: white !important;
}
.nav-link:hover, .nav-link:focus  {
	color: var(--apple-text-primary) !important;
}


.bi {
	font-size: 1.2rem;
}
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
                            <li class="nav-item"><a class="nav-link active" href="shop.jsp">SHOP</a></li>
                            <li class="nav-item"><a class="nav-link" href="#">BLOG</a></li>
                            <li class="nav-item"><a class="nav-link" href="#">PAGES</a></li>
                            <li class="nav-item"><a class="nav-link" href="#">ABOUT</a></li>
                            <li class="nav-item"><a class="nav-link" href="./contact.jsp">CONTACT</a></li>
                        </ul>
                    </div>
                    <div class="d-flex align-items-center">
                        <ul class="navbar-nav flex-row">
                            <li class="nav-item px-2"><a class="nav-link" href="#"><i class="bi bi-search"></i></a></li>
                            <li class="nav-item px-2"><a class="nav-link" href="order.jsp"><i class="bi bi-card-checklist"></i></a></li>
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
                            <select name="categoryForm" class="form-select">
                <option value="">Category</option>
                <option value="Smartphones" <%= "Smartphones".equals(request.getParameter("categoryForm")) ? "selected" : "" %>>Smartphones</option>
                <option value="Accessories" <%= "Accessories".equals(request.getParameter("categoryForm")) ? "selected" : "" %>>Accessories</option>
                <option value="Smartwatch" <%= "Smartwatch".equals(request.getParameter("categoryForm")) ? "selected" : "" %>>Smartwatch</option>
                <option value="Audio Device" <%= "Audio Device".equals(request.getParameter("categoryForm")) ? "selected" : "" %>>Audio Device</option>
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
                	String categorySearch = request.getParameter("categoryForm");
                    String storage = request.getParameter("storage");
                    String sort = request.getParameter("sort");

                    String query = "SELECT * FROM products WHERE 1=1";

                    if (search != null && !search.trim().isEmpty()) {
                        query += " AND LOWER(prod_name) LIKE LOWER('%" + search + "%')";
                    }else
                    if (categorySearch != null && !categorySearch.trim().isEmpty()) {
                    	    query += " AND LOWER(prod_category) = LOWER('" + categorySearch + "')";
                    }else
                    if (storage != null && !storage.trim().isEmpty()) {
                        query += " AND prod_storage LIKE '%" + storage + "%'";
                    }else
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
                        
                        PreparedStatement discountStmt = con.prepareStatement(
                        	    "SELECT discount_percent,discount_name FROM discounts " +
                        	    "WHERE product_category = ? AND status='Active' " +
                        	    "AND CURDATE() BETWEEN start_date AND end_date " +
                        	    "ORDER BY discount_percent DESC LIMIT 1"
                        	);

                        while (rs.next()) {
                            int id = rs.getInt("prodId");
                            String name = rs.getString("prod_name");
                            String desc = rs.getString("prod_desc");
                            String img = rs.getString("prod_img");
                            double mrp = rs.getDouble("prod_mrp");
                            String storageVal = rs.getString("prod_storage");
                            String colour = rs.getString("prod_colour");
                            
                            String category = rs.getString("prod_category");

                            // 🔹 Fetch active discount for this product category
                            discountStmt.setString(1, category);
                            ResultSet discountRs = discountStmt.executeQuery();

                            double discountPercent = 0.0;
                            String discountName= "";
                            if (discountRs.next()) {
                                discountPercent = discountRs.getDouble("discount_percent");
                                discountName = discountRs.getString("discount_name");
                            }

                            // 🔹 Calculate selling price and savings
                            double discountAmount = (mrp * discountPercent) / 100;
                            double sellingPrice = mrp - discountAmount;
                            double emi = sellingPrice / 12;

                            discountRs.close();
                %>

                <!-- 🛒 Product Card -->
                <div class="col-6 col-md-6 col-lg-3">
                    <div class="product-card position-relative">
                        <div class="product-card-img-area">
                            <img src="<%= img %>" class="card-img-top" alt="<%= name %>"
                                data-bs-toggle="modal"
                                data-bs-target="#productModal<%= id %>">
                        </div>
                        <div class="card-body text-start mt-0">
                            <h6 class="card-title fw-bold fs-5"><%= name %></h6>
                            <p class="card-text"><%= desc %></p>
                            
                             <% if (discountPercent > 0) { %>
                            <p class="card-text mt-3">MRP (Inclusive of all
                                taxes) <br>
                                <del class="text-black">₹<%= mrp %></del>
                                <span class="text-success fw-bold"> Save ₹<%= String.format("%.2f", discountAmount) %> </span> <!-- save = mrp - Sprice -->
                            </p>
                            <!-- Sprice is a variable to calculate selling price from mrp and discount-->
                            <p class="card-text fw-bold fs-5">₹<%= String.format("%.2f", sellingPrice) %></p> <!-- Selling price after discount-->
                            
                            <% } else { %>
                				<p class="card-text fs-5 fw-bold mt-5">₹<%= mrp %></p>
           				    <% } %>
            
                            <p>No Cost EMI starts from ₹<%= String.format("%.2f", emi) %>/month</p> <!-- emi = Sprice/12  -->
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
          <% if (discountPercent > 0) { %>
          <!-- Sprice is a variable to calculate selling price from mrp and discount-->
          <p id="price"><strong>Price:</strong> ₹<span><%= String.format("%.2f", sellingPrice) %></span></p> <!-- Selling price after discount-->
          <p class="card-text mt-2">
            MRP (Inclusive of all taxes) <br>
            <del class="text-muted">₹ <%= mrp %></del>
            <span class="text-primary fw-bold"> Save ₹<%= String.format("%.2f", discountAmount) %></span> <!-- save = mrp - Sprice -->
          </p>
          <% } else { %>
			<p class="card-text fs-5 ">₹ <%= mrp %></p>
          <% } %>
          
          <% if (discountPercent > 0) { %>
          	<p><strong>Offers:</strong> <%= String.format("%.0f", discountPercent) %>% <%= discountName != null && !discountName.isEmpty() ? discountName : "" %> Discount | EMI from ₹<%= String.format("%.2f", emi) %>/month
				</p> <!-- emi = Sprice/12  -->
		  <% } else { %>
    			<p><strong>Offers:</strong> No active offers currently | EMI from ₹<%= String.format("%.2f", emi) %>/month</p>
			<% } %>

          <!-- Storage Options -->
<%
    if (storageVal != null && !storageVal.trim().isEmpty()) {

        // 🧹 Clean unwanted characters like brackets or quotes
        storageVal = storageVal.replace("[", "")
                               .replace("]", "")
                               .replace("\"", "")
                               .trim();

        // Split into individual storage options
        String[] storageOptions = storageVal.split(",");

        // Ensure the array has valid content
        if (storageOptions.length > 0 && !storageOptions[0].trim().isEmpty()) {
%>
    <div class="mt-3">
        <h6><strong>Storage</strong></h6>
        <div class="d-flex flex-column gap-2" id="storage-options">
            <%
                for (int i = 0; i < storageOptions.length; i++) {
                    String option = storageOptions[i].trim();
                    double optionPrice = mrp + (i * 10000); // optional price increment
            %>
                <button class="btn btn-outline-dark storage-option d-flex justify-content-between <%= i == 0 ? "active" : "" %>"
                        data-price="<%= optionPrice %>" 
                        data-storage="<%= option %> GB | 12 GB">
                    <%= option %> GB | 12 GB 
                    <span>₹<%= String.format("%.2f", optionPrice) %></span>
                </button>
            <% } %>
        </div>
    </div>
<%
        } // end if valid content
    } // end if not null
%>


          <!-- Color Options -->
<%
    if (colour != null && !colour.trim().isEmpty()) {

        // 🧹 Clean unwanted characters like brackets or quotes
        colour = colour.replace("[", "").replace("]", "").replace("\"", "").trim();

        // Split the colors into an array (e.g. "Gray,Silver,Blue")
        String[] colorOptions = colour.split(",");

        // Ensure the array has valid entries
        if (colorOptions.length > 0 && !colorOptions[0].trim().isEmpty()) {
%>
    <div class="mt-3">
        <h6><strong>Colour</strong></h6>
        <div class="d-flex gap-3" id="color-options">
            <%
                for (int i = 0; i < colorOptions.length; i++) {
                    String colorName = colorOptions[i].trim();

                    // ✅ Convert color name to lowercase for Bootstrap classes
                    String colorClass = colorName.toLowerCase();

                    // Map known color names to Bootstrap equivalents #c0c0c0
                    if (colorClass.equals("gray") || colorClass.equals("grey")) colorClass = "secondary";
                    else if (colorClass.equals("black")) colorClass = "dark";
                    else if (colorClass.equals("silver")) colorClass = "#c0c0c0";
                    else if (colorClass.equals("white")) colorClass = "light";
                    else if (colorClass.equals("blue")) colorClass = "primary";
                    else if (colorClass.equals("red")) colorClass = "danger";
                    else if (colorClass.equals("green")) colorClass = "success";
                    else if (colorClass.equals("yellow")) colorClass = "warning";
            %>
                <div class="text-center">
                    <div class="color-circle bg-<%= colorClass %> color-option <%= i == 0 ? "active" : "" %>" 
                         data-color="<%= colorName %>"></div>
                    <small><%= colorName %></small>
                </div>
            <% } %>
        </div>
    </div>
<%
        } // end if valid color list
    } // end if not null
%>


          <!-- Delivery Pincode -->
          <div class="mt-3">
    <h6><strong>Delivery Details</strong></h6>
    <div class="input-group" style="max-width: 250px;">
        <input type="text" class="form-control" placeholder="Enter Pincode" id="pincodeInput">
        <button class="btn btn-outline-primary" id="checkBtn">Check</button>
    </div>
    <div id="deliveryMessage" class="mt-2"></div>
</div>

          <!-- Actions -->
          <div class="mt-4">
            <!--  <button class="btn btn-outline-danger">❤️ Add to Wishlist</button> -->
            <form action="<%= request.getContextPath() %>/CartServlet" method="post">
    			<input type="hidden" name="prodId" value="<%= id %>">
    			<input type="hidden" name="price" value="<%= sellingPrice %>">
    			<input type="hidden" name="quantity" value="1">
    			<button type="submit" class="btn-apply">Add to Cart</button>
			</form>
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
                <p class="mb-0">&copy; 2025 MobileShop. All Rights Reserved.</p>
            </div>
        </footer>
        
        <script>
    // Wait for the page to load
    document.addEventListener('DOMContentLoaded', function () {

        // Get the button and the message area
        const checkButton = document.getElementById('checkBtn');
        const messageArea = document.getElementById('deliveryMessage');

        // Listen for a click on the button
        checkButton.addEventListener('click', function () {
            // When the button is clicked, set the message
            // You can add logic here later to check the actual pincode
            messageArea.innerHTML = '<span class="text-success"><strong>Deliverable within 2 days</strong></span>';
        });
    });
</script>
    </body>
</html>
