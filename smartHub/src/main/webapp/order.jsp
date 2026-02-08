<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.*" %>
<%@ page import="com.org.DBConnection" %>

<%
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("logIn.jsp");
        return;
    }

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    List<Map<String, Object>> ordersList = new ArrayList<>();

    try {
        con = DBConnection.getConnection();
        String sql = "SELECT o.order_id, o.order_date, o.payment_method, o.payment_status, " +
                "o.order_status, o.total_amount, o.final_amount, o.discount_amount, " +
                "oi.product_id, oi.quantity, oi.mrp, oi.discount_price, oi.total_price, " +
                "p.prod_name, p.prod_img, p.prod_desc " +
                "FROM orders o " +
                "JOIN order_items oi ON o.order_id = oi.order_id " +
                "JOIN products p ON oi.product_id = p.prodId " +
                "WHERE o.user_id = ?";

        ps = con.prepareStatement(sql);
        ps.setInt(1, userId);
        rs = ps.executeQuery();

        while (rs.next()) {
            Map<String, Object> order = new HashMap<>();
            order.put("order_id", rs.getInt("order_id"));
            order.put("order_date", rs.getTimestamp("order_date"));
            order.put("payment_method", rs.getString("payment_method"));
            order.put("payment_status", rs.getString("payment_status"));
            order.put("order_status", rs.getString("order_status"));
            order.put("total_amount", rs.getDouble("total_amount"));
            order.put("final_amount", rs.getDouble("final_amount"));
            order.put("discount_amount", rs.getDouble("discount_amount"));
            order.put("prod_name", rs.getString("prod_name"));
            order.put("prod_desc", rs.getString("prod_desc"));
            order.put("prod_img", rs.getString("prod_img"));
            order.put("quantity", rs.getInt("quantity"));
            order.put("mrp", rs.getDouble("mrp"));
            order.put("discount_price", rs.getDouble("discount_price"));
            order.put("total_price", rs.getDouble("total_price"));
            ordersList.add(order);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (con != null) con.close();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Your Order - SmartHub</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" />
  <link rel="stylesheet" href="./CSS/style.css" />
  <!-- Keep your existing Apple-style CSS exactly as is -->
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

body {
	background-color: var(--apple-dark-bg) !important;
	color: var(--apple-text-primary); /* Use system font for Apple feel */
	font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
		"Helvetica Neue", Arial, sans-serif;
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

.nav-link:hover, .nav-link:focus,  {
	color: var(--apple-text-primary) !important;
}


.bi {
	font-size: 1.2rem;
}
	/* ---------------------------------- // Apple-Style Card (Order Item) // ---------------------------------- */
.apple-card {
	background-color: var(--apple-card-bg);
	backdrop-filter: blur(20px); /* Frosted glass effect */
	border-radius: 18px; /* Prominent rounded corners */
	padding: 24px;
	border: 1px solid var(--apple-border-color);
	box-shadow: 0 4px 16px rgba(0, 0, 0, 0.25); /* Subtle shadow */
	transition: transform 0.3s ease;
}

.apple-card:hover {
	transform: translateY(-2px); /* Subtle lift on hover */
}

.product-img-container {
	overflow: hidden;
	border-radius: 12px;
}

.product-img {
	width: 100%;
	height: auto;
	object-fit: cover;
	display: block;
}

.details-text {
	font-size: 0.85rem;
	color: var(--apple-text-secondary);
	margin-bottom: 2px;
}

.price-text {
	font-size: 1.5rem;
	font-weight: 700;
	color: var(--apple-text-primary);
}

.savings-text {
	font-size: 0.75rem;
	color: var(--apple-success-green);
	font-weight: 500;
}

.status-badge {
	display: inline-block;
	padding: 6px 12px;
	border-radius: 20px;
	font-size: 0.7rem;
	font-weight: 500;
	text-transform: uppercase;
	letter-spacing: 0.5px;
}

.status-processing {
	background-color: rgba(255, 149, 0, 0.2);
	/* Orange for pending/processing */
	color: #ff9500;
}

.status-delivered {
	background-color: rgba(52, 199, 89, 0.2); /* Green for delivered */
	color: var(--apple-success-green);
}
	/* ---------------------------------- // Action Button (Print/Invoice) // ---------------------------------- */
.apple-btn-primary {
	background-color: var(--apple-accent-blue);
	color: var(--apple-text-primary);
	border: none;
	border-radius: 12px;
	padding: 10px 20px;
	font-weight: 600;
	transition: background-color 0.2s, opacity 0.2s;
}

.apple-btn-primary:hover {
	background-color: #3498db;
}
	/* ---------------------------------- // Responsiveness (Apple-style stack) // ---------------------------------- */
	/* Mobile (sm and down) */
@media ( max-width : 767.98px) {
	.apple-card {
		padding: 16px;
	}
	.apple-card .row>div {
		margin-bottom: 12px; /* Add vertical spacing for stacked elements */
		text-align: left !important;
	}
	.apple-card .col-md-2.text-center {
		text-align: left !important;
		/* Align text left for better readability on mobile */
	}
	.product-img-container {
		width: 80px; /* Small image for mobile */
		height: 80px;
		margin-right: 15px;
		float: left; /* Image float for a side-by-side look */
	}
	.product-details-mobile-wrap {
		overflow: hidden; /* Clear float */
	} /* Group status and date/price for better flow */
	.order-status-group, .order-price-group {
		border-top: 1px solid var(--apple-border-color);
		padding-top: 12px;
		margin-top: 8px;
	}
} /* Tablet (md) adjustments */
@media ( min-width : 768px) and (max-width: 991.98px) {
	.apple-card {
		padding: 20px;
	}
} /* Custom styles from original, simplified for clean Apple UI */
.quantity-group, .quantity-btn, .quantity-input {
	/* Not strictly needed for an *order* page, but kept for context */
	display: none;
}
</style>
</head>

<body class="bg-dark">
  <!-- Navbar (unchanged) -->
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
            <li class="nav-item px-2"><a class="nav-link active" href="#"><i class="bi bi-card-checklist" data-bs-toggle="tooltip" data-bs-placement="bottom" 
     						title="orders"></i></a></li>
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

  <section class="container my-5">
    <div class=" d-flex flex-wrap align-items-center  mb-1">
        <h2>Your Orders</h2>
    </div>
    <hr />

    <%
      if (ordersList.isEmpty()) {
    %>
        <div class="text-center text-secondary mt-5">
            <h4>No orders found yet.</h4>
            <a href="shop.jsp" class="btn btn-primary mt-3">Continue Shopping</a>
        </div>
    <%
      } else {
          SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy");
          for (Map<String, Object> order : ordersList) {
              Timestamp orderDate = (Timestamp) order.get("order_date");
              Calendar cal = Calendar.getInstance();
              cal.setTime(orderDate);
              cal.add(Calendar.DATE, 2);
              String deliveryDate = sdf.format(cal.getTime());
    %>

    <div class="apple-card mb-4">
      <div class="row align-items-center">
        <div class="col-12 col-md-5 d-flex align-items-start">
          <div class="product-img-container me-4" style="width: 100px; height: 100px;">
            <img src="<%= order.get("prod_img") %>" class="img-fluid rounded col-lg-8" alt="Product Image">
          </div>
          <div class="product-details-mobile-wrap">
            <h5 class="text-white"><%= order.get("prod_name") %></h5>
            <p class="details-text mb-1"><%= order.get("prod_desc") %></p>
            <p class="details-text mb-0">Order ID: #SH0<%= order.get("order_id") %></p>
          </div>
        </div>

        <div class="col-12 col-md-3 order-status-group">
            <p class="details-text mb-1">Order Status:</p>
            <%
              String status = (String) order.get("order_status");
              String badgeClass = "status-processing";
              if ("Delivered".equalsIgnoreCase(status)) badgeClass = "status-delivered";
            %>
            <span class="status-badge <%= badgeClass %>"><%= status %></span>
            <p class="details-text mt-2 mb-0">Order Date: <span style="color: var(--apple-text-primary);"><%= sdf.format(orderDate) %></span></p>
        </div>

        <div class="col-12 col-md-2 text-center text-md-start">
            <p class="details-text mb-1">Payment: <%= order.get("payment_method") %></p>
            <% if ("Delivered".equalsIgnoreCase(status)) { %>
                <p class="details-text mb-0">Delivered on <%= deliveryDate %></p>
            <% } else { %>
                <p class="details-text mb-0">Estimated delivery by <br> <%= deliveryDate %></p>
            <% } %>
            <p class="details-text text-success mb-0" style="font-weight: 500;">Free Standard Shipping</p>
        </div>

        <div class="col-12 col-md-2 text-center text-md-end order-price-group">
          <p class="price-text mb-0">₹<%= order.get("total_price") %></p>
          <%
            double mrp = (Double) order.get("mrp");
            double discount = mrp - (Double) order.get("discount_price");
            if (discount > 0) {
          %>
              <p class="savings-text mt-1">You saved ₹<%= String.format("%.2f",(discount)) %></p>
          <% } else { %>
              <p class="savings-text mt-1" style="color: var(--apple-text-secondary);">No eligible offers</p>
          <% } %>
        </div>
      </div>
    </div>
    <%
          } // end for
      } // end else
    %>

   
  </section>


  <footer class="footer py-4 text-center">
    <div class="container">
      <div class="mb-3">
        <a class="nav-link d-inline-block mx-2" href="#">About Us</a> 
        <a class="nav-link d-inline-block mx-2" href="#">Contact</a> 
        <a class="nav-link d-inline-block mx-2" href="#">Policies</a>
      </div>
      <div class="social-icons mb-3">
        <a class="nav-link d-inline-block mx-2" href="#"><i class="bi bi-facebook"></i></a>
        <a class="nav-link d-inline-block mx-2" href="#"><i class="bi bi-twitter-x"></i></a>
        <a class="nav-link d-inline-block mx-2" href="#"><i class="bi bi-instagram"></i></a>
      </div>
      <p class="details-text mb-0">&copy; 2026 smartHub. All Rights Reserved.</p>
    </div>
  </footer>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
